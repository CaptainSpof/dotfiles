{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.services.nginx;
in {
  options.modules.services.nginx = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [ 80 443 ];

    user.extraGroups = [ "nginx" ];

    # Nginx reverse proxy
    services.nginx = {
      enable = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;
      recommendedOptimisation = true;
      recommendedGzipSettings = true;

      # Reduce the permitted size of client requests, to reduce the likelihood
      # of buffer overflow attacks. This can be tweaked on a per-vhost basis, as
      # needed.
      clientMaxBodySize = "128k";  # default 10m
      commonHttpConfig = ''
        client_body_buffer_size  4k;       # default: 8k
        large_client_header_buffers 2 4k;  # default: 4 8k
      '';


      # TODO: Move in own modules ?
      # Uses a DNS rewrite in AdGuard
      virtualHosts = {
        "daftop" = {
          # locations."/adguard".proxyPass = "http://localhost:1337";
          locations."/sync".proxyPass = "http://localhost:8384";
        };
        "sync.daf" = {
          locations."/".proxyPass = "http://localhost:8384";

          extraConfig = ''
        proxy_set_header        Host localhost;
      '';
        };
      };


      # DNS proxy to AdGuard
    #   appendConfig = ''
    # stream {
    #   server {
    #     listen 53 udp;
    #     proxy_pass localhost:1053;
    #   }
    # }
    # '';
    };

    # AdguardHome container
    # TODO: Move in own module.
    containers.adguard = {
      autoStart = false;

      config = { config, pkgs, ... }: {

        environment.systemPackages = with pkgs; [
          unstable.adguardhome
        ];

        systemd.services.adguardRunner = {
          description = "AdGuard Home";
          wantedBy = [ "multi-user.target" ];
          after = [ "multi-user.target" ];
          enable = true;

          serviceConfig = {
            ExecStart = "${pkgs.unstable.adguardhome}/bin/adguardhome -w /var/lib/adguard -h localhost -p 1337";
            Restart = "on-failure";
            StartLimitIntervalSec = "15";
            # Automatically creates and destroys user
            isNormalUser = true;
            # Automatically creates /var/lib/adguard
            StateDirectory = "adguard";
          };
        };
      };
    };
  };
}

# Helpful nginx snippets
#
# Set expires headers for static files and turn off logging.
#   location ~* ^.+\.(js|css|swf|xml|txt|ogg|ogv|svg|svgz|eot|otf|woff|mp4|ttf|r ss|atom|jpg|jpeg|gif|png|ico|zip|tgz|gz|rar|bz2|doc|xls|exe|ppt|tar|mid|midi|wav |bmp|rtf)$ {
#     access_log off; log_not_found off; expires 30d;
#   }
#
# Deny all attempts to access PHP Files in the uploads directory
#   location ~* /(?:uploads|files)/.*\.php$ {
#     deny all;
#   }
