# FIXME: make it work...
self: super:
{
  krohnkite = super.krohnkite.overrideAttrs (old: rec {
    version = "0.8";
    src = super.fetchFromGitHub {
      owner = "esjeon";
      repo = "krohnkite";
      rev = "2a47753fa2a37a9035116df4a7c2d73044373d82";
      sha256 = "sha256-ZKh+wg+ciVqglirjxDQUXkFO37hVHkn5vok/CZYf+ZM=";
    };
    installPhase = ''
            runHook preInstall
            plasmapkg2 --type kwinscript --install ${src}/res/ --packageroot $out/share/kwin/scripts
            install -Dm644 ${src}/res/metadata.desktop $out/share/kservices5/krohnkite.desktop
            # install -Dm644 ${src}/res/metadata.desktop /home/daf/.local/share/kservices5/krohnkite.desktop
            runHook postInstall
          '';
  });
}
