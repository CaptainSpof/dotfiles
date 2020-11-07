# modules/desktop/term/alacritty.nix
#

{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.term.alacritty;
in {
  options.modules.desktop.term.alacritty = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    # xst-256color isn't supported over ssh, so revert to a known one
    modules.shell.zsh.rcInit = ''
      [ "$TERM" = xst-256color ] && export TERM=xterm-256color
    '';

    user.packages = with pkgs; [
      alacritty
      # (makeDesktopItem {
      #   name = "xst";
      #   desktopName = "Suckless Terminal";
      #   genericName = "Default terminal";
      #   icon = "utilities-terminal";
      #   exec = "${xst}/bin/xst";
      #   categories = "Development;System;Utility";
      # })
    ];

    home.configFile = {
      "alacritty".source = "${configDir}/alacritty";
    };
  };
}
