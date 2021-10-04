# https://github.com/neovim/neovim/wiki/Installing-Neovim
choco install neovim -y

# install python 3
choco install python3 --pre -y
python -m pip install pynvim

# https://github.com/junegunn/vim-plug
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$env:LOCALAPPDATA/nvim-data/site/autoload/plug.vim" -Force

Write-Output "`n`n`n`nYou may need to add 'C:\tools\neovim\Neovim\bin' to the Path"
