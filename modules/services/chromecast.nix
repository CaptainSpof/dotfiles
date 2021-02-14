{ config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.services.chromecast;
in {

  options.modules.services.chromecast = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    # REVIEW: is this needed ?
    services.avahi.enable = true;
    # REVIEW: That's a whole lotta port here.
    networking.firewall.allowedUDPPortRanges = [ { from = 32768; to = 60999; } ];
    networking.firewall.allowedTCPPortRanges = [ { from = 8008; to = 8010; } ];
  };
}
