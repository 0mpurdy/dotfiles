param([string] $username = $env:USERNAME)

echo "Pushing dotfiles for $username"

$dotfilesLoc='T:/dev/dotfiles'

New-Item -ItemType directory -Path "$env:USERPROFILE/Documents/WindowsPowerShell" -Force
cp "$dotfilesLoc/win/profile.ps1" "$profile"
New-Item -ItemType directory -Path "$env:LOCALAPPDATA/nvim" -Force
cp "$dotfilesLoc/editor/nvim/init.vim" "$env:LOCALAPPDATA/nvim/init.vim"
cp "$dotfilesLoc/editor/_vsvimrc" "$env:USERPROFILE/_vsvimrc"
