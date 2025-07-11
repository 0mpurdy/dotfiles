dotpath="${HOME}/dev/dotfiles"

docopy() {
  if [ ! -f $1 ] && [ ! -d $1 ]; then
    echo "Could not find \"$1\""
  else
    echo "Copying $1 to $2"
    cp -r $1 $2
  fi
}

docopy "${dotpath}/nix/.bashrc" "${HOME}/.bashrc"
docopy "${dotpath}/nix/.zshrc" "${HOME}/.zshrc"
docopy "${dotpath}/nix/.bash_aliases" "${HOME}/.bash_aliases"
docopy "${dotpath}/editor/.vimrc" "${HOME}/.vimrc"
docopy "${dotpath}/nix/.profile" "${HOME}/.profile"
docopy "${dotpath}/editor/nvim/" "${HOME}/.config/nvim/"
