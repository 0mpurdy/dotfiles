param([string] $username = $env:USERNAME)

echo "Pulling dotfiles for $username"

$dotfilesLoc='T:/dev/dotfiles'

cp "$env:USERPROFILE/Documents/WindowsPowerShell/profile.ps1" "$dotfilesLoc/win/legacy-profile.ps1" 2> $null
cp "$profile" "$dotfilesLoc/win/profile.ps1"
cp "$env:LOCALAPPDATA/nvim/init.vim" "$dotfilesLoc/editor/nvim/init.vim"
cp "$env:USERPROFILE/_vsvimrc" "$dotfilesLoc/editor/_vsvimrc"
cp "$env:USERPROFILE/.ideavimrc" "$dotfilesLoc/editor/.ideavimrc"
