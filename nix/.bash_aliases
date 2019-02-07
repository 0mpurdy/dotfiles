alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

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

alias gst='git status -uall -s -b'
alias dev='cd ~/dev/'
alias ecfg="${EDITOR} ${HOME}/.bashrc"
alias epro="${EDITOR} ${HOME}/.profile"
