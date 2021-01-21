{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.services.email;
in {
  options.modules.services.email = { enable = mkBoolOpt false; };

  config = mkIf cfg.enable {
    users.users.git = {
      useDefaultShell = true;
      home = "/var/lib/email";
      group = "email";
    };

    systemd.user = {
      services.mbsync = {
        description = "Mailbox syncronization";
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${pkgs.isync}/bin/mbsync -aq";
        };
        path = with pkgs; [ gawk gnupg pass ];

        after = [ "network-online.target" "gpg-agent.service" ];
        wantedBy = [ "default.target" ];
      };

      timers.mbsync = {
        description = "Mailbox syncronization";

        timerConfig = {
          OnCalendar = "*:0/2";
          Persistent = "true";
        };

        wantedBy = [ "timers.target" ];
      };
    };
  };
}
