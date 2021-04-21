{ lib, rustPlatform, fetchFromGitHub, my, ... }:

rustPlatform.buildRustPackage rec {
  pname = "rsfetch";

  src = fetchFromGitHub {
    owner = "Phate6660";
    repo = pname;
    rev = "5e6243f14bc959c2e27bc6319f81d1ddc36a4008";
  };

  cargoSha256 = "0000000000000000000000000000000000000000000000000000";

  meta = with lib; {
    description = " Fast (~1ms execution time) and somewhat(?) minimal fetch program written in Rust.";
    homepage = "https://github.com/Phate6660/rsfetch";
    license = licenses.unlicense;
    maintainers = [];
  };
}
