{ lib, rustPlatform, fetchFromGitHub, my, ... }:

rustPlatform.buildRustPackage rec {
  pname = "thumbs";
  name = pname;

  src = fetchFromGitHub {
    owner = "fcsonline";
    repo = "tmux-thumbs";
    rev = "14b6cd4ec574636b38ce18e75a85eca3fee8e9ee";
    sha256 = "sha256-mgGUZ2B9/ukMC4ptkcoZiXO3liYZOzJuXVx5riS9kfY=";
  };

  cargoSha256 = "sha256-49asYlV4VmGgMwFit0VkdLrlvixtskpQ5Nx2GO/j/tY=";

  meta = with lib; {
    description = "A thing to get information on your mounted disks";
    homepage = "https://github.com/fcsonline/tmux-thumbs";
    license = licenses.mit;
    maintainers = [];
  };
}
