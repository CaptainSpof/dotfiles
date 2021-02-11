# modules/desktop/media/graphics.nix
#
# The hardest part about switching to linux? Sacrificing Adobe. It really is
# difficult to replace and its open source alternatives don't *quite* cut it,
# but enough that I can do a fraction of it on Linux. For the rest I have a
# second computer dedicated to design work (and gaming).

{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.media.graphics;
in {
  options.modules.desktop.media.graphics = {
    enable         = mkBoolOpt false;
    tools.enable   = mkBoolOpt true;
    raster.enable  = mkBoolOpt true;
    vector.enable  = mkBoolOpt true;
    sprites.enable = mkBoolOpt true;
    xournalpp.enable = mkBoolOpt true;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs;

      (if cfg.tools.enable then [
        font-manager   # so many damned fonts...
        imagemagick    # for image manipulation from the shell
      ] else []) ++

      # replaces illustrator & indesign
      (if cfg.vector.enable then [
        inkscape
      ] else []) ++

      # Replaces photoshop
      (if cfg.raster.enable then [
        krita
        (makeDesktopItem {
          name = "krita-doodle";
          desktopName = "Krita Doodle";
          genericName = "Quick canvas to draw horrible ideas";
          icon = "krita";
          exec = "${krita}/bin/krita --nosplash --new-image RGBA,U16,2500,1200";
          categories = "Graphics";
        })
        # gimp
        # gimpPlugins.resynthesizer  # content-aware scaling in gimp
      ] else []) ++

      # Sprite sheets & animation
      (if cfg.sprites.enable then [
        aseprite-unfree
      ] else []) ++

      # Writes stuff
      (if cfg.xournalpp.enable then [
        xournalpp
      ] else []);

    home.configFile = mkIf cfg.raster.enable {
      "GIMP/2.10" = { source = "${configDir}/gimp"; recursive = true; };
    };
  };
}
