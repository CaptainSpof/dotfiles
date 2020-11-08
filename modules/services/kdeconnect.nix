{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.services.kdeconnect;
in {
  options.modules.services.kdeconnect = {
    enable = mkBoolOpt false;
   };

   config = mkIf cfg.enable {
     networking.firewall.allowedTCPPorts = [ { from = 1714; to = 1764; ];
     networking.firewall.allowedUDPPorts = [ { from = 1714; to = 1764; ];

     environment.systemPackages = with pkgs; [
       kdeconnect
     ];

   };
};
