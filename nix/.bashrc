# .bashrc
echo 'Hello Michael'

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Fedora : Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# third party installations
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export GOPATH=$HOME/dev/go
export GOBIN=$HOME/dev/go/bin

export EDITOR=nvim

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

  pandoc -s -f markdown -t html --css "$HOME/.config/pan.css" -o $outputfile $inputfile; open $outputfile
}

alias ll='ls -lah'
alias gst='git status -uall -s -b'
alias dev='cd ~/dev/'
alias ecfg="${EDITOR} ${HOME}/.bashrc"
alias epro="${EDITOR} ${HOME}/.profile"

source ~/.config/git-completion.bash
