# modules/themes/lightly/default.nix --- a breeze fork theme

{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.theme;
in {
  config = mkIf (cfg.active == "lightly") (mkMerge [
    # Desktop-agnostic configuration
    {

      system.userActivationScripts.installFirefoxBlurredTheme.text = ''
        if [ ! -d $HOME/.mozilla/firefox/daf.default/chrome ]; then
        ${pkgs.git}/bin/git clone https://github.com/manilarome/blurredfox $HOME/.mozilla/firefox/daf.default/chrome
        fi
      '';
      modules = {
        theme = {
          gtk = {
            theme = "Breeze";
            iconTheme = "Qogir";
            cursorTheme = "Breeze";
          };
        };

        shell.zsh.rcFiles  = mkIf cfg.prompt.enable [ ./config/zsh/prompt.zsh ];
        shell.tmux.rcFiles = [ ./config/tmux.conf ];
        # desktop.browsers = mkIf cfg.browsersTheme.enable {

        # firefox.userChrome = concatMapStringsSep "\n" readFile [
        #   ./config/firefox/userChrome.css
        # ];
        # qutebrowser.userStyles = concatMapStringsSep "\n" toCSSFile [
        #   ./config/qutebrowser/github.scss
        #   ./config/qutebrowser/monospace-textareas.scss
        #   ./config/qutebrowser/quora.scss
        #   ./config/qutebrowser/stackoverflow.scss
        #   ./config/qutebrowser/xkcd.scss
        #   ./config/qutebrowser/youtube.scss
        # ];
        # };
      };
    }

    # Desktop (X11) theming
    (mkIf config.services.xserver.enable {
      user.packages = with pkgs; [
        my.lightly-qt5
        unstable.qogir-theme
        my.qogir-icon-theme
      ];
      fonts = {
        fonts = with pkgs; [
          fira-code
          fira-code-symbols
          siji
          font-awesome-ttf
          (nerdfonts.override { fonts = [ "JetBrainsMono" "RobotoMono" ]; })
        ];
        fontconfig.defaultFonts = {
          sansSerif = ["Fira Sans"];
          monospace = ["Fira Code"];
        };
      };

      # Compositor
      services.picom = mkIf (!config.modules.desktop.plasma.enable) {
        fade = true;
        fadeDelta = 1;
        fadeSteps = [ 0.01 0.012 ];
        shadow = true;
        shadowOffsets = [ (-10) (-10) ];
        shadowOpacity = 0.22;
        # activeOpacity = "1.00";
        # inactiveOpacity = "0.92";
        settings = {
          shadow-radius = 12;
          # blur-background = true;
          # blur-background-frame = true;
          # blur-background-fixed = true;
          blur-kern = "7x7box";
          blur-strength = 320;
        };
      };

      # Other dotfiles
      home.configFile = with config.modules; mkMerge [
        {
          # Sourced from sessionCommands in modules/themes/default.nix
          "xtheme/90-theme".source = ./config/Xresources;
        }
        (mkIf desktop.bspwm.enable {
          "bspwm/rc.d/polybar".source = ./config/polybar/run.sh;
          "bspwm/rc.d/theme".source = ./config/bspwmrc;
        })
        (mkIf desktop.apps.rofi.enable {
          "rofi/theme" = { source = ./config/rofi; recursive = true; };
        })
        (mkIf (desktop.bspwm.enable || desktop.stumpwm.enable) {
          "polybar" = { source = ./config/polybar; recursive = true; };
          "dunst/dunstrc".source = ./config/dunstrc;
        })
        (mkIf desktop.media.graphics.vector.enable {
          "inkscape/templates/default.svg".source = ./config/inkscape/default-template.svg;
        })
      ];
    })
  ]);
}
