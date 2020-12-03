{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.apps.chats.discord;
in {
  options.modules.desktop.apps.chats.discord = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      # If not installed from the bleeding edge, Discord will sometimes
      # soft-lock itself on a "there's an update for discord" screen.
      unstable.discord
    ];
  };
}
