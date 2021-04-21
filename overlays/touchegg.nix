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

    nativeBuildInputs = with super; [ pkg-config cmake ];

    preConfigure = "";

  });
}
