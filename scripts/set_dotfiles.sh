dotpath="${HOME}/dev/dotfiles"

cp "${dotpath}/nix/.bashrc" "${HOME}/.bashrc"
cp "${dotpath}/pandoc/panread.css" "${HOME}/.config/pan.css"
cp "$dotpath/editor/.vimrc" "${HOME}/.vimrc"
cp "${dotpath}/editor/nvim/init.vim" "${HOME}/.config/nvim/init.vim"
