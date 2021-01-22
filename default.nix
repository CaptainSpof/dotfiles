{ inputs, config, lib, pkgs, ... }:

with lib;
with lib.my;
with inputs; {
  imports =
    # I use home-manager to deploy files to $HOME; little else
    [
      home-manager.nixosModules.home-manager
    ]
    # All my personal modules
    ++ (mapModulesRec' (toString ./modules) import);

  # Common config for all nixos machines; and to ensure the flake operates
  # soundly
  environment.variables.DOTFILES = dotFilesDir;

  # Configure nix and nixpkgs
  environment.variables.NIXPKGS_ALLOW_UNFREE = "1";

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    nixPath = [
      "nixpkgs=${nixpkgs}"
      "nixpkgs-unstable=${nixpkgs-unstable}"
      "nixpkgs-locked=${nixpkgs-locked}"
      "comma=${comma}"
      "nixpkgs-overlays=${dotFilesDir}/overlays"
      "home-manager=${home-manager}"
      "dotfiles=${dotFilesDir}"
    ];
    binaryCaches = [ "https://cache.nixos.org" "https://nix-community.cachix.org" "https://nixpkgs.cachix.org" ];
    binaryCachePublicKeys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nixpkgs.cachix.org-1:q91R6hxbwFvDqTSDKwDAV4T5PxqXGxswD8vhONFMeOE="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
    registry = {
      nixos.flake = nixpkgs;
      nixpkgs.flake = nixpkgs-unstable;
      nixpkgs-locked.flake = nixpkgs-locked;
    };
    useSandbox = true;
  };
  system.configurationRevision = mkIf (self ? rev) self.rev;
  system.stateVersion = "20.09";

  ## Some reasonable, global defaults
  # This is here to appease 'nix flake check' for generic hosts with no
  # hardware-configuration.nix or fileSystem config.
  fileSystems."/".device = "/dev/disk/by-label/nixos";

  # Use the latest kernel
  boot.kernelPackages = pkgs.linuxPackages_5_10;

  boot.loader = {
    efi.canTouchEfiVariables = mkDefault true;
    systemd-boot.configurationLimit = 10;
    systemd-boot.enable = mkDefault false;
    timeout = 3;
    grub = {
      enable = true;
      devices = [ "nodev" ];
      efiSupport = true;
      useOSProber = true;
      splashImage = "${configDir}/grub/background.png";
    };
  };

  # Just the bear necessities...
  environment.systemPackages = with pkgs; [
    cachix
    cached-nix-shell
    coreutils
    git
    vim
    wget
    gnumake
    unzip
  ];
}
