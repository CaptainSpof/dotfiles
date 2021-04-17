{ lib, pkgs, fetchFromGitHub, stdenv, ... }:

stdenv.mkDerivation {
  name = "logiops";
  version = "0.2.3";

  src = fetchFromGitHub {
    owner = "PixlOne";
    repo = "logiops";
    rev = "0a26579d5a586a92f288ffe4e77c896bb091c767";
    sha256 = "sha256-1v728hbIM2ODtB+r6SYzItczRJCsbuTvhYD2OUM1+/E=";
  };

  PKG_CONFIG_SYSTEMD_SYSTEMDSYSTEMUNITDIR = "${placeholder "out"}/lib/systemd/system";

  buildInputs = with pkgs; [ systemd libevdev libconfig libudev ];

  nativeBuildInputs = with pkgs; [ pkg-config cmake ];
}
