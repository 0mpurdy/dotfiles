# third party installations
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# personal bashrc
alias panread='pandoc -s -f markdown -t html --css ~/.config/pan.css -o README.md.html README.md; open README.md.html'

function pan() {
  # Convert README to html (or another file if specified)
  if [ -z ${1+x} ]; then 
    echo "Using README.md as filepath not specified"; 
    inputfile="README.md"
  else 
    echo "Converting $1"; 
    inputfile=$1
  fi
  outputfile="$inputfile.html"

  pandoc -s -f markdown -t html --css ~/.config/pan.css -o $outputfile $inputfile; open $outputfile
}

alias ll='ls -lah'
alias gst='git status -uall -s -b'
alias cdev='cd ~/dev/'

export EDITOR=nvim

export GOPATH=$HOME/dev/go
export GOBIN=$HOME/dev/go/bin

source ~/.config/git-completion.bash
