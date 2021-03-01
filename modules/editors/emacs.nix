# Emacs is my main driver. I'm the author of Doom Emacs
# https://github.com/hlissner/doom-emacs. This module sets it up to meet my
# particular Doomy needs.

{ config, lib, pkgs, inputs, ... }:

with lib;
with lib.my;
let cfg = config.modules.editors.emacs;
in {
  options.modules.editors.emacs = {
    enable = mkBoolOpt false;
    doom = {
      enable  = mkBoolOpt true;
      src = mkOption {
        type = types.str;
        default = "https://github.com/hlissner/doom-emacs";
      };
      dest = mkOption {
        type = types.str;
        default = "$HOME/.config/emacs";
      };
      user = {
        enable  = mkBoolOpt true;
        config = {
          src = mkOption {
            type = types.str;
          };
          dest = mkOption {
            type = types.str;
            default = "$HOME/.config/doom";
          };
        };
      };
      fromSSH = mkBoolOpt false;
    };
  };

  config = mkIf cfg.enable {
    nixpkgs.overlays = [ inputs.emacs-overlay.overlay ];

    user.packages = with pkgs; [
      ## Emacs itself
      binutils       # native-comp needs 'as', provided by this
      # emacsGcc   # 28 + native-comp
      emacsPgtkGcc   # 28 + pgtk + native-comp
      # emacs

      ## Doom dependencies
      git
      (ripgrep.override {withPCRE2 = true;})
      gnutls              # for TLS connectivity

      ## Optional dependencies
      fd                  # faster projectile indexing
      imagemagick         # for image-dired
      (mkIf (config.programs.gnupg.agent.enable) pinentry_emacs)   # in-emacs gnupg prompts
      pandoc
      python3             # for treemacs
      zstd                # for undo-fu-session/undo-tree compression
      cmake               # for vterm

      ## Module dependencies
      # :checkers spell
      (aspellWithDicts (ds: with ds; [
        en en-computers en-science
      ]))
      # :checkers grammar
      languagetool
      # :tools editorconfig
      editorconfig-core-c # per-project style config
      # :tools lookup & :lang org +roam
      sqlite
      # :lang cc
      ccls
      # :lang javascript
      nodePackages.javascript-typescript-langserver
      # :lang latex & :lang org (latex previews)
      texlive.combined.scheme-full
      # :lang rust
      rustfmt
      # unstable.rust-analyzer
      xorg.xwininfo

      (makeDesktopItem {
        name = "emacs client";
        desktopName = "Emacs Client";
        icon = "emacs";
        exec = "${pkgs.emacsPgtkGcc}/bin/emacsclient -create-frame --alternate-editor=\"\" --no-wait %F";
        categories = "Development";
      })
    ];

    env.PATH = [ "$XDG_CONFIG_HOME/emacs/bin" ];

    modules.shell.zsh.rcFiles = [ "${configDir}/emacs/aliases.zsh" ];

    fonts.fonts = [ pkgs.emacs-all-the-icons-fonts ];

    system.userActivationScripts.home-doom-setup-daf.text = mkIf cfg.doom.enable ''
      if [ ! -d ${cfg.doom.dest} ]; then
      ${pkgs.git}/bin/git clone ${cfg.doom.src} ${cfg.doom.dest}
      # FIXME: need to manually run command ?
      # doom install
      fi
    '';

    # TODO: I don't know how this will work on a new system, without ssh.
    system.userActivationScripts.home-doom-user-setup-daf.text = mkIf cfg.doom.user.enable ''
      if [ ! -d ${cfg.doom.user.config.dest} ]; then
      ${pkgs.git}/bin/git clone ${cfg.doom.user.config.src} ${cfg.doom.user.config.dest}
      fi
    '';
  };
}
