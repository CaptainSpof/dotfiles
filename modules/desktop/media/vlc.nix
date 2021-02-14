{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.media.vlc;
in {
  options.modules.desktop.media.vlc = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      castnow
      vlc
      # TODO: Move to own module
      youtubeDL
    ];
  };
}
