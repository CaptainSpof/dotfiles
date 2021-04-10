{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.hardware.keyboard;
in {
  options.modules.hardware.keyboard = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    services.xserver = {
      layout = "fr";
      xkbVariant = "bepo";
      # TODO: find a way to replace caps lock with ctrl (not swapping). Also, single press should be esc.
      xkbOptions = "caps:escape";
    };
  };
}
