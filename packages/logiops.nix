{ lib, pkgs, fetchFromGitHub, stdenv, ... }:

stdenv.mkDerivation {
  name = "logiops";
  version = "0.2.3";

  src = fetchFromGitHub {
    owner = "PixlOne";
    repo = "logiops";
    rev = "0a26579d5a586a92f288ffe4e77c896bb091c767";
  };

  buildInputs = with pkgs; [ libevdev libconfig];

  nativeBuildInputs = with pkgs; [ pkg-config cmake ];

}
