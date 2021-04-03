{
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
    rev = "be20234dfb56e936735d215e15e96c6ec0f36e7a";
    sha256 = "sha256-PoQiBOJA1nvCHjD/j4S02Ka8BdNTWFxzErf4QRTViIg=";
  };

  outputs = [ "bin" "dev" "out" ];
  cmakeFlags = [ "-DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_INSTALL_LIBDIR=lib -DBUILD_TESTING=OFF" ];
}
