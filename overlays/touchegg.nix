self: super:
{
  touchegg = super.touchegg.overrideAttrs (old: rec {
    version = "2.0.9";

    src = super.fetchzip {
      url = "https://github.com/JoseExposito/touchegg/archive/${version}.zip";
      sha256 = "sha256-dIUAN65grsFiCF1iDI2hDJQUtLmXxJ/1qAl/55NzRc0=";
    };

    PKG_CONFIG_SYSTEMD_SYSTEMDSYSTEMUNITDIR = "${placeholder "out"}/lib/systemd/system";

    buildInputs = with super; [
      systemd
      libinput
      pugixml
      cairo
      gtk3-x11
      pcre
    ] ++ (with xorg; [
      libX11
      libXtst
      libXrandr
      libXi
      libXdmcp
      libpthreadstubs
      libxcb
    ]);

    # nativeBuildInputs = [ ];
    nativeBuildInputs = with super; [ pkg-config cmake ];

    preConfigure = "";

    # TODO: touchegg client still needs /usr/share/touchegg to run
    # preConfigure = ''
    #         sed -e "s@/usr@$out/@g" -i $(find . -name CMakeLists.txt) $(find . -name touchegg.service)
    #         sed -e "s@/lib/systemd/system@$out/&/@g" -i $(find . -name CMakeLists.txt)
    #         # FIXME: Not using xdg autostart. Instead I use a custom user systemd service.
    #         sed -e "s@/etc/xdg/autostart@$out/trash&/@g" -i $(find . -name CMakeLists.txt)

    #         export CMAKE_INSTALL_PREFIX=$out
    #         export CMAKE_INSTALL_BINDIR=$out/bin
    #         export CMAKE_INSTALL_DATAROOTDIR=$out/share
    #       '';

  });
}
