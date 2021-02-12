# Plasma. I used to be an adventurer and play arround with tilling window manager...
# But then I realize that plasma was nice enough for me.
#
# FIXME: I experienced weird flickering with opengl vsync, so just deactive it, I guess.
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

      # I don't really need that, most of those apps comes by default with plasma / kde. But it helps me remember what they are.
      ark                        # archiver
      elisa                      # music player
      filelight                  # disk analysis
      qview                      # image viewer, but prettier
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
      sddm-kcm                   # add a useless entry in systemsettings, but it felt empty without it
      yakuake                    # quake style drop down terminal
      # my.parachute
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

    # I hate this. Plasma configuration's files are all over the place. And they act weird.
    # touchpadxlibinputrc is a wild beast. I manage it mostly with xserver.libinput attributes.
    home.configFile = {
      "autostart/yakuake.desktop" = {
        source = "${configDir}/plasma/autostart/yakuake.desktop";
      };
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
