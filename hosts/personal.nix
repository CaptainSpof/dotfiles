{ config, lib, ... }:

with lib;
{
 networking.hosts =
   let hostConfig = {
         "192.168.0.24"  = [ "dafbox" ];
         # "192.168.1.3"  = [ "aka" ];
         # "192.168.1.10" = [ "kuro" ];
         # "192.168.1.11" = [ "shiro" ];
         # "192.168.1.12" = [ "midori" ];
       };
       hosts = flatten (attrValues hostConfig);
       hostName = config.networking.hostName;
   in mkIf (builtins.elem hostName hosts) hostConfig;

  ## Location config -- since Toronto is my 127.0.0.1
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
      kuro.id  = "4UJSUBN-V7LCISG-6ZE7SBN-YPXM5FQ-CE7CD2U-W4KZC7O-4HUZZSW-6DXAGQQ";
      shiro.id = "G4DUO25-AMQQIWS-SRZE5TJ-43CCQZJ-5ULEZBS-P2LMZZU-V5JA5CS-6X7RLQK";
      kiiro.id = "DPQT4XQ-Q4APAYJ-T7P4KMY-YBLDKLC-7AU5Y4S-VGT3DDT-TMZZEIX-GBA7DAM";
    };
    folders =
      let mkShare = name: devices: type: path: rec {
            inherit devices type path;
            watch = false;
            rescanInterval = 3600 * 4;
            enabled = lib.elem config.networking.hostname devices;
          };
      in {
        projects = mkShare "projects" [ "kuro" "shiro" ] "sendrecieve" "${config.user.home}/projects";
      };
  };
}
