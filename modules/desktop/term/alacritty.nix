# modules/desktop/term/alacritty.nix
#

{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.term.alacritty;
    configDir = config.dotfiles.configDir;
in {
  options.modules.desktop.term.alacritty = { enable = mkBoolOpt false; };

  config = mkIf cfg.enable {
    # xst-256color isn't supported over ssh, so revert to a known one
    modules.shell.zsh.rcInit = ''
      [ "$TERM" = xst-256color ] && export TERM=xterm-256color
    '';

    user.packages = with pkgs;
      [
        alacritty
      ];

    home.configFile = {
      "alacritty" = {
        source = "${configDir}/alacritty";
        recursive = true;
      };
    };
  };
}
