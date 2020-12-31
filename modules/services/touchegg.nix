{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.services.touchegg;
in {
  options.modules.services.touchegg = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {

  services.touchegg = {
    enable = true;
    description = "touchegg, libinput and stuff. The Daemon.";
    wantedBy = [ "multi-user.target" ];
    serviceConfig.Type = "simple";
    serviceConfig.Group = "input";
    serviceConfig.Restart = "on-failure";
    serviceConfig.RestartSec = 5;
    serviceConfig.ExecStart = "/usr/bin/touchegg --daemon";
  };

    environment.systemPackages = with pkgs; [
      touchegg
    ];

  };
}
