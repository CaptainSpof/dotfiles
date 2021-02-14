{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.media.audio;
in {
  options.modules.desktop.media.audio = {
    enable               = mkBoolOpt true;
    ncmpcpp.enable       = mkBoolOpt false;
    spotify.enable       = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs;
      [
        (mkIf cfg.ncmpcpp.enable  (ncmpcpp.override { visualizerSupport = true; }))
        (mkIf cfg.spotify.enable spotify)
      ];

    env.NCMPCPP_HOME = mkIf (cfg.ncmpcpp.enable) "$XDG_CONFIG_HOME/ncmpcpp";

    # Symlink these one at a time because ncmpcpp writes other files to
    # ~/.config/ncmpcpp, so it needs to be writeable.
    home.configFile = mkIf (cfg.ncmpcpp.enable) {
      "ncmpcpp/config".source   = "${configDir}/ncmpcpp/config";
      "ncmpcpp/bindings".source = "${configDir}/ncmpcpp/bindings";
    };
  };
}
