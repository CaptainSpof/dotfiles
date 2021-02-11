{ stdenv, fetchFromGitHub, libsForQt5, lib }:

stdenv.mkDerivation rec {
  name = "parachute";
  pname = "Parachute";
  version = "v0.9.1";

  src = fetchFromGitHub {
    owner = "tcorreabr";
    repo = pname;
    rev = "19ae08ef28efc35c67996c6dd7c23b20ed2666d8";
    sha256 = "sha256-QIWb1zIGfkS+Bef7LK+JA6XpwGUW+79XZY47j75nlCE=";
  };

  dontBuild = true;

  buildInputs = with libsForQt5; [
    kcoreaddons kwindowsystem plasma-framework systemsettings
    frameworkintegration kcmutils kdecoration
  ];

  installPhase = ''
    mkdir -p $out/share/kservices5
    kpackagetool5 --type KWin/Script --install ${src}
    # mkdir -p $out/share/kservices5
    ln -s ${src}/metadata.desktop $out/share/kservices5/Parachute.desktop

    # runHook postInstall
  '';

  meta = with lib; {
    description = "Tiling script for kwin";
    license = licenses.gpl3;
    inherit (src.meta) homepage;
    inherit (kwindowsystem.meta) platforms;
  };
}
