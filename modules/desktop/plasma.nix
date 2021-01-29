{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.plasma;
in {
  options.modules.desktop.plasma = {
    enable = mkBoolOpt false;
    polybar.enable = mkBoolOpt false;
    sxhkd.enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {

    environment.systemPackages = with pkgs; [

      (mkIf (config.modules.desktop.plasma.polybar.enable) (polybar.override {
        pulseSupport = true;
        nlSupport = true;
      }))

      # FIXME: Do I really need that? I mean, nix being lazy and such, I don't need to explicitly add it here... I think.
      (mkIf (config.modules.desktop.plasma.sxhkd.enable) sxhkd)

      (mkIf config.services.syncthing.enable syncthingtray)

      ark                        # archiver
      elisa                      # music player
      filelight                  # disk analysis
      gwenview                   # image viewer
      kate                       # text editor, mainly if the pleb need to edit text on my machine
      kcharselect                # a tool to select weird characters, like: ⁂※🜂🜎❋❀
      kdeplasma-addons           # the f🦖ck if I know
      kid3                       # edit metadata
      kinfocenter                # the f🦖ck if I know
      latte-dock                 # a pretty dock
      libnotify                  # just a random dep to send notification
      okular                     # pdf viewer
      partition-manager          # gparted, buy Qt
      plasma-browser-integration # integration with krunner and other stuff
      plasma-integration         # integrate stuff, I guess...
      qbittorrent                # 🌊⛵
      sddm-kcm
      yakuake                    # drop down terminal
    ];

    services = {
      xserver = {
        enable = true;
        displayManager = {
          sddm.enable = true;
        };
        desktopManager.plasma5.enable = true;
      };
    };

    systemd.user.services.sxhkd = mkIf (config.modules.desktop.plasma.sxhkd.enable) {
      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];

      serviceConfig = {
        ExecStart = "${pkgs.sxhkd}/bin/sxhkd";
      };
    };

    home.configFile = {
      "autostart-scripts/ssh-add.sh" = {
        source = "${configDir}/plasma/autostart-scripts/ssh-add.sh";
      };
      "kglobalshortcutsrc" = {
        source = "${configDir}/plasma/kglobalshortcutsrc";
        recursive = true;
      };
      "touchpadxlibinputrc" = {
        source = "${configDir}/plasma/touchpadxlibinputrc";
        recursive = true;
      };
      "sxhkd/sxhkdrc" = mkIf (config.modules.desktop.plasma.sxhkd.enable) {
        source = "${configDir}/sxhkd/sxhkdrc_plasma";
      };
      "arkrc" = {
        source = "${configDir}/plasma/arkrc";
      };
    };
  };
}
