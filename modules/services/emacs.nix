{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.services.emacs;
in {
  options.modules.services.emacs = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    services = {
      emacs = {
        enable = true;
      };
    };
  };
}
