dotpath="${HOME}/dev/dotfiles"

cp "${HOME}/.bashrc" "${dotpath}/nix/.bashrc"
cp "${dotpath}/pandoc/panread.css" "${HOME}/.config/pan.css"
cp "${HOME}/.vimrc" "${dotpath}/editor/.vimrc"
cp "${HOME}/.profile" "${dotpath}/nix/.profile"
cp "${HOME}/.config/nvim/init.vim" "${dotpath}/editor/nvim/init.vim"
