{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.services.touchegg;
in {
  options.modules.services.touchegg = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {

    systemd.services.touchegg = {
      enable = true;
      description = "touchegg, libinput and stuff. The Daemon.";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "simple";
        Group = "input";
        Restart = "on-failure";
        RestartSec = 5;
        ExecStart = "/usr/bin/touchegg --daemon";
      };
    };

    systemd.user.services.touchegg = {
      script = ''
        /usr/bin/touchegg
      '';
      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
    };

    home.configFile = {
      "touchegg/touchegg.conf" = {
        source = "${configDir}/touchegg/touchegg.conf";
        recursive = true;
      };
    };
  };
}
