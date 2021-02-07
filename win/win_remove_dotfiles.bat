@echo off
SETLOCAL

echo "Home path: %HOME%"
SET dotpath=c:/dev/dotfiles

call :remove "%HOME%/_vimrc"
call :remove "%HOME%/AppData/Local/nvim/init.vim"
call :remove "%HOME%/.config/nvim/init.vim"

EXIT /B %ERRORLEVEL%

:remove
echo removing "%~1"
rm -rf %~1
EXIT /B 0
