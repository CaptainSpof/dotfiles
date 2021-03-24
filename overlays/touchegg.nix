self: super:
{
  touchegg = super.touchegg.overrideAttrs (old: rec {
    version = "2.0.8";

    src = super.fetchzip {
      url = "https://github.com/JoseExposito/touchegg/archive/${version}.zip";
      sha256 = "sha256-iUWEC5ogPw6h6GWLGcD2Wx+HSFr6gb+85JJ6hBbFtqk=";
    };

    buildInputs = with super; [ cmake pkg-config libudev libinput pugixml cairo xorg.libXtst xorg.xrandr xorg.libXrandr xorg.libXi gtk3 ];

    nativeBuildInputs = [ ];

    # TODO: touchegg client still needs /usr/share/touchegg to run
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
}
