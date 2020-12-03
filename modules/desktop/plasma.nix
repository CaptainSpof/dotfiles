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
      # TODO: Move out of plasma
      # kdeconnect
      kdeFrameworks.kconfig
      kdeFrameworks.kconfigwidgets
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

    # allow port for kdeconnect
    # networking.firewall.allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
    # networking.firewall.allowedUDPPortRanges = [ { from = 1714; to = 1764; } ];
  };

}
