{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.services.ssh;
in {
  options.modules.services.ssh = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
      challengeResponseAuthentication = false;
      passwordAuthentication = false;
    };

    # TODO: add own keys
    user.openssh.authorizedKeys.keys =
      if config.user.name == "daf"
      then [ ]
      else [];

    environment.systemPackages = with pkgs; [
      connect
      sshpass
    ];
  };
}
