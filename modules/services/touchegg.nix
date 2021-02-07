{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.services.touchegg;
    localOverlay = self: super:
      {
        touchegg = super.touchegg.overrideAttrs (old: {
          version = "2.0.7";

          src = super.fetchzip {
            url = "https://github.com/JoseExposito/touchegg/archive/${version}.zip";
            sha256 = "sha256-1r4GqJMVraG98d49M9K5gEjZkbFTd7ys38SZSoGOq00=";
          };

          buildInputs = with super; [ cmake pkg-config libudev libinput pugixml cairo xorg.libXtst xorg.xrandr xorg.libXrandr xorg.libXi gtk3 ];

          nativeBuildInputs = [ ];

          preConfigure = ''
            sed -e "s@/usr@$out/@g" -i $(find . -name CMakeLists.txt) $(find . -name touchegg.service)
            sed -e "s@/lib/systemd/system@$out/&/@g" -i $(find . -name CMakeLists.txt)
            # FIXME: Not using xdg autostart. Instead I use a custom user systemd service.
            sed -e "s@/etc/xdg/autostart@$out/trash&/@g" -i $(find . -name CMakeLists.txt)

            export CMAKE_INSTALL_PREFIX=$out
            export CMAKE_INSTALL_BINDIR=$out/bin
            export CMAKE_INSTALL_DATAROOTDIR=$out/share
          '';

        });
      };
in {
  options.modules.services.touchegg = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {

    nixpkgs.overlays = [ localOverlay ];

    environment.systemPackages = with pkgs; [
      touchegg
    ];

    # FIXME: the derivation already provide this service file. I need to figure out how to enable it.
    systemd.services.touchegg = {
      enable = true;
      description = "Touchégg. The daemon.";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "simple";
        Group = "input";
        Restart = "on-failure";
        RestartSec = 5;
        ExecStart = "${pkgs.touchegg}/bin/touchegg --daemon";
      };
    };

    # REVIEW: Don't need that, xdg/autostart does that for us.
    # But I noticed touchegg segfaulting on some occasion.
    # This service restart it when it happen.
    systemd.user.services.touchegg-client = {
      description = "Touchégg. The client.";

      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];

      serviceConfig = {
        Restart = "on-failure";
        ExecStart = "${pkgs.touchegg}/bin/touchegg";
      };
    };

    home.configFile = {
      "touchegg/touchegg.conf" = {
        source = "${configDir}/touchegg/touchegg.conf";
        recursive = true;
      };
    };
  };
}
