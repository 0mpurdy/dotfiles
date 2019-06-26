param([string] $username = $env:USERNAME)

echo "Pulling dotfiles for $username"

$dotfilesLoc='C:/dev/dotfiles'
$profileDestination="C:/Users/$username/Documents/WindowsPowerShell"

cp "$profileDestination/profile.ps1" "$dotfilesLoc/win/profile.ps1"
cp "$env:LOCALAPPDATA/nvim/init.vim" "C:/dev/dotfiles/editor/nvim/init.vim"
