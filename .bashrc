alias panread='pandoc -s -f markdown -t html --css ~/.config/pan.css -o README.md.html README.md; open README.md.html'
alias ll='ls -lah'
alias gst='git status -uall -s -b'
alias godev='cd ~/dev/'

export EDITOR=nvim

source ~/.config/git-completion.bash
