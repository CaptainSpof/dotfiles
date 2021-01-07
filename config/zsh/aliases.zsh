alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias -- -='cd -'

alias q=exit
alias clr=clear
alias sudo='sudo '
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias wget='wget -c'

alias mk=make
alias rcp='rsync -vaP --delete'
alias rmirror='rsync -rtvu --delete'
alias gurl='curl --compressed'

alias y='xclip -selection clipboard -in'
alias p='xclip -selection clipboard -out'

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
  alias ls="exa --group-directories-first";
  alias sl="ls"
  alias l="ls -1";
  alias ll="ls -lg --git --icons";
  alias la="LC_COLLATE=C ls -la";
fi

autoload -U zmv

take() {
  mkdir "$1" && cd "$1";
}; compdef take=mkdir

zman() {
  PAGER="less -g -I -s '+/^       "$1"'" man zshall;
}

r() {
  local time=$1; shift
  sched "$time" "notify-send --urgency=critical 'Reminder' '$@'; ding";
}; compdef r=sched
