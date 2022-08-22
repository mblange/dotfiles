# measure $SHELL load time ... in this case ZSH load time
timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

# profiling zsh
# run `zprof` to find out what's slowing down zsh
zmodload zsh/zprof

# load fzf
[ -f ~/.config/fzf/fzf.zsh ] && source ~/.config/fzf/fzf.zsh

# let fzf handle tab completions for zsh
source ~/.config/fzf-tab/fzf-tab.plugin.zsh

# If shell is zsh, DO NOT export $EDITOR env variable to vi/vim
# you won't be able to use C-a/C-e/C-b/C-f to navigate :command mode
# https://unix.stackexchange.com/questions/601070/tmux-behaves-differently-and-c-a-c-a-prints-a-instead-of-jumping-to-beginni#comment1126888_601070
# export EDITOR=vim
# instead use normal script variable and DO NOT export it
# exporting makes it available to all other programs
EDITOR=vim
alias vi=$EDITOR
alias vim=$EDITOR

# THIS FUCNTION IS BROKEN IF YOU LET IT LOAD FOR A LONG TIME
# BUT I DON'T THINK I NEED IT
# I CAN JUST INVOKE FILE SEARCH WITH FZF CTRL-T WHICH IS POWERED BY RIPGREP
Rg() {
  local selected=$(
    rg --no-messages --column --line-number --no-heading --color=always --smart-case "$1" |
      fzf --ansi \
          --delimiter : \
          --preview 'bat --style=full --color=always --highlight-line {2} {1}' \
          --preview-window '~3:+{2}+3/2'
  )
  # [ -n "$selected" ] && $EDITOR "$selected"
  # [ -n "$selected" ] && $EDITOR "$(echo "$selected" | cut -d ':' -f 1)"

  local FILE="$(echo "$selected" | cut -d ':' -f 1)"
  local LINE="$(echo "$selected" | cut -d ':' -f 2)"
  local COLUMN="$(echo "$selected" | cut -d ':' -f 3)"

  [ -n "$selected" ] && $EDITOR +"$line" "$file"
  [ -n "$selected" ] && $EDITOR "+call cursor($LINE,$COLUMN)" "$FILE"
  # echo $selected
}

# same as RG but will only work for single selected result
RG() {
  RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
  INITIAL_QUERY="$1"
  local selected=$(
    FZF_DEFAULT_COMMAND="$RG_PREFIX '$INITIAL_QUERY' || true" \
      fzf --bind "change:reload:$RG_PREFIX {q} || true" \
          --ansi --disabled --query "$INITIAL_QUERY" \
          --delimiter : \
          --preview 'bat --style=full --color=always --highlight-line {2} {1}' \
          --preview-window '~3:+{2}+3/2'
  )
  # [ -n "$selected" ] && $EDITOR "$selected"
  # [ -n "$selected" ] && $EDITOR "$(echo "$selected" | cut -d ':' -f 1)"

  local FILE="$(echo "$selected" | cut -d ':' -f 1)"
  local LINE="$(echo "$selected" | cut -d ':' -f 2)"
  local COLUMN="$(echo "$selected" | cut -d ':' -f 3)"

  # [ -n "$selected" ] && $EDITOR +"$line" "$file"
  [ -n "$selected" ] && $EDITOR "+call cursor($LINE,$COLUMN)" "$FILE"
}

# fuzzy ripgrep and load selected results into vim's quickfix
# don't forget to pass --vimgrep to rg else it'll not work
RGV() {
  RG_PREFIX="rg --vimgrep --column --line-number --no-heading --color=always --smart-case "
  INITIAL_QUERY="$1"
  local selected=$(
    FZF_DEFAULT_COMMAND="$RG_PREFIX '$INITIAL_QUERY' || true" \
      fzf --bind "change:reload:$RG_PREFIX {q} || true" \
          --ansi --disabled --query "$INITIAL_QUERY" \
          --delimiter : \
          --preview 'bat --style=full --color=always --highlight-line {2} {1}' \
          --preview-window '~3:+{2}+3/2'
  )

  # load selected results files into vim's quickfix list
  # don't load if no results selected
  [ -n "$selected" ] && vim -q <(echo $selected)
}

# exactly like RGV but only for searching contents inside files in wiki
# that's why we pass $KB_DIRECTORY which holds the path to wiki
RGW() {
  RG_PREFIX="rg --vimgrep --column --line-number --no-heading --color=always --smart-case "
  INITIAL_QUERY="$1"
  local selected=$(
    FZF_DEFAULT_COMMAND="$RG_PREFIX '$INITIAL_QUERY' $KB_DIRECTORY || true" \
      fzf --bind "change:reload:$RG_PREFIX {q} $KB_DIRECTORY || true" \
          --ansi --disabled --query "$INITIAL_QUERY" \
          --delimiter : \
          --preview 'bat --style=full --color=always --highlight-line {2} {1}' \
          --preview-window '~3:+{2}+3/2'
  )

  # load selected results files into vim's quickfix list
  # don't load if no results selected
  [ -n "$selected" ] && vim -q <(echo $selected)
}

