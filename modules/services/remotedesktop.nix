{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.services.remotedesktop;
in {
  options.modules.services.remotedesktop = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {

    services.xrdp.enable = true;
    services.xrdp.defaultWindowManager = "startplasma-x11";
    networking.firewall.allowedTCPPorts = [ 3389 5900 ];


    environment.systemPackages = mkIf (config.modules.desktop.plasma.enable) [
        pkgs.krfb
        pkgs.krdc
    ];

  };
}
