[ -f ~/.bashrc ] && source ~/.bashrc
[ -f ~/.tmux/tmux-completion.bash ] && source ~/.tmux/tmux-completion.bash

PATH=$PATH:/home/deploy/.cargo/bin
PATH=$PATH:/home/deploy/dotfiles/utils

export FZF_DEFAULT_COMMAND='ag -g ""'

set -o vi

alias vim="nvim"

function _update_ps1() {
    PS1="$(~/.powerline-shell/powerline-shell.py $? 2> /dev/null)"
}

if [ "$TERM" != "linux" ]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

alias chrome-extensions="/Users/josh/Library/Application Support/Google/Chrome/Default/Extensions"

# ctrl -> hold ctrl
# esc  -> tap  ctrl
#setxkbmap -option 'caps:ctrl_modifier'
#xcape -e 'Caps_Lock=Escape'

## get rid of command not found ##
alias cd..='cd ..'

## a quick way to get out of current directory ##
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'

function gem-cd() {
  echo "Changing into gem directory for $1"
  cd $(bundle show $1)
}

alias at="tmux a -t"
alias ta="tmux attach"

alias cag="ag -A 10 -B 10"
alias sag="sudo apt-get install"

alias gst="git status"
alias gp="git push"

alias pbcopy='xclip -selection c'
alias pbpaste='xclip -selection clipboard -o'

alias gif="git diff"
alias gis="git diff --staged"

alias gc="git commit -v"
alias gcm="git commit -m"

function ga() {
  for dir in "$@"
  do
    git add -A "$dir"
  done

  git status
}

function biggest-dirs () {
  sudo du -ch -d 1 | sort -hr
}

function vimrc() {
  vim ~/.vimrc
}

function sb() {
  source ~/.bash_profile
  echo "Sourced bash_profile"
}

function rc(){
  vim -p ~/.bash_profile ~/.tmux.conf ~/.vimrc
  source ~/.bash_profile
  tmux source-file ~/.tmux.conf
  echo "Sourced bash_profile and tmux.conf"
}


function bashrc() {
  vim ~/.bash_profile
  echo "Sourced bash_profile"
  source ~/.bash_profile
}

function et() {
  vim ~/.tmux.conf
  echo "Reloaded tmux config"
  tmux source-file ~/.tmux.conf
}

# TODO: turn into a file in a dir that we source along with all the rest
# (natural way to avoid namespace collisions, and use any scripting lang we please for the problem)
function watch-test() {
  filewatcher "test/**/*" "clear; zeus test test/$@";
}

function echo-test() {
  echo "zeus test test/$@"
}
