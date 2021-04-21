{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "qogir-icon-theme";
  version = "git";

  src = fetchFromGitHub {
    owner = "vinceliuice";
    repo = pname;
    rev = "0084e4391a756881cf6a12da5e0923738ce0020c";
    sha256 = "sha256-2fUQ2z3uO9hYxowvRGCnwtTyB22nD6kKQNidzgCNMyA=";
  };

  nativeBuildInputs = [ ];

  propagatedBuildInputs = [ ];

  dontDropIconThemeCache = true;

  installPhase = ''
    patchShebangs install.sh
    sed '/gtk-update-icon-cache.*/d' -i install.sh
    sed '/THEME_VARIANTS=.*/d' -i install.sh
    mkdir -p $out/share/icons
    name= ./install.sh -d $out/share/icons
  '';

  meta = with lib; {
    description = "Flat colorful design icon theme";
    homepage = "https://github.com/vinceliuice/Qogir-icon-theme";
    license = with licenses; [ gpl3 ];
    platforms = platforms.linux;
  };
}
