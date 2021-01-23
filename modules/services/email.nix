{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.services.email;
in {
  options.modules.services.email = { enable = mkBoolOpt false; };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      isync
      mu
    ];

    # TODO: need to copy mbsyncrc
    systemd.user = {

      services.mbsync = {
        description = "Mailbox synchronization";
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${pkgs.isync}/bin/mbsync -aq";
          ExecStartPost = "${pkgs.mu}/bin/mu server";
        };
        path = with pkgs; [ gawk gnupg pass mu ];

        after = [ "network-online.target" "gpg-agent.service" ];
        wantedBy = [ "default.target" ];
      };

      timers.mbsync = {
        description = "Mailbox synchronization";

        timerConfig = {
          OnCalendar = "*:0/5";
          Persistent = "true";
        };

        wantedBy = [ "timers.target" ];
      };
    };

    home.file = {
      ".mbsyncrc" = {
        source = "${configDir}/email/mbsyncrc";
        recursive = true;
      };
    };
  };
}
