#fish_vi_key_bindings

set PATH ~/scripts $PATH
set PATH /Applications/Postgres.app/Contents/Versions/latest/bin $PATH
set PATH ~/.cargo/bin $PATH

set -Ux EDITOR vim

function fish_prompt
  ~/.powerline-shell/powerline-shell.py $status --shell bare ^/dev/null
end

# Work aliases
function clear-sessions
  telnet localhost 11211;
  flush_all;
end

function be
  bundle exec (echo $argv)
end

function ctag-rails-and-deps
  #ctags -R --languages=ruby --exclude=.git --exclude=log . (bundle list --paths)
  ctags -R --languages=ruby --exclude=.git --exclude=log .
end

# Personal Aliases

set fish_greeting ""

function fishrc
  vim ~/.config/fish/config.fish
  echo "Sourcing config.fish ..."
  source ~/.config/fish/config.fish
end

function vimrc
  vim ~/.vimrc
end

function git-rm
  git rm -r --cached (echo $argv);
end

alias gc="git commit"

function gcm
  git commit -m (echo $argv);
end

function gcb
  git checkout -b (echo $argv);
end

function ga
  git add -A (echo $argv);
  git status;
end

function gst
  git status
end

function gif
  git diff
end

function gis
  git diff --staged
end

function cag
  ag -A 10 -B 10 (echo $argv)
end

function lag
  ag -l (echo $argv)
end

function f
  history | grep -i (echo $argv);
end

source ~/.asdf/asdf.fish
#rvm default
