dotpath="${HOME}/dev/dotfiles"

docopy() {
  if [ ! -f $1 ]; then
    echo "Could not find \"$1\""
  else
    echo "Copying \"$1\" to \"$2\""
    cp $1 $2
  fi
}

docopy "${HOME}/.bashrc" "${dotpath}/nix/.bashrc"
docopy "${HOME}/.bash_aliases" "${dotpath}/nix/.bash_aliases"
docopy "${HOME}/.config/pan.css" "${dotpath}/pandoc/panread.css"
docopy "${HOME}/.vimrc" "${dotpath}/editor/.vimrc"
docopy "${HOME}/.profile" "${dotpath}/nix/.profile"
docopy "${HOME}/.config/nvim/init.vim" "${dotpath}/editor/nvim/init.vim"
