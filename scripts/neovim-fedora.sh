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

echo "Using ${HOME} - to change home directory pass -E (or equivalent) to sudo command"

confirm 'Install Neovim'
confirmation=$?
if [[ "${confirmation}" -eq 0 ]]
then
  # https://github.com/neovim/neovim/wiki/Installing-Neovim
  dnf -y install neovim
fi

confirm 'Install Neovim Python packages'
confirmation=$?
if [[ "${confirmation}" -eq 0 ]]
then
  dnf -y install python2-neovim python3-neovim
  # install python3 for neovim (required for deoplete)
  python3 -m pip install neovim
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

confirm 'copy config files'
confirmation=$?
if [[ "${confirmation}" -eq 0 ]]
then
  # copy config (assumes default dotfiles dir)
  destFolder="${HOME}/.config/nvim"
  mkdir -p "${destFolder}"
  cp "${HOME}/dev/dotfiles/editor/nvim/init.vim"  "${destFolder}/init.vim"
fi

echo 'You may need to change the owner of the following files:'
echo "${HOME}/.fzf"
echo "${HOME}/.config/nvim"
echo "${HOME}/.local/share/nvim folder may also need changed"
echo '$ sudo chown -R username:username folder/'
