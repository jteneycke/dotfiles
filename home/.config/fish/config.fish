#fish_vi_key_bindings

set PATH ~/scripts $PATH
set PATH ~/dotfiles/utils $PATH
set PATH /Applications/Postgres.app/Contents/Versions/latest/bin $PATH
set PATH ~/.cargo/bin $PATH

set -Ux EDITOR vim

function fish_prompt
  ~/.powerline-shell/powerline-shell.py $status --shell bare ^/dev/null
end

alias vim="nvim"

# Work aliases
function clear-sessions
  telnet localhost 11211;
  flush_all;
end


alias serve-3000="rails s puma -b 127.0.0.1 -p 3000"
alias serve-3001="rails s puma -b 127.0.0.1 -p 3001"

function stage-puma-restart
  env to=staging mina puma:stop
  env to=staging mina puma:start
end

function test-migrate
  env RAILS_ENV=test bundle exec rake db:migrate db:test:prepare;
  env RAILS_ENV=test bundle exec rake db:seed;
end

function test-clone-structure
  bundle exec rake db:test:clone_structure
end

function be
  bundle exec (echo $argv)
end

function ctag-rails-and-deps
  #ctags -R --languages=ruby --exclude=.git --exclude=log . (bundle list --paths)
  ctags -R --languages=ruby --exclude=.git --exclude=log .
end

alias tmuxrc="nvim ~/.tmux.conf"

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
