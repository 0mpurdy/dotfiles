# https://github.com/neovim/neovim/wiki/Installing-Neovim
add-apt-repository ppa:neovim-ppa/stable
apt-get update
apt-get install neovim

apt-get install python-dev python-pip python3-dev python3-pip

# https://github.com/junegunn/fzf#installation
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# https://github.com/junegunn/vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# copy config (assumes default dotfiles dir)
mkdir ~/.config
mkdir ~/.config/nvim
cp "${HOME}/dev/dotfiles/editor/nvim/init.vim" ~/.config/nvim/init.vim

# install python3 for neovim (required for deoplete)
python3 -m pip install neovim
