# modules/dev/nix.nix --- http://zsh.sourceforge.net/
#
# Nix script programmers are strange beasts. Writing programs in a language
# that wasn't intended as a programming language. Alas, it is not for us mere
# mortals to question the will of the ancient ones. If they want nix programs,
# they get nix programs.

{ config, options, lib, pkgs, my, ... }:

with lib;
with lib.my;
let cfg = config.modules.dev.nix;
in {
  options.modules.dev.nix = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      nixfmt
    ];
  };
}
