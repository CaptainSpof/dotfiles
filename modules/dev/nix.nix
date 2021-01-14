# modules/dev/nix.nix --- http://zsh.sourceforge.net/
#
# Nix, I found that when running a NixOs system,
# we happen to come across nix quite often. I don't understand it,
# but it's nice to format it.

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
      nix-direnv
      nix-tree
      hydra-check
    ];
  };
}
