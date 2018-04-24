set nocompatible  " not compatible with vi
syntax on         " use syntax highlighting
filetype plugin indent on " vim autodetects file type (can't remember what indent does)

" tab controls (more info at https://tedlogan.com/techblog3.html)
set expandtab       " change tab key to insert spaces
set tabstop=2       " existing tabs look like 2 spaces
set shiftwidth=2    " >> indent 2 spaces
set softtabstop=2   " with expand tab not set combination of spaces will be used

set number relativenumber   " use hybrid line numbers (https://jeffkreeftmeijer.com/vim-number/)
set splitright              " new windows in a vertical split open to the right
set hidden                  " don't ask to save before switching buffers

set directory^=$HOME/.vim/tmp//   " Use central location for swp files

" ************************ Plugins **********************************

" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

Plug 'tpope/vim-fugitive'                                  " https://github.com/tpope/vim-fugitive

" Fuzzy find
Plug 'junegunn/fzf.vim'
set rtp+=/usr/local/opt/fzf

" surround with quotes or brackets
Plug 'tpope/vim-surround'

" Auto completion
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1

" Directory navigation
Plug 'scrooloose/nerdtree'

" Initialize plugin system
call plug#end()

" ********************* Keyboard mappings *************************

let mapleader=" " " set leader to space
" map double leader (space) to command
nmap <leader><leader> :
" map FZF plugin to hypen
nmap - :FZF<CR>
" map half page moves to ctrl + direction
nmap <C-j> <C-d>zz
nmap <C-k> <C-u>zz
" map window moves to leader
nmap <leader>w <C-w>
nmap <leader>h <C-w>h
nmap <leader>l <C-w>l
" handier end of line key
map \ $
" use gx to open files
:let g:netrw_browsex_viewer= "open -a Firefox"
" replace word under cursor
:nnoremap <Leader>s :%s/\<<C-r><C-w>\>/
" find word under cursor
:nnoremap <Leader>/ /\<<C-r><C-w>\><CR>
" find word in all files
:nnoremap K :grep ' **/*.py<S-Left><S-Left>'
" net in quickfix list
:nnoremap = :cn<CR>

" search for visually selected text
vnoremap // y/<C-R>"<CR>
" find and replace visually selected text
:vnoremap /s y:%s/<C-R>"/

" Set indent folding
:nnoremap <leader>z :set foldmethod=indent<CR>zM<CR>
:nnoremap <leader>v :vsp<CR>

" Open neovim terminal
:nnoremap <leader>t :vsp<CR>:terminal<CR>A

" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" ********************* Terminal mappings ***************************

" Map <Esc> to quitting the terminal
:tnoremap <Esc> <C-\><C-n>

" ********************* Commands ************************************
" git diff
":command GD !clear;git diff
" Edit vim settings
:command! EVIM e ~/.vimrc
" Edit vim settings
:command! ENVIM e ~/.config/nvim/init.vim
" Source vim settings
:command! RVIM source ~/.config/nvim/init.vim

" Cover short tests pytorch
:command! PyCS !pytest --cov=. --cov-report term-missing:skip-covered -m 'not long'

" Search current directory for text
:command! -nargs=1 CSearch vimgrep "<args>" ./**/*.py ./**/*.txt
:nnoremap <leader>] :CSearch 

" *************** Python specific settings ***************************

" F4 to run curret dir
autocmd FileType python nmap <F4> <Esc><Esc>:!clear;python .<CR>
" F5 to run current file
autocmd FileType python nmap <F5> <Esc>:w<CR>:!clear;python %<CR>
" F6 to run short tests
autocmd FileType python nmap <F6> :w<CR>:!clear;pytest -v -m "not long"<CR>
" F7 to run single test with debugging
autocmd FileType python nmap <F7> :w<CR>:!clear;pytest -v --pdb %<CR>
" F8 to run all tests
autocmd FileType python nmap <F8> :w<CR>:!clear;pytest -v<CR>
" F9 to run code coverage
autocmd FileType python nmap <F9> :w<CR>:!pytest --cov=. --cov-report term-missing:skip-covered<CR>
" F10 to run code coverage for single file
autocmd FileType python nmap <F10> :w<CR>:!pytest % --cov=. --cov-report term-missing<CR>
" F1 to auto format file
autocmd FileType python nmap <F1> :w<CR>:!autopep8 -i %<CR>
" Ctrl + / to comment
autocmd FileType python nmap <C-_> 0i# <Esc>j
" + to uncomment
autocmd FileType python nnoremap + 02xj
" http://vim.wikia.com/wiki/Macros
nmap , @q

