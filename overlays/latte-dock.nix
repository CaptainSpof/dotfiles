self: super:
{
  latte-dock = super.latte-dock.overrideAttrs (old: rec {
    version = "0.10-git";

    src = super.fetchFromGitHub {
      owner = "KDE";
      repo = "latte-dock";
      rev = "12c8643f62f71a762d1f0953e916c5bcf4664279";
      sha256= "sha256-nM+UZ2jDs/Q2dQR5G9V4/9Dsq6U6hLyxNJdBh2eFrFg=";
    };

  });
}
