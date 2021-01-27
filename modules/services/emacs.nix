# Emacs daemon
# but it's not gcc emacs, so that's not really useful.
{ options, config, lib, pkgs, inputs, ... }:

with lib;
with lib.my;
let cfg = config.modules.services.emacs;
in {
  options.modules.services.emacs = {
    enable = mkBoolOpt true;
  };

  config = mkIf cfg.enable {

    nixpkgs.overlays = [ inputs.emacs-overlay.overlay ];
    systemd.user.services.emacs = {
      description = "Emacs Daemon";
      environment.GTK_DATA_PREFIX = config.system.path;
      environment.SSH_AUTH_SOCK = "%t/ssh-agent";
      environment.GTK_PATH = "${config.system.path}/lib/gtk-3.0:${config.system.path}/lib/gtk-2.0";
      environment.NIX_PROFILES = "${concatStringsSep " " (reverseList config.environment.profiles)}";

      wantedBy = [ "default.target" ];
      serviceConfig = {
        Type = "forking";
        ExecStart = "/${pkgs.emacsPgtkGcc}/bin/emacs --daemon && ${pkgs.emacsPgtkGcc}/bin/emacsclient -c --eval (delete-frame)";
        ExecStop= "${pkgs.emacsPgtkGcc}/bin/emacsclient --no-wait --eval (progn (setq kill-emacs-hook nil) (kill emacs))";
        Restart = "on-failure";
      };
    };
  };
}
