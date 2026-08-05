dotpath="${HOME}/dev/dotfiles"

doreplace() {
  if [ -d "${2}" ]; then
    rm -rf "${2}"
  fi

  if [ ! -f $1 ] && [ ! -d $1 ]; then
    echo "Could not find \"$1\""
  else
    echo "Copying \"$1\" to \"$2\""
    cp -r "$1" "$2"
  fi
}

doreplace "${HOME}/.bashrc" "${dotpath}/nix/.bashrc"
doreplace "${HOME}/.zshrc" "${dotpath}/nix/.zshrc"
doreplace "${HOME}/.bash_aliases" "${dotpath}/nix/.bash_aliases"
doreplace "${HOME}/.mac.bashrc" "${dotpath}/nix/.mac.bashrc"
doreplace "${HOME}/.globalrgignore" "${dotpath}/nix/.globalrgignore"
doreplace "${HOME}/.config/pan.css" "${dotpath}/pandoc/panread.css"
doreplace "${HOME}/.vimrc" "${dotpath}/editor/.vimrc"
doreplace "${HOME}/.profile" "${dotpath}/nix/.profile"
doreplace "${HOME}/.config/nvim/." "${dotpath}/editor/nvim"
doreplace "${HOME}/.gnupg/gpg-agent.conf" "${dotpath}/gpg/default.conf"
doreplace "${HOME}/.opencode/." "${dotpath}/opencode/"

rm -rf "${dotpath}/editor/nvim/lazy-lock.json"
