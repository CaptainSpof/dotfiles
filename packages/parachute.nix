{ fetchFromGitHub, config, lib, pkgs, ... }:

rec {
  name = "parachute";
  pname = "Parachute";
  version = "v0.9.1";

  src = fetchFromGitHub {
    owner = "tcorreabr";
    repo = pname;
    rev = "19ae08ef28efc35c67996c6dd7c23b20ed2666d8";
  };

}
