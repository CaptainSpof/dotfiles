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
    rev = "ddd97565a5935fb85009aac9f9ef10c00687e50c";
    sha256 = "sha256-2QiCpPu3BsIFAj3pZsHw/nBZTSBtmXc+3GRDudqeZAU=";
  };

  outputs = [ "bin" "dev" "out" ];
  cmakeFlags = [ "-DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_INSTALL_LIBDIR=lib -DBUILD_TESTING=OFF" ];
}
