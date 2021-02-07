param([string] $username = $env:USERNAME)

echo "Pulling dotfiles for $username"

$dotfilesLoc='T:/dev/dotfiles'

cp "$profile" "$dotfilesLoc/win/profile.ps1"
cp "$env:LOCALAPPDATA/nvim/init.vim" "$dotfilesLoc/editor/nvim/init.vim"
cp "C:/Users/$username/_vimrc" "$dotfilesLoc/win/_vimrc"
