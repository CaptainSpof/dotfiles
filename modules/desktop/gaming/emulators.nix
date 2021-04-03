{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.gaming.emulators;
in {
  options.modules.desktop.gaming.emulators = {
    psx.enable  = mkBoolOpt false;  # Playstation
    ds.enable   = mkBoolOpt false;  # Nintendo DS
    ds3d.enable = mkBoolOpt false;  # Nintendo 3DS
    switch.enable = mkBoolOpt false;  # Nintendo Switch
    gb.enable   = mkBoolOpt false;  # GameBoy + GameBoy Color
    gba.enable  = mkBoolOpt false;  # GameBoy Advance
    snes.enable = mkBoolOpt false;  # Super Nintendo
  };

  config = {
    user.packages = with pkgs.unstable; [
      (mkIf cfg.psx.enable epsxe)
      (mkIf cfg.ds.enable desmume)
      (mkIf cfg.ds3d.enable citra)
      (mkIf cfg.switch.enable yuzu-ea)
      (mkIf (cfg.gba.enable ||
             cfg.gb.enable  ||
             cfg.snes.enable)
        higan)
      # unstable.yuzu
    ];
  };
}
