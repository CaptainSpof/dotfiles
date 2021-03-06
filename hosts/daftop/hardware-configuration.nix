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
    #      server/headless builds, but daftop isn't either. I'll prioritize raw
    #      performance over security here, though the gains are minor.
    kernelParams = [ "mitigations=off" ];
  };

  # Modules
  modules.hardware = {
    audio.enable = true;
    bluetooth = {
      enable = true;
      audio.enable = true;
    };
    fs = {
      enable = true;
      ssd.enable = true;
    };
    nvidia = {
      enable = false;
      prime.enable = false;
    };
    keyboard.enable = true;
    printer.enable = true;
    logitech.enable = true;
    sensors.enable = true;
    touchpad.enable = true;
    wacom.enable = true;
    # yubikey.enable = true;
  };

  # CPU
  nix.maxJobs = lib.mkDefault 8;
  hardware.cpu.intel.updateMicrocode = true;

  # Power management
  environment.systemPackages = [ pkgs.acpi ];
  # powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
  powerManagement.powertop.enable = true;
  services.tlp = {
    enable = true;
    settings = {
      USB_AUTOSUSPEND=-1;
    };
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_HWP_ON_AC = "performance";
    };
  };
  services.thermald.enable = true;
  # TODO: Move to own module.
  systemd.services = {
    tune-usb-autosuspend = {
      description = "Disable USB autosuspend";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = { Type = "oneshot"; };
      unitConfig.RequiresMountsFor = "/sys";
      script = ''
        echo -1 > /sys/module/usbcore/parameters/autosuspend
      '';
    };
  };

  # Video
  hardware.opengl.enable = true;
  services.xserver.videoDrivers = [ "intel" ];

  # Monitor backlight control
  programs.light.enable = true;
  user.extraGroups = [ "video" ];

  # File Systems
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
