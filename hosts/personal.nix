{ config, lib, ... }:

with lib;
{
 networking.hosts =
   let hostConfig = {
         "192.168.0.29" = [ "dafphone" ];
         "192.168.0.30" = [ "daftop" ];
         "192.168.0.31" = [ "dafbox" ];
         "192.168.0.33" = [ "dafpi" ];
         "192.168.0.35" = [ "dafpihole" ];
         "127.0.0.1"    = [ "sync.daf" "pihole.daf" ];
       };
       hosts = flatten (attrValues hostConfig);
       hostName = config.networking.hostName;
   in mkIf (builtins.elem hostName hosts) hostConfig;

  ## Location config -- since Paris is my 127.0.0.1
  time.timeZone = mkDefault "Europe/Paris";
  i18n.defaultLocale = mkDefault "en_US.UTF-8";
  # For redshift, mainly
  location = {
    latitude = 48.85;
    longitude = 2.29;
  };

  ##
  # modules.shell.bitwarden.config.server = "p.v0.io";

  services.syncthing.declarative = {
    devices = {
      daftop.id   = "KQZGBVD-2EPBFMT-MPLIPPX-3BX5YZJ-TMKBFRF-ILXVVBR-RRJ35VN-T3ZYLQE";
      dafbox.id   = "FOJGG2U-XU4C6C6-JARCMV5-5OMEO6P-JRWIEGC-NF6PFSV-W7WJLZW-KKF4FQR";
      dafphone.id = "G3MQBMD-VN542WA-6V5EEGT-FBJXK5K-NREP2CU-WA4LFMV-NW3SIED-CRNNWQ2";
      dafpi.id    = "6LSQT5W-CDVRC2U-OYU77MY-XQGUN7H-NWRMZPY-CJ6ETAZ-4XSHR2E-5ADGGQI";
    };
    # FIXME: Generic setup needed
    folders = {
      "${config.user.home}/Sync/Org" = {
        id = "rk2oz-zgpcr";
        devices = [ "dafbox" "dafpi" "dafphone" ];
      };
      "${config.user.home}/Sync/Share" = {
        id = "4cbs9-we2re";
        devices = [ "dafbox" "dafpi" "dafphone" ];
      };
      "${config.user.home}/Sync/Music/LOTR" = {
        id = "vrzhl-7sair";
        devices = [ "dafbox" ];
      };
      "${config.user.home}/Sync/Books" = {
        id = "5abdj-f46gf";
        devices = [ "dafbox" "dafpi" "dafphone" ];
      };
    };
      # let mkShare = name: devices: type: path: rec {
      #       inherit devices type path;
      #       watch = false;
      #       rescanInterval = 3600 * 4;
      #       enabled = lib.elem config.networking.hostName devices;
      #     };
      # in {
      #   # projects = mkShare "projects" [ "kuro" "shiro" ] "sendrecieve" "${config.user.home}/projects";
      #   projects = mkShare "Sync" [ "dafpi" "dafphone" "daftop" ] "sendreceive" "${config.user.home}/Sync";
      # };
  };
}
