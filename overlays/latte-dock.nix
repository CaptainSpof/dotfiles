self: super:
{

  latte-dock = super.latte-dock.overrideAttrs (old: rec {
    version = "0.10-git";

    src = super.fetchFromGitHub {
      owner = "KDE";
      repo = "latte-dock";
      rev = "1afe12ad71ab8018e635e41cdc45c6602817677d";
      sha256 = "sha256-P2VHS6d7xoPFfbGBl85NzdD07arg2D47oXNMLzCad1k=";
    };

    # buildInputs = [ plasma-framework xorg.libpthreadstubs xorg.libXdmcp xorg.libSM ];

    # nativeBuildInputs = [ extra-cmake-modules cmake karchive kwindowsystem
    #                       qtx11extras kcrash knewstuff ];


  });
}
