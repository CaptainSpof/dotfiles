{ lib
, mkDerivation
, fetchFromGitHub
, extra-cmake-modules
, kwindowsystem
, plasma-framework
, qtx11extras
}:

mkDerivation rec {
  pname = "krohnkite";
  version = "0.8";

  src = fetchFromGitHub {
      owner = "esjeon";
      repo = "krohnkite";
      rev = "v${version}";
      sha256 = "sha256-ZKh+wg+ciVqglirjxDQUXkFO37hVHkn5vok/CZYf+ZM=";
  };

  buildInputs = [
    kwindowsystem plasma-framework qtx11extras
  ];

  nativeBuildInputs = [
    extra-cmake-modules
  ];

  cmakeFlags = [
    "-Wno-dev"
  ];

  meta = with lib; {
    description = "Manage virtual desktops dynamically in a convenient way";
    homepage = "https://github.com/wsdfhjxc/virtual-desktop-bar";
    license = licenses.gpl3Only;
    platforms = platforms.linux;
    maintainers = with maintainers; [ peterhoeg ];
  };
}
