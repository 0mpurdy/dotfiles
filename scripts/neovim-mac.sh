confirm() {
  action=$1
  read -r -p "Do you wish to ${action}? [y/N]" response
  case "$response" in
    [Yy][Ee][Ss]|[Yy])
      true
      ;;
    *)
      false
      ;;
  esac
}

confirm 'Install Neovim'
confirmation=$?
if [[ "${confirmation}" -eq 0 ]]
then
  # https://github.com/neovim/neovim/wiki/Installing-Neovim
  brew install neovim
fi

confirm 'Install Neovim Python packages'
confirmation=$?
if [[ "${confirmation}" -eq 0 ]]
then
  # install python3 for neovim (required for deoplete)
  pip2 install --user neovim
  pip3 install --user neovim
fi

confirm 'Install Neovim node packages'
confirmation=$?
if [[ "${confirmation}" -eq 0 ]]
then
  npm install -g node
fi

confirm 'Install FZF'
confirmation=$?
if [[ "${confirmation}" -eq 0 ]]
then
  # https://github.com/junegunn/fzf#installation
  fzfdir="${HOME}/.fzf"
  git clone --depth 1 https://github.com/junegunn/fzf.git "${fzfdir}"
  echo "Don't forget to run ${fzfdir}/install"
fi

confirm 'install vim-plug'
confirmation=$?
if [[ "${confirmation}" -eq 0 ]]
then
  # https://github.com/junegunn/vim-plug
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

confirm 'install :Ag silver searcher'
confirmation=$?
if [[ "${confirmation}" -eq 0 ]]
then
  # https://github.com/ggreer/the_silver_searcher
  brew install the_silver_searcher
fi

confirm 'copy config files'
confirmation=$?
if [[ "${confirmation}" -eq 0 ]]
then
  # copy config (assumes default dotfiles dir)
  destFolder="${HOME}/.config/nvim"
  mkdir -p "${destFolder}"
  cp "${HOME}/dev/dotfiles/editor/nvim/init.vim"  "${destFolder}/init.vim"
fi

