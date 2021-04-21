{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let
  hwCfg = config.modules.hardware;
  cfg = hwCfg.bluetooth;
in {
  options.modules.hardware.bluetooth = {
    enable = mkBoolOpt false;
    audio.enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable (mkMerge [
    {
      hardware.bluetooth.enable = true;
    }

    (mkIf cfg.audio.enable {
      hardware.pulseaudio = {
        # NixOS allows either a lightweight build (default) or full build of
        # PulseAudio to be installed.  Only the full build has Bluetooth
        # support, so it must be selected here.
        package = pkgs.pulseaudioFull;
        # Enable additional codecs
        extraModules = [ pkgs.pulseaudio-modules-bt ];

        # HACK Fixes programs like Teamspeak and Teams that automatically switch bluetooth sources
        extraConfig = ''
          unload-module module-bluetooth-policy
        '';
      };
      hardware.bluetooth.settings = {
        General = { Enable = "Source,Sink,Media,Socket"; };
      };
    })
  ]);
}
