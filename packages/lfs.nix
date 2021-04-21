{ lib, rustPlatform, fetchFromGitHub, my, ... }:

rustPlatform.buildRustPackage rec {
  pname = "lfs";
  name = pname;

  src = fetchFromGitHub {
    owner = "Canop";
    repo = pname;
    rev = "84dd2fe74084aaa7aef8ed52a4fb2e6399174ebe";
    sha256 = "sha256-rWxTBTOxNJtV59M25xVMjN2TekHUYjnXJvmaHsNH2Sk=";
  };

  cargoSha256 = "sha256-dh6WcV4nlzer47Sb//1jhr4b4BeHxSzGfi7nTVekUjY=";
  meta = with lib; {
    description = "A thing to get information on your mounted disks";
    homepage = "https://github.com/Canop/lfs";
    license = licenses.mit;
    maintainers = [];
  };
}
