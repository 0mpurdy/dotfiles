dotpath="${HOME}/dev/dotfiles"

docopy() {
  if [ ! -f $1 ] && [ ! -d $1 ]; then
    echo "Could not find \"$1\""
  else
    echo "Copying \"$1\" to \"$2\""
    cp -r $1 $2
  fi
}

docopy "${HOME}/.bashrc" "${dotpath}/nix/.bashrc"
docopy "${HOME}/.zshrc" "${dotpath}/nix/.zshrc"
docopy "${HOME}/.bash_aliases" "${dotpath}/nix/.bash_aliases"
docopy "${HOME}/.mac.bashrc" "${dotpath}/nix/.mac.bashrc"
docopy "${HOME}/.config/pan.css" "${dotpath}/pandoc/panread.css"
docopy "${HOME}/.vimrc" "${dotpath}/editor/.vimrc"
docopy "${HOME}/.profile" "${dotpath}/nix/.profile"
docopy "${HOME}/.config/nvim/init.vim" "${dotpath}/editor/nvim/init.vim"
docopy "${HOME}/.config/nvim/lua/config.lua" "${dotpath}/editor/nvim/config.lua"
docopy "${HOME}/.config/nvim/lua/config/" "${dotpath}/editor/nvim/config/"
