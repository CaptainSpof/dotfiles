{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.services.touchegg;
in {
  options.modules.services.touchegg = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {

    # FIXME: the derivation already provide this service file. I need to figure out how to enable it.
    systemd.services.touchegg = {
      enable = true;
      description = "Touchégg. The daemon.";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "simple";
        Group = "input";
        Restart = "on-failure";
        RestartSec = 5;
        # FIXME: how to link to a user derivation ?
        # maybe, I should declare a touchegg variable with let and use that here ?
        ExecStart = "/usr/bin/touchegg --daemon";
      };
    };

    # REVIEW: Don't need that, xdg/autostart does that for us.
    # But I noticed touchegg segfaulting on some occasion.
    # This service restart it when it happen.
    systemd.user.services.touchegg-client = {
      description = "Touchégg. The client.";

      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];

      serviceConfig = {
        Restart = "on-failure";
        # FIXME: I'm ugly.
        ExecStart = "/home/daf/.nix-profile/bin/touchegg";
      };
    };

    home.configFile = {
      "touchegg/touchegg.conf" = {
        source = "${configDir}/touchegg/touchegg.conf";
        recursive = true;
      };
    };
  };
}
