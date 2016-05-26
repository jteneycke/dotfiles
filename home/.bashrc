#!/bin/bash 

for file in ~/.bash/*.bash; do
  source $file
done

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Load nvm
export NVM_DIR="${HOME}/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
