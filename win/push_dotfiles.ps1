param([string] $username = $env:USERNAME)
cp C:/dev/dotfiles/win/profile.ps1 "C:/Users/$username/Documents/WindowsPowerShell/profile.ps1"
cp C:/dev/dotfiles/editor/nvim/init.vim "$env:LOCALAPPDATA/nvim/init.vim"
