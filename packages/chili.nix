{ stdenv, fetchFromGitHub, libsForQt5 }:

stdenv.mkDerivation rec {
  pname = "chili";
  version = "0.5.5";

  src = fetchFromGitHub {
    owner = "MarianArlt";
    repo = "sddm-chili";
    rev = version;
    sha256 = "036fxsa7m8ymmp3p40z671z163y6fcsa9a641lrxdrw225ssq5f3";
  };

  buildInputs = with libsForQt5; [ qtbase qtquickcontrols qtgraphicaleffects ];

  installPhase = ''
    # sed -i 's/ScreenWidth=1440/ScreenWidth=1920/' theme.conf
    # sed -i 's/ScreenHeight=900/ScreenHeight=1080/' theme.conf
    # echo 'PasswordFieldCharacter=🦖' >> theme.conf

    mkdir -p $out/share/sddm/themes/chili
    mv * $out/share/sddm/themes/chili/
  '';

  meta = with stdenv.lib; {
    license = licenses.gpl3;
    maintainers = with maintainers; [ mschneider ];
    homepage = https://github.com/MarianArlt/sddm-chili;
    description = "The chili login theme for SDDM";
    longDescription = ''
      Chili is hot, just like a real chili! Spice up the login experience for your users, your family and yourself. Chili reduces all the clutter and leaves you with a clean, easy to use, login interface with a modern yet classy touch.
    '';
  };
}
