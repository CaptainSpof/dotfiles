{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.apps.chats.telegram;
in {
  options.modules.desktop.apps.chats.telegram = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      unstable.tdesktop
    ];
  };
}
