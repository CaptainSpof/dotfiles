alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias -- -='cd -'
alias cdg='cd `git rev-parse --show-toplevel`'

alias q=exit
alias clr=clear
alias sudo='sudo '
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -pv'
alias wget='wget -c'
alias path='echo -e ${PATH//:/\\n}'
alias ports='netstat -tulanp'

alias ssh='TERM=xterm-256color ssh'

alias mk=make
alias gurl='curl --compressed'

alias shutdown='sudo shutdown'
alias reboot='sudo reboot'

# An rsync that respects gitignore
alias rcpd='rcp --delete --delete-after'
alias rcpu='rcp --chmod=go='
alias rcpdu='rcpd --chmod=go='

alias y='xclip -selection clipboard -in'
alias p='xclip -selection clipboard -out'

alias jc='journalctl -xe'
alias sys=systemctl
alias sysu=systemctl --user
alias ssys='sudo systemctl'

if command -v bat >/dev/null; then
  alias cat="bat"
fi

if command -v btm >/dev/null; then
  alias htop="btm -b"
fi

if command -v direnv >/dev/null; then
  alias da="direnv allow";
fi

if command -v exa >/dev/null; then
  alias ls="exa --group-directories-first --git";
  alias sl="ls"
  alias l="ls -1";
  alias ll="ls -lg --git --icons";
  alias la="LC_COLLATE=C ls -la";
fi

autoload -U zmv

zman() {
  PAGER="less -g -I -s '+/^       "$1"'" man zshall;
}

# TODO: better implementation
,() {
  case "$@" in
    *\#*) pkg="$@"  ;;
    *) pkg="nixpkgs#$@"  ;;
  esac

  echo "Eww, I don't want $(tput setaf 4)$@$(tput sgr 0) in my PATH. Here, have a disposable shell…" && \
    name='nix-shell' NIX_SHELL_PKG="$pkg" nix shell "$pkg" ; \
    echo "…Mischief managed!"
}

nr() {
  nix run nixpkgs#"$@"
}
