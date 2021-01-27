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
  location = {
    latitude = 48.85;
    longitude = 2.29;
  };
}
