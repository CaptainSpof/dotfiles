self: super:
{
  pname = "qogir-icon-theme";
  version = "0084e4391a756881cf6a12da5e0923738ce0020c";

  src = super.fetchFromGitHub {
    owner = "vinceliuice";
    repo = "qogir-icon-theme";
    rev = "0084e4391a756881cf6a12da5e0923738ce0020c";
    sha256 = "40cec342a57feb55fe8f606dfb478be0";
  };
  nativeBuildInputs = [ ];
  propagatedBuildInputs = [ ];
}
