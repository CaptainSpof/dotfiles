{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.plasma;
in {
  options.modules.desktop.plasma = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {

    environment.systemPackages = with pkgs; [
      libnotify
      # latte-dock
      yakuake
      kdeFrameworks.kconfig
      kdeFrameworks.kconfigwidgets
    ];

    services = {
      xserver = {
        enable = true;
        displayManager = {
          lightdm.enable = true;
          lightdm.greeters.mini.enable = false;
        };
        desktopManager.plasma5.enable = true;
      };
    };
    
    home.configFile = {
      "touchpadxlibinputrc" = {
        source = "${configDir}/touchpadxlibinputrc";
      };
    };
  };
}
