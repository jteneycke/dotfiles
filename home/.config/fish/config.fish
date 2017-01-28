fish_vi_key_bindings

set PATH ~/scripts $PATH
set PATH /Applications/Postgres.app/Contents/Versions/latest/bin $PATH
set PATH ~/.cargo/bin $PATH

set -Ux EDITOR vim

function fish_prompt
  ~/programs/powerline-shell/powerline-shell.py $status --shell bare ^/dev/null
end

# Work aliases
function clear-sessions
  telnet localhost 11211;
  flush_all;
end

function start-server
  docker-compose run --service-ports app
end

function specs
  docker-compose run app rspec (echo $argv)
end

alias solr-tunnel="ssh -L 192.168.99.1:8985:172.31.20.138:8985 solr.homestars.com"
alias stage-db-tunnel="ssh -L 192.168.99.1:3307:staging-homestars-com-cluster.cluster-clywwsjgdawg.us-east-1.rds.amazonaws.com:3306 homestars.biz"

function dock-sql
  docker exec -it (echo $argv) bash
end


function be
  bundle exec (echo $argv)
end

function dcr
  docker-compose run app (echo $argv)
end

function dock-bash
  docker exec -i -t (echo $argv) /bin/bash
end
 
alias dock-load="eval (docker-machine env)"
alias dock-up="docker-compose up"
alias dock-bundle="docker-compose run app bundle"
#alias dock-bash="docker run -i -t homestarswww_app /bin/bash"


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

function gcm
  git commit -m (echo $argv);
end

function gcb
  git checkout -b (echo $argv);
end

function ga
  git add -A;
  git status;
end

function gst
  git status
end

function gif
  git diff
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
