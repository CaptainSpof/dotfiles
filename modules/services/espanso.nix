{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.services.espanso;
in {
  options.modules.services.espanso = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      espanso
    ];

    systemd.user.services.espanso = {
      enable = true;
      description = "Espanso daemon";
      path = with pkgs; [ espanso libnotify xclip ];
      serviceConfig = {
        ExecStart = "${pkgs.espanso}/bin/espanso daemon";
        # Restart = "on-failure";
        Restart = "always";
        RestartSec = "10";
      };

      wantedBy = [ "graphical-session.target" ];
    };
  };
}
