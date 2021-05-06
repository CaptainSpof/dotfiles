{config, options, pkgs, lib, ...}:

with lib;
with lib.my;
let cfg = config.modules.hardware.yubikey;
in {
  options.modules.hardware.yubikey = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {

    environment.systemPackages = with pkgs; [
      gnupg
      yubikey-personalization
      yubioath-desktop
      pinentry-gtk2
    ];

    services.udev.packages = [ pkgs.yubikey-personalization ];
    services.pcscd.enable = true;

  };
}
