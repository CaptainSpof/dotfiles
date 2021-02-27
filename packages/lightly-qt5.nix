{
  stdenv,
  fetchFromGitHub,
  extra-cmake-modules,
  libsForQt5,
}:

libsForQt5.mkDerivation rec {
  name = "lightly-qt5";
  sname = "lightly";
  pname = "Lightly";
  version = "0.4";
  nativeBuildInputs = [ extra-cmake-modules ];
  propagatedBuildInputs = with libsForQt5; [
    frameworkintegration kcmutils kdecoration
    kwayland
    qtx11extras
  ];

  src = fetchFromGitHub {
    owner = "Luwx";
    repo = pname;
    rev = "0fdb791e38d32851ffc8442ae5eb2bccc72b39b6";
    sha256 = "sha256-k1fEZbhzluNlAmj5s/O9X20aCVQxlWQm/Iw/euX7cmI=";
  };

  outputs = [ "bin" "dev" "out" ];
  cmakeFlags = [ "-DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_INSTALL_LIBDIR=lib -DBUILD_TESTING=OFF" ];
}