# make fzf play well with tmux
export FZF_TMUX_OPTS='-p80%,60%'

# when running fzf with Ctrl+r, allow copying commands to clipboard with Ctrl-Y
export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window down:3:hidden:wrap
  --bind '?:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

# https://pinshuai.github.io/FZF-Tutorial/
# auto toggle preview of files with `?`
# more cool fzf tricks --> https://nosarthur.github.io/productivity/2021/09/07/fzf.html
if type rg &> /dev/null; then
  # --files: List files that would be searched but do not search
  # --no-ignore: Do not respect .gitignore, etc...
  # --hidden: Search hidden files and folders
  # --follow: Follow symlinks
  # --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
  export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
  export FZF_DEFAULT_OPTS="-m --height 50% --layout=reverse --border --inline-info
  --preview-window=:hidden
  --preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'
  --bind '?:toggle-preview'
"
fi

# command -v bat  > /dev/null && export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always {}'"
# command -v blsd > /dev/null && export FZF_ALT_C_COMMAND='blsd'
# command -v tree > /dev/null && export FZF_ALT_C_OPTS="--preview 'tree -C {}'"

# autocompletion settings jacked from
# https://www.codyhiar.com/blog/zsh-autocomplete-with-ssh-config-file/
# Highlight the current autocomplete option
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Better SSH/Rsync/SCP Autocomplete
zstyle ':completion:*:(scp|rsync):*' tag-order ' hosts:-ipaddr:ip\ address hosts:-host:host files'
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'

# Allow for autocomplete to be case insensitive
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' \
  '+l:|?=** r:|?=**'

# Initialize the autocompletion
autoload -Uz compinit && compinit -i

# load gruvbox colorscheme
# afaik this is handled by iterm2 so we don't need it here
# source "$HOME/.vim/vim-plugged/gruvbox/gruvbox_256palette_osx.sh"

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

#############################################################################
## Aliases
alias ll='ls -hlF'
alias la='ls -hAlF'

# cd-foo
alias ..="cd ..; ll"
alias ...="cd ../..; ll"
alias ....="cd ../../..; ll"
alias .....="cd ../../../..; ll"

# what's my IP?
alias wip="dig +short myip.opendns.com @resolver1.opendns.com"

# python SimpleHTTPServer
#alias pws="ifconfig|grep 'netmask'; python -m SimpleHTTPServer" 
alias pws="ifconfig|grep 'netmask'; python -m http.server" 

# SUDO!!
alias fuck='sudo $(fc -ln -1)'

alias ipwhois="python -c \"from ipwhois import IPWhois; import sys; print IPWhois(sys.argv[1]).lookup_whois()['nets'][0]['description']\""

alias gistory="history | grep"

alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"

alias grepstat="netstat -pltun | grep -i -e proto -e"
#############################################################################

# parrot os prompt
source "$HOME/.config/zsh-theme/swag.zsh-theme"

# nvm specific config
# first run `brew install nvm`
# lazyload nvm by invoking manually
# this will load zsh much faster
nvm() {
    export NVM_DIR="$HOME/.nvm"
    # this loads nvm
    [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"
    # this loads nvm bash_completion
    [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"
    # might cause issue with directo perms and compaudit
    # run `compaudit | xargs chmod g-w` to fix
    # will remove write permissions from group
}

#alias aws-nm-login='/Users/<<NM lan id>>/.nvm/versions/node/v12.18.3/bin/aws-nm-login'
#export PATH="/usr/local/opt/openjdk@11/bin:$PATH"

## persistent tunnel
# alias tunnel='autossh -M 0 -o "ServerAliveInterval 30" -o "ServerAliveCountMax 3" kali -D 9090'

# golang specific
#export GOPATH=$HOME/go
#export GOROOT="$(brew --prefix golang)/libexec"
#export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"

# user vim key bidings in zsh shell
# set -o vi
# bindkey -v
# make backspace work as expected
# bindkey -v '^?' backward-delete-char

# generete ntlm hash - ntlm_hash wordToHash
# https://blog.atucom.net/2012/10/generate-ntlm-hashes-via-command-line.html
ntlm_hash () {
    iconv -f ASCII -t UTF-16LE <(printf "$1") | openssl dgst -md4
}

# turn on auto cd - now you can use aliases like `..` and `~` to change
# directory
setopt auto_cd

# turn off bracketed paste mode
# unset zle_bracketed_paste

# markdown KB - mostly for vim
# export KB_DIRECTORY=~/Documents/wiki/
export KB_DIRECTORY=~/workspace/wiki/

# open wiki index for quick scratch notes from anywhere in the terminal
alias wiki='vim +WikiIndex'

# pure zsh prompt
# https://github.com/sindresorhus/pure
# fpath+=($HOME/.zsh/pure)
# autoload -U promptinit; promptinit
# prompt pure
