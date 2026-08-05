dotpath="${HOME}/dev/dotfiles"

doreplace() {
  if [ -d "${2}" ]; then
    rm -rf "${2}"
  fi

  if [ ! -f $1 ] && [ ! -d $1 ]; then
    echo "Could not find \"$1\""
  else
    echo "Copying $1 to $2"
    cp -r $1 $2
  fi
}

doreplace "${dotpath}/nix/.bashrc" "${HOME}/.bashrc"
doreplace "${dotpath}/nix/.zshrc" "${HOME}/.zshrc"
doreplace "${dotpath}/nix/.bash_aliases" "${HOME}/.bash_aliases"
doreplace "${dotpath}/nix/.globalrgignore" "${HOME}/.globalrgignore"
doreplace "${dotpath}/editor/.vimrc" "${HOME}/.vimrc"
doreplace "${dotpath}/nix/.profile" "${HOME}/.profile"
doreplace "${dotpath}/editor/nvim/." "${HOME}/.config/nvim/"
doreplace "${dotpath}/gpg/default.conf" "${HOME}/.gnupg/gpg-agent.conf"
doreplace "${dotpath}/opencode/." "${HOME}/.opencode/"
