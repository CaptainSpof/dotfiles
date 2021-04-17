{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.hardware.logitech;
    configDir = config.dotfiles.configDir;
in {
  options.modules.hardware.logitech = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {

    # Packages

    environment.systemPackages = with pkgs; [
      my.logiops
    ];

    # Services

    systemd.services.logid = {
      enable = true;
      description = "Logitech Configuration Daemon.";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "simple";
        Restart = "on-failure";
        ExecStart = "${pkgs.my.logiops}/bin/logid -c ${configDir}/logitech/logid.cfg";
      };
    };

    # Config Files

    home.configFile = {
      "logitech/logid.cfg" = {
        source = "${configDir}/logitech/logid.cfg";
      };
    };

  };
}
