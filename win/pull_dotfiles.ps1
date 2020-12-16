param([string] $username = $env:USERNAME)
echo "Pulling dotfiles for $username"
cp "C:/Users/$username/Documents/WindowsPowerShell/profile.ps1" "T:/dev/dotfiles/win/profile.ps1"
cp "$env:LOCALAPPDATA/nvim/init.vim" "T:/dev/dotfiles/editor/nvim/init.vim"
cp "C:/Users/$username/_vimrc" "T:/dev/dotfiles/win/_vimrc"
