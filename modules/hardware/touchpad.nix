{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.hardware.touchpad;
in {
  options.modules.hardware.touchpad = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    services.xserver.libinput = {
      enable = true;
      touchpad = {
        naturalScrolling = true;
        disableWhileTyping = true;
      };
    };
  };
}
