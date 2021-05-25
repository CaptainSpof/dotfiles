{ lib, pkgs, fetchFromGitHub, stdenv, ... }:

stdenv.mkDerivation {
  name = "logiops";
  version = "0.2.3";

  src = fetchFromGitHub {
    owner = "PixlOne";
    repo = "logiops";
    rev = "7b297fc49f27e4fe075141d4ac0d56ab80123835";
    sha256 = "sha256-B3TsNgA4ZAwuRW8PQ3ywOx5dUk2sRhUvLAMuWFG9Gjo=";
  };

  PKG_CONFIG_SYSTEMD_SYSTEMDSYSTEMUNITDIR = "${placeholder "out"}/lib/systemd/system";

  buildInputs = with pkgs; [ systemd libevdev libconfig libudev ];

  nativeBuildInputs = with pkgs; [ pkg-config cmake ];
}
