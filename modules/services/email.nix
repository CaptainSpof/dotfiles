{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.services.email;
in {
  options.modules.services.email = { enable = mkBoolOpt false; };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      isync
      mu
    ];

    systemd.user.services.mbsync = {
      enable = true;
      description = "Run mbsync";
      path = with pkgs; [ gawk gnupg pass ];

      wantedBy = [ "default.target" ];
      after = [ "network.target" ];
      serviceConfig.ExecStart = "${pkgs.isync}/bin/mbsync -a";
    };
    systemd.user.timers.mbsync = {
      enable = true;
      description = "run mbsync every 5 minutes";
      timerConfig = {
        OnBootSec = "10m";
        OnUnitInactiveSec = "5m";
        Unit = "mbsync.service";
      };
    };

    # systemd.user.services.mu-server = {
    #   enable = true;
    #   description = "Run mu server";
    #   wantedBy = [ "default.target" ];
    #   after = [ "network.target" ];
    #   serviceConfig.ExecStart = "${pkgs.mu}/bin/mu server";
    # };

    # FIXME: service not worky
    # systemd.user = {

    #   services.mu = {
    #     description = "Mailbox synchronization";
    #     serviceConfig = {
    #       Type = "oneshot";
    #       ExecStart = "${pkgs.mu}/bin/mu server";
    #       # ExecStartPost = "${pkgs.mu}/bin/mu server";
    #     };
    #     path = with pkgs; [ gawk gnupg pass ];

    #     after = [ "network-online.target" "gpg-agent.service" ];
    #     wantedBy = [ "default.target" ];
    #   };

    # timers.mbsync = {
    #   description = "Mailbox synchronization";

    #   timerConfig = {
    #     OnCalendar = "*:0/5";
    #     Persistent = "true";
    #   };

    #   wantedBy = [ "timers.target" ];
    # };
  # };

  home.file = {
    ".mbsyncrc" = {
      source = "${configDir}/email/mbsyncrc";
      recursive = true;
    };
  };
};
}
