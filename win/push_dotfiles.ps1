param([string] $username = $env:USERNAME)
New-Item -ItemType directory -Path "C:/Users/$username/Documents/WindowsPowerShell" -Force
cp "T:/dev/dotfiles/win/profile.ps1" "C:/Users/$username/Documents/WindowsPowerShell/profile.ps1"
New-Item -ItemType directory -Path "$env:LOCALAPPDATA/nvim" -Force
cp "T:/dev/dotfiles/editor/nvim/init.vim" "$env:LOCALAPPDATA/nvim/init.vim"
cp "T:/dev/dotfiles/win/_vimrc" "C:/Users/$username/_vimrc"
