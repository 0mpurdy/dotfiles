dotpath="${HOME}/dev/dotfiles"

function overwrite_file {
  rm -rf $2
  cp $1 $2
}

overwrite_file "${dotpath}/pandoc/panread.css" "${HOME}/pan.css"
overwrite_file "$dotpath/editor/.vimrc" "${HOME}/.vimrc"
overwrite_file "${dotpath}/editor/nvim/init.vim" "${HOME}/.config/nvim/init.vim"
