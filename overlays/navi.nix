self: super:
{
  navi = super.navi.overrideAttrs (old: rec {
    # version = "2.16.0";

    # src = super.fetchFromGitHub {
    #   owner = "denisidoro";
    #   repo = "navi";
    #   rev = "v2.16.0";
    #   sha256 = "sha256-ngSZFYGE+Varul/qwavMO3xcMIp8w2WETWXc573wYhQ=";
    # };
  });
}
