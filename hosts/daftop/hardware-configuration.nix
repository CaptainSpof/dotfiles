# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {
    initrd.availableKernelModules =
      [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
    initrd.kernelModules = [ "dm-snapshot" ];
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
    # HACK Disables fixes for spectre, meltdown, L1TF and a number of CPU
    #      vulnerabilities. This is not a good idea for mission critical or
    #      server/headless builds, but on my lonely home system I prioritize raw
    #      performance over security.  The gains are minor.
    kernelParams = [ "mitigations=off" ];
  };

  # CPU
  nix.maxJobs = lib.mkDefault 8;
  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";
  hardware.cpu.intel.updateMicrocode = true;

  # Power management
  environment.systemPackages = [ pkgs.acpi ];
  powerManagement.powertop.enable = true;
  services.tlp.enable = true;
  services.thermald.enable = true;
  # Monitor backlight control
  programs.light.enable = true;
  user.extraGroups = [ "video" ];

  services.xserver.videoDrivers = [ "intel" ];

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-label/home";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/5381-08C2";
    fsType = "vfat";
  };

  swapDevices = [ ];
}
