{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.media.video;
in {
  options.modules.desktop.media.video = {
    enable               = mkBoolOpt true;
    castnow.enable       = mkBoolOpt false;
    kdenlive.enable      = mkBoolOpt false;
    mpv.enable           = mkBoolOpt false;
    mpv.celluloid.enable = mkBoolOpt false;
    recording.enable     = mkBoolOpt false;
    vlc.enable           = mkBoolOpt false;
    youtube-dl.enable    = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs;
      (if cfg.mpv.enable then [
        mpv-with-scripts
        mpvc
        (mkIf cfg.mpv.celluloid.enable
          celluloid)  # nice GTK GUI for mpv
      ] else []) ++
      [
        (mkIf cfg.castnow.enable castnow)
        (mkIf cfg.kdenlive.enable kdenlive)
        (mkIf cfg.recording.enable obs-studio)
        (mkIf cfg.vlc.enable vlc)
        (mkIf cfg.youtube-dl.enable youtubeDL)
      ];
  };
}
