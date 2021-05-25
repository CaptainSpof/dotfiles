self: super:
{
  latte-dock = super.latte-dock.overrideAttrs (old: rec {
    version = "0.10-git";

    src = super.fetchFromGitHub {
      owner = "KDE";
      repo = "latte-dock";
      rev =  "11c3f2a664c3f94dad1cf0a44fce1fd5fbc9f40f";
      sha256 = "sha256-xqxJuAlMozfSzreEeVffg2TMhkwKNhA8zKhfc1iBX+w=";
    };

  });
}
