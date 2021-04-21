self: super:
{
  latte-dock = super.latte-dock.overrideAttrs (old: rec {
    version = "0.10-git";

    src = super.fetchFromGitHub {
      owner = "KDE";
      repo = "latte-dock";
      rev = "2be67b11c56eb1bee4ed3e58ac71fd9f7aae9419";
      sha256 = "sha256-RlqDITH2LHRQSIWB2E/EsCTCnRjVaOcLLUYsiVjwh3o=";
    };

  });
}
