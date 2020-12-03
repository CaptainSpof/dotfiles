{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.apps.teamspeak;
in {
  options.modules.desktop.apps.chats.teamspeak = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      unstable.teamspeak_client
    ];
  };
}
