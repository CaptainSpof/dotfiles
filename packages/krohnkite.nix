{ lib
, libsForQt5
, fetchFromGitHub
, extra-cmake-modules
, nodePackages
, p7zip
}:

libsForQt5.mkDerivation rec {
  pname = "krohnkite";
  version = "0.8";

  src = fetchFromGitHub {
      owner = "esjeon";
      repo = "krohnkite";
      rev = "v${version}";
      sha256 = "sha256-ZKh+wg+ciVqglirjxDQUXkFO37hVHkn5vok/CZYf+ZM=";
  };

  buildInputs = [
    libsForQt5.kwindowsystem libsForQt5.plasma-framework libsForQt5.qtx11extras
    nodePackages.typescript
    p7zip
  ];

  # nativeBuildInputs = [
  #   extra-cmake-modules
  # ];

  # cmakeFlags = [
  #   "-Wno-dev"
  # ];

  meta = with lib; {
    license = licenses.gpl3Only;
    platforms = platforms.linux;
  };
}
