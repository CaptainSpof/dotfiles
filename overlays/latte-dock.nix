self: super:
{

  latte-dock = super.latte-dock.overrideAttrs (old: rec {
    version = "0.10-git";

    src = super.fetchFromGitHub {
      owner = "KDE";
      repo = "krohnkite";
      rev = "b29a8fa9b306d7468bd0e20ad68ee0ab75ce647e";
    };

    # buildInputs = [ plasma-framework xorg.libpthreadstubs xorg.libXdmcp xorg.libSM ];

    # nativeBuildInputs = [ extra-cmake-modules cmake karchive kwindowsystem
    #                       qtx11extras kcrash knewstuff ];


  });
}
