{ config, options, pkgs, lib, ... }:

with lib;
with lib.my;
let cfg = config.modules.shell.cli;
    configDir = config.dotfiles.configDir;
in {
  options.modules.shell.cli = with types; {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {

    user.packages = with pkgs; [
      # …
    ] ++ ( with my; [
      lfs                 # df, but pretty
      thumbs
    ]) ++ ( with unstable; [
      bandwhich           # htop, but for network
      bat                 # cat, but pretty
      bottom              # htop, but pretty
      dua                 # du, but pretty
      exa                 # ls, but pretty
      fd                  # find, but fast, also I know how to use it
      fzf                 # fuzzy finder, the original (probably not, who care)
      ht-rust             # httpie, but rusty
      jq                  # make JSON readable, well more readable
      killall             # every last one of them (the processes, of course)
      navi                # retired from helping Link to help you suck less at bash
      macchina            # neofetch, but fast
      pastel              # a color picker in a terminal ? Genius.
      procs               # ps, but pretty
      ripgrep             # grep, but fast
      rbw                 # bitwarden cli, but rusty
      skim                # fzf, but rusty
      starship            # a prompt theme, but I can explain why it's a mess (not really)
      tealdeer            # yeah, I need all the help; tldr but rusty
      tokei               # need to know how many lines of poorly written code you typed ?
      watchexec           # watch, then exec; run commands when a file changes
      wmctrl              # even X need some CLIs
      zoxide              # go directly to dir, do not pass GO, do not collect 200$
    ]);

    home.file = {
      ".lesskey".source = "${configDir}/less/lesskey";
    };

    # FIXME: not running
    system.userActivationScripts.lesskey-init.text = ''
      if [ ! -f $HOME/.less ]; then
        lesskey
      fi
    '';

  };
}
