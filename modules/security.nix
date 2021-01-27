{ config, lib, ... }:

with lib;
{
  ## System security tweaks
  boot.tmpOnTmpfs = true;
  security.hideProcessInformation = true;
  security.protectKernelImage = true;

  security.pam.services.kwallet = mkIf (config.modules.desktop.plasma.enable) {
    name = "kwallet";
    enableKwallet = true;
  };

  # Fix a security hole in place for backwards compatibility. See desc in
  # nixpkgs/nixos/modules/system/boot/loader/systemd-boot/systemd-boot.nix
  boot.loader.systemd-boot.editor = false;

  # Change me later!
  user.initialPassword = "nix";
  users.users.root.initialPassword = "nix";
}
