#!/usr/bin/env bash

[ -f ~/.bashrc ] && source ~/.bashrc
[ -f ~/.tmux/tmux-completion.bash ] && source ~/.tmux/tmux-completion.bash

# Paths
# ==========================================================================
PATH=$PATH:/home/deploy/.cargo/bin
PATH=$PATH:/home/deploy/dotfiles/utils
PATH=$PATH:/home/deploy/.local/bin

export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

source ~/dotfiles/fzf-tmux

# Work
# ==========================================================================
alias dotfiles="cd ~/dotfiles"
alias api="cd ~/actively_developing/api"
alias www="cd ~/actively_developing/www"

 #This is the same functionality as fzf's ctrl-t, except that the file or
 #directory selected is now automatically cd'ed or opened, respectively.
#fzf-open-file-or-dir() {
  #local cmd="command find -L . \
    #\\( -path '*/\\.*' -o -fstype 'dev' -o -fstype 'proc' \\) -prune \
    #-o -type f -print \
    #-o -type d -print \
    #-o -type l -print 2> /dev/null | sed 1d | cut -b3-"
  #local out=$(eval $cmd | fzf-tmux --exit-0)

  #if [ -f "$out" ]; then
    #$EDITOR "$out" < /dev/tty
  #elif [ -d "$out" ]; then
    #cd "$out"
    #zle reset-prompt
  #fi
#}
#zle     -N   fzf-open-file-or-dir
#bind -x '"\C-p": fzf-open-file-or-dir'


# Bash sugar
# ==========================================================================
set -o vi
EDITOR=nvim
alias vim="nvim"

v() {
  local file
  file="$(fzf)" && nvim "${file}" || return 1
}

#eval "$(fasd --init auto)"
working-on-v() {
  local file
  #file="$(fasd -Rfl "$1" | fzf -1 -0 --no-sort +m)" && nvim "${file}" || return 1
  file="$(fasd -Rfl "$1" | fzf -1 -0 --no-sort +m)"
  echo "File: $file"
  echo "\$1:  $1"
}

#bindkey '^P' vim $(fzf)
bind -x '"\C-p": v'


# fhe - repeat history edit
writecmd (){ perl -e 'ioctl STDOUT, 0x5412, $_ for split //, do{ chomp($_ = <>); $_ }' ; }

fhe() {
  ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -re 's/^\s*[0-9]+\s*//' | writecmd
}

# fh - repeat history
runcmd (){ perl -e 'ioctl STDOUT, 0x5412, $_ for split //, <>' ; }

fh() {
  ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -re 's/^\s*[0-9]+\s*//' | runcmd
}
bind -x '"\C-f": fh'

# fkill - kill process
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}


# Get rid of command not found
alias cd..='cd ..'
# A quick way to get out of current directory
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'

function _update_ps1() {
    PS1="$(~/.powerline-shell/powerline-shell.py $? 2> /dev/null)"
}

if [ "$TERM" != "linux" ]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

function bashrc() {
  vim ~/.bash_profile
  echo "Sourced bash_profile"
  source ~/.bash_profile
}


# Vim
# ==========================================================================
function vimrc() {
  vim ~/.vimrc
}


# Utils
# ==========================================================================
alias c="clear"
alias pbcopy='xclip -selection c'
alias pbpaste='xclip -selection clipboard -o'
alias sag="sudo apt-get install"

# https://stackoverflow.com/questions/6958689/xargs-with-multiple-commands-as-argument
function each() {
  while read line; do
    for f in "$@"; do
      $f $line
    done
  done
}

function biggest-dirs () {
  sudo du -ch -d 1 | sort -hr
}

function rc(){
  vim -p ~/.bash_profile ~/.tmux.conf ~/.vimrc
  source ~/.bash_profile
  tmux source-file ~/.tmux.conf
  echo "Sourced bash_profile and tmux.conf"
}


# Grep it, grok it, good!
# ==========================================================================
alias f="rg -C 5"
alias cag="ag -A 10 -B 10"
export FZF_DEFAULT_COMMAND='ag -g ""'


# Tmux
# ==========================================================================
alias tmuxrc="nvim ~/.tmux.conf"
alias at="tmux a -t"
alias ta="tmux attach"

function et() {
  vim ~/.tmux.conf
  echo "Reloaded tmux config"
  tmux source-file ~/.tmux.conf
}


# Git
# ==========================================================================
alias gst="git status"
alias gp="git push"
alias gif="git diff"
alias gis="git diff --staged"
alias gap="git add -p"
alias gc="git commit -v"
alias gcm="git commit -m"
alias mas="git checkout master"

function git-user-stats() {
  git ls-tree --name-only -z -r HEAD | egrep -z -Z -E '\.(rb|txt)$' | xargs -0 -n1 git blame --line-porcelain | grep "^author " | sort | uniq -c | sort -nr
}

function recent-branches() {
  git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format='%(refname:short)' | head -n 10
}

function rebase-master(){
  git checkout master && git pull && git checkout - && git rebase master
}

function ga() {
  for dir in "$@"
  do
    git add -A "$dir"
  done
  git status
}


# Rails
# ==========================================================================
alias serve-3000="rails s puma -b 127.0.0.1 -p 3000"
alias serve-3001="rails s puma -b 127.0.0.1 -p 3001"

function ssh-it() {
  eval `ssh-agent -s`;
  ssh-add
}

function stage-puma-restart() {
  to=staging mina puma:stop
  to=staging mina puma:start
}

function test-migrate() {
  RAILS_ENV=test bundle exec rake db:migrate db:test:prepare;
  RAILS_ENV=test bundle exec rake db:seed;
}

function test-clone-structure() {
  bundle exec rake db:test:clone_structure
}

function bundle-ctags() {
  ctags -R --languages=ruby --exclude=.git --exclude=log . $(bundle list --paths)
}

function ctag-me(){
  ctags -R --languages=ruby --exclude=.git --exclude=log .
}

function gem-cd() {
  echo "Changing into gem directory for $1"
  cd $(bundle show $1)
}

# TODO: turn into a file in a dir that we source along with all the rest
# (natural way to avoid namespace collisions, and use any scripting lang we please for the problem)
function watch-test() {
  filewatcher "test/**/*" "clear; zeus test test/$@";
}

function echo-test() {
  echo "zeus test test/$@"
}


# WIP - deploy command wrapper
# ==========================================================================

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


