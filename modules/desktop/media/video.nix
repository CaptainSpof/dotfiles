{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.media.video;
in {
  options.modules.desktop.media.video = {
    enable            = mkBoolOpt false;
    castnow.enable    = mkBoolOpt false;
    kdenlive.enable   = mkBoolOpt false;
    mpv.enable        = mkBoolOpt false;
    recording.enable  = mkBoolOpt false;
    vlc.enable        = mkBoolOpt false;
    youtube-dl.enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      (mkIf cfg.castnow.enable castnow)
      (mkIf cfg.kdenlive.enable kdenlive)
      (mkIf cfg.mpv.enable mpv-with-scripts mpvc)
      (mkIf cfg.recording.enable obs-studio)
      (mkIf cfg.vlc.enable vlc)
      (mkIf cfg.youtube-dl.enable youtubeDL)
    ];
  };
}
