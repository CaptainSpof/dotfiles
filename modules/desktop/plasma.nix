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
      ark
      libnotify
      # latte-dock
      yakuake
      kdeFrameworks.kconfig
      kdeFrameworks.kconfigwidgets
      plasma5.plasma-integration
      plasma5.plasma-browser-integration
      kdeplasma-addons
      kcharselect
      # Media player
      # TODO: maybe move to own module ?
      vlc
    ];

    services = {
      xserver = {
        enable = true;
        displayManager = {
          sddm.enable = true;
          lightdm.greeters.mini.enable = false;
        };
        desktopManager.plasma5.enable = true;
      };
    };
    
    home.configFile = {
      "touchpadxlibinputrc" = {
        source = "${configDir}/touchpadxlibinputrc";
        recursive = true;
      };
    };
  };
}
