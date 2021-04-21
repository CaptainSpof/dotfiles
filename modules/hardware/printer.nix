# Cured is the poor soul who ventures here, this module won't work.
# Printers are cursed!
# Note to self: Do not fight it, use your phone.
# Heck, you're better off drawing whatever you want to print.

{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.hardware.printer;
in {
  options.modules.hardware.printer = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {


    # Like it's ever gonna work…
    services.printing.enable = true;

    # TODO: use a variable for when I finally trash this Canon $*#!
    services.printing.drivers = [ pkgs.canon-cups-ufr2 ];
  };
}
