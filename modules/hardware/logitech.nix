{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.hardware.logitech;
in {
  options.modules.hardware.logitech = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {

    environment.systemPackages = with pkgs; [
      my.logiops
    ];

    systemd.services.logid = {
      enable = true;
      description = "Logitech Configuration Daemon.";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "simple";
        Restart = "on-failure";
        ExecStart = "${pkgs.my.logiops}/bin/logid";
      };
    };

  };
}
