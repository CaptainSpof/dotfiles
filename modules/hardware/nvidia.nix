{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.hardware.nvidia;
in {
  options.modules.hardware.nvidia = {
    enable = mkBoolOpt false;
    prime.enable = mkBoolOpt false;
    prime.nvidiaBusId = mkOption {
      type = types.str;
      default = "PCI:1:0:0";
    };
    prime.intelBusId = mkOption {
      type = types.str;
      default = "PCI:0:2:0";
    };
  };

  config = mkIf cfg.enable {
    hardware.opengl.enable = true;

    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia.prime = mkIf cfg.prime.enable {
      offload.enable =  true;
      nvidiaBusId = cfg.prime.nvidiaBusId;
      intelBusId = cfg.prime.intelBusId;
    };

    environment.systemPackages = with pkgs; [
      # Respect XDG conventions, damn it!
      (writeScriptBin "nvidia-settings" ''
        #!${stdenv.shell}
        mkdir -p "$XDG_CONFIG_HOME/nvidia"
        exec ${config.boot.kernelPackages.nvidia_x11.settings}/bin/nvidia-settings --config="$XDG_CONFIG_HOME/nvidia/settings"
      '')
    ];
  };
}
