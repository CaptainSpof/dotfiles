{
  stdenv,
  fetchFromGitHub,
  extra-cmake-modules,
  libsForQt5,
}:

stdenv.mkDerivation rec {
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
    rev = "fecf30cc445f3a95a4f0196fa66443026072d366";
    sha256 = "sha256-Zy4XdhsZpujvPUr98gGHoI5a6H6srHGsKfKdHhYZgEE=";
  };

  outputs = [ "bin" "dev" "out" ];
  cmakeFlags = [ "-DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_INSTALL_LIBDIR=lib -DBUILD_TESTING=OFF" ];
}
