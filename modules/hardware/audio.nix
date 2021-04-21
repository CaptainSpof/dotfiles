{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.hardware.audio;
in {
  options.modules.hardware.audio = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    sound.enable = true;

    # Not strictly required but pipewire will use rtkit if it is present
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
    };

    # hardware.pulseaudio = {
    #   enable = true;
    #   # HACK Prevents ~/.esd_auth files by disabling the esound protocol module
    #   #      for pulseaudio, which I likely don't need. Is there a better way?
    #   configFile =
    #     let inherit (pkgs) runCommand pulseaudio;
    #         paConfigFile =
    #           runCommand "disablePulseaudioEsoundModule"
    #             { buildInputs = [ pulseaudio ]; } ''
    #             mkdir "$out"
    #             cp ${pulseaudio}/etc/pulse/default.pa "$out/default.pa"
    #             sed -i -e 's|load-module module-esound-protocol-unix|# ...|' "$out/default.pa"
    #           '';
    #     in mkIf config.hardware.pulseaudio.enable
    #       "${paConfigFile}/default.pa";
    # };

    user.extraGroups = [ "audio" ];
  };
}
