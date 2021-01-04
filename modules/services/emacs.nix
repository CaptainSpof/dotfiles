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
      wantedBy = [ "default.target" ];

      script = ''
        /etc/profiles/per-user/daf/bin/emacs --daemon
      '';
    };
  };
}
