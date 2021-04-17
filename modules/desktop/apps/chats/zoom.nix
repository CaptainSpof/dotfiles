{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.apps.chats.zoom;
in {
  options.modules.desktop.apps.chats.zoom = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      zoom-us
    ];
  };
}
