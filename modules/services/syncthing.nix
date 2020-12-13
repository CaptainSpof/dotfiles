{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.services.syncthing;
in {
  options.modules.services.syncthing = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    services = {
      syncthing = {
        enable = true;
        user = config.user.name;
        # TODO: maybe there's a better way to get the configDir path
        dataDir = "${homeDir}/Documents";
        configDir = "${homeDir}/.config/syncthing";
      };
    };
  };
}
