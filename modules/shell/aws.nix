{ config, options, pkgs, lib, ... }:

with lib;
with lib.my;
let cfg = config.modules.shell.aws;
in {
  options.modules.shell.aws = with types; {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {

    user.packages = with pkgs; [
      awscli2
      aws-vault
    ];
  };
}
