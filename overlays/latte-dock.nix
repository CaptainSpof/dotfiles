self: super:
{
  latte-dock = super.latte-dock.overrideAttrs (old: rec {
    version = "0.10-git";

    src = super.fetchFromGitHub {
      owner = "KDE";
      repo = "latte-dock";
      rev = "4f0830eb8aebfde6ccdff9c5499f32c9adece36c";
      sha256 = "sha256-50VT32/sMJrRGQrVqmpHpcG14Lw1RYgk+jF6oA8MQfg=";
    };

  });
}
