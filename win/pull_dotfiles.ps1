param([string] $username = $env:USERNAME)
echo "Pulling dotfiles for $username"
cp "C:/Users/$username/Documents/WindowsPowerShell/profile.ps1" "C:/dev/dotfiles/win/profile.ps1"
cp "$env:LOCALAPPDATA/nvim/init.vim" "C:/dev/dotfiles/editor/nvim/init.vim"
