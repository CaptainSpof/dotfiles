{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.apps.office.libreoffice;
in {
  options.modules.desktop.apps.office.libreoffice = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs;
      (if config.modules.desktop.plasma.enable then [
        locked.libreoffice-qt
      ] else [
        locked.libreoffice
      ]);
  };
}
