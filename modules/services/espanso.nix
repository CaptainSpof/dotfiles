{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.services.espanso;
    configDir = config.dotfiles.configDir;
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
      path = with pkgs; [ espanso coreutils libnotify xclip ];
      serviceConfig = {
        # ExecStartPre = "${pkgs.coreutils}/bin/sleep 20";
        ExecStart = "${pkgs.espanso}/bin/espanso daemon";
        # Restart = "on-failure";
        Restart = "always";
        RestartSec = "10";
      };
      after = [ "keyboard-setup.service" ];
      wantedBy = [ "graphical-session.target" ];
    };

    # Config

    home.configFile = {
      "espanso/default.yml".source = "${configDir}/espanso/default.yml";
      # "espanso/user/emails.yml".source = "${configDir}/espanso/user/emails.yml";
    };

  };
}
