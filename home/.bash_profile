source $HOME/.bashrc
source $HOME/.tmux/tmux-completion.bash
PATH=$PATH:/home/deploy/.cargo/bin

set -o vi

function _update_ps1() {
    PS1="$(~/.powerline-shell/powerline-shell.py $? 2> /dev/null)"
}

if [ "$TERM" != "linux" ]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi


# ctrl -> hold ctrl
# esc  -> tap  ctrl
#setxkbmap -option 'caps:ctrl_modifier'
#xcape -e 'Caps_Lock=Escape'

alias at="tmux a -t"

alias cag="ag -A 10 -B 10"
alias sag="sudo apt-get install"

alias gst="git status"
alias gp="git push"

alias pbcopy='xclip -selection c'
alias pbpaste='xclip -selection clipboard -o'

alias gif="git diff"
alias gcm="git commit -m"

function ga () {
  git add -A "$x" && git status
}

function biggest-dirs () {
  sudo du -ch -d 1 | sort -hr
}

function vimrc() {
  vim ~/.vimrc
}

function edit-bash() {
  vim ~/.bash_profile
  echo "Sourcing bash_profile"
  source ~/.bash_profile
}

function edit-tmux() {
  vim ~/.tmux.conf
  echo "Reloading tmux config"
  tmux source-file ~/.tmux.conf
}

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
