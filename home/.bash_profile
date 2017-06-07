[ -f ~/.bashrc ] && source ~/.bashrc
[ -f ~/.tmux/tmux-completion.bash ] && source ~/.tmux/tmux-completion.bash

PATH=$PATH:/home/deploy/.cargo/bin
PATH=$PATH:/home/deploy/dotfiles/utils
PATH=$PATH:/home/deploy/.local/bin

EDITOR=nvim

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

alias c="clear"

alias api="cd ~/actively_developing/api"
alias www="cd ~/actively_developing/www"
alias router="cd ~/actively_developing/router"
alias dotfiles="cd ~/dotfiles"

alias mas="git checkout master"

function git-user-stats() {
  git ls-tree --name-only -z -r HEAD | egrep -z -Z -E '\.(rb|txt)$' | xargs -0 -n1 git blame --line-porcelain | grep "^author " | sort | uniq -c | sort -nr
}

function confirm()
{
  #alert the user what they are about to do.
  echo -e "Run? \e[0;96m$@\e[m";
  #confirm with the user
  read -r -p "Are you sure? [Y/n]" response
  case "$response" in
    [yY][eE][sS]|[yY])
      #if yes, then execute the passed parameters
      "$@"
      ;;
    *)
      #Otherwise exit...
      echo "Did not run command."
      #exit
      ;;
  esac
}

function deploy-to() {
  confirm to=$1 branch=$(git rev-parse --abbrev-ref HEAD) mina deploy --trace
}

function recent-branches() {
  git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format='%(refname:short)' | head -n 10
}

function bundle-ctags() {
  ctags -R --languages=ruby --exclude=.git --exclude=log . $(bundle list --paths)
}

function ctag-me(){
  ctags -R --languages=ruby --exclude=.git --exclude=log .
}

function test-migrate() {
  RAILS_ENV=test bundle exec rake db:migrate db:test:prepare;
  RAILS_ENV=test bundle exec rake db:seed;
}

function test-clone-structure() {
  bundle exec rake db:test:clone_structure
}

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

function rebase-master(){
  git checkout master && git pull && git checkout - && git rebase master
}

function ssh-it() {
  eval `ssh-agent -s`;
  ssh-add
}

# https://stackoverflow.com/questions/6958689/xargs-with-multiple-commands-as-argument
function each() {
  while read line; do
    for f in "$@"; do
      $f $line
    done
  done
}

function stage-puma-restart() {
  to=staging mina puma:stop
  to=staging mina puma:start
}

#alias stage-puma-stop="to=staging mina puma:stop"
#alias stage-puma-start="to=staging mina puma:start"

alias serve-3000="rails s puma -b 127.0.0.1 -p 3000"
alias serve-3001="rails s puma -b 127.0.0.1 -p 3001"

alias f="rg -C 5"

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

alias gap="git add -p"
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
