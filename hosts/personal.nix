{ config, lib, ... }:

with lib;
{
 networking.hosts =
   let hostConfig = {
         "192.168.0.24"  = [ "dafbox" ];
         "192.168.0.49"  = [ "daftop" ];
       };
       hosts = flatten (attrValues hostConfig);
       hostName = config.networking.hostName;
   in mkIf (builtins.elem hostName hosts) hostConfig;

  ## Location config -- since Paris is my 127.0.0.1
  time.timeZone = mkDefault "Europe/Paris";
  i18n.defaultLocale = mkDefault "en_US.UTF-8";
  # For redshift, mainly
  # FIXME: Find latitude longitude for Nanterre
  location = (if config.time.timeZone == "Europe/Nanterre" then {
    latitude = 48.85;
    longitude = 2.29;
  } else if config.time.timeZone == "Europe/Paris" then {
    latitude = 48.85;
    longitude = 2.29;
  } else {});

  ##
  # modules.shell.bitwarden.config.server = "p.v0.io";

  # FIXME: setup own id
  services.syncthing.declarative = {
    devices = {
      daftop.id   = "";
      dafbox.id   = "";
      dafphone.id = "";
      dafpi.id    = "";
    };
    # folders =
    #   let mkShare = name: devices: type: path: rec {
    #         inherit devices type path;
    #         watch = false;
    #         rescanInterval = 3600 * 4;
    #         enabled = lib.elem config.networking.hostname devices;
    #       };
    #   in {
    #     projects = mkShare "projects" [ "kuro" "shiro" ] "sendrecieve" "${config.user.home}/projects";
    #   };
  };
}
