set nocompatible  " not compatible with vi
syntax on         " use syntax highlighting
filetype off      " required to be off for vundle

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" tab controls (more info at https://tedlogan.com/techblog3.html)
set expandtab       " change tab key to insert spaces
set tabstop=2       " existing tabs look like 2 spaces
set shiftwidth=2    " >> indent 2 spaces
set softtabstop=2   " with expand tab not set combination of spaces will be used

" use hybrid line numbers (https://jeffkreeftmeijer.com/vim-number/)
set number relativenumber

autocmd FileType python nmap <F5> <Esc>:w<CR>:!clear;python %<CR>
autocmd FileType python nmap <F6> :w<CR>:!clear;pytest -v<CR>
autocmd FileType python nmap <F1> :w<CR>:!autopep8 -i %<CR>

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'       " https://github.com/VundleVim/Vundle.vim

" add ctrlp pluging (http://ctrlpvim.github.io/ctrlp.vim/#installation)
" set runtimepath^=~/.vim/bundle/ctrlp.vim
Plugin 'ctrlpvim/ctrlp.vim'         " https://github.com/ctrlpvim/ctrlp.vim
set wildignore+=*/node_modules/*    " Linux/Mac
let g:ctrlp_working_path_mode = 'r' " default ctrlp directory - nearest ancestor with .git
Plugin 'Valloric/YouCompleteMe'     " https://valloric.github.io/YouCompleteMe/#installation
let g:ycm_add_preview_to_completeopt = 0
set completeopt-=preview

filetype plugin indent on " vim autodetects file type (can't remember what indent does)

" All of your Plugins must be added before the following line
call vundle#end()            " required

" http://vim.wikia.com/wiki/Macros
nmap , @q
let mapleader=" " " set leader to space

" map ctrlp plugin to hypen
nmap - <C-p>

" map half page moves to leader + direction
nmap <leader>j <C-d>
nmap <leader>k <C-u>
map \ $
