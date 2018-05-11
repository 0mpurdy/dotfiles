dotpath='~/dev/dotfiles'

function overwrite_with_link {
  echo "$2    ->    $1"
  rm -rf $2
  ln -sf $1 $2
}

overwrite_with_link "$dotpath/pandoc/panread.css" ~/pan.css
overwrite_with_link "$dotpath/editor/.vimrc" ~/.vimrc
overwrite_with_link "$dotpath/editor/nvim/init.vim" ~/.config/nvim/init.vim
