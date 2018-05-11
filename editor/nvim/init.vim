set nocompatible          " not compatible with vi
syntax on                 " use syntax highlighting
filetype plugin indent on " vim autodetects file type (can't remember what indent does)

" *************************** Tabbing ***************************

" (more info at https://tedlogan.com/techblog3.html)
set expandtab       " change tab key to insert spaces
set tabstop=2       " existing tabs look like 2 spaces
set shiftwidth=2    " >> indent 2 spaces
set softtabstop=2   " with expand tab not set combination of spaces will be used

" ****************************** Misc ******************************

set number relativenumber         " use hybrid line numbers (https://jeffkreeftmeijer.com/vim-number/)
set splitright                    " new windows in a vertical split open to the right
set hidden                        " don't ask to save before switching buffers
set directory^=$HOME/.vim/tmp//   " Use central location for swp files

" ************************* Leader mappings *************************

let mapleader=" " " set leader to space
" map double leader (space) to command
:nnoremap <leader><leader> :
" Set indent folding
:nnoremap <leader>z :set foldmethod=indent<CR>zM<CR>
:nnoremap <leader>v :vsp<CR>

" toggle list chars
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
:nnoremap <leader>= :set list!<cr>

" ********************** Function key mappings **********************

" toggle search highlighting
:noremap <F2> :set hlsearch! hlsearch?<cr>

" ********************** Keyboard mappings **************************

" handier end of line key
:noremap \ $
" use gx to open files
:let g:netrw_browsex_viewer= "open -a Firefox"
" next in quickfix list
:nnoremap = :cn<CR>
" http://vim.wikia.com/wiki/Macros
:nnoremap , @q

" ************************ Plugins **********************************

" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

Plug 'flazz/vim-colorschemes'   " Colorschemes
Plug 'tpope/vim-surround'       " surround with quotes or brackets

Plug 'tpope/vim-fugitive'       " Git integration
set diffopt+=vertical

Plug 'scrooloose/nerdtree'      " Directory navigation
:nnoremap <leader>n :NERDTreeToggle<cr>

Plug 'junegunn/fzf.vim'         " Fuzzy find
set rtp+=/usr/local/opt/fzf
" map FZF plugin to hypen
:nnoremap - :FZF<CR>

" Auto completion
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1
" deoplete tab-complete
:inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

Plug 'w0rp/ale'                 " Linting
" ALE error navigation
:nnoremap ]e :ALENextWrap<cr>
:nnoremap [e :ALEPreviousWrap<cr>
:nnoremap <leader>a :ALEToggle<cr>

" Typescript support
Plug 'mhartington/nvim-typescript'
" Typescript syntax highlighting
Plug 'leafgarland/typescript-vim'

" Initialize plugin system
call plug#end()

" ************************** Colorscheme **************************

colo monokain

" *********************** Navigating windows ***********************

" map half page moves to ctrl + direction
:nnoremap <C-j> <C-d>zz
:nnoremap <C-k> <C-u>zz
" map window moves to leader
:nnoremap <leader>w <C-w>
:nnoremap <leader>h <C-w>h
:nnoremap <leader>l <C-w>l

" ************************ Find and replace ************************

" search for visually selected text
:vnoremap // y/<C-R>"<CR>
" find and replace visually selected text
:vnoremap /s y:%s/<C-R>"/
" find word in all files
:nnoremap K :grep ' **/*.py<S-Left><S-Left>'
" replace word under cursor
:nnoremap <Leader>s :%s/\<<C-r><C-w>\>/
" find word under cursor
:nnoremap <Leader>/ /\<<C-r><C-w>\><CR>

" ******************** Neovim terminal mappings ********************

" Open neovim terminal
:nnoremap <leader>t :vsp<CR>:terminal<CR>A
" Map <Esc> to quitting the terminal
:tnoremap <Esc> <C-\><C-n>

" **************************** Commands ****************************

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
" Cover all pytest
:command! PytestCoverAll !pytest --cov=. --cov-report term-missing
" Recreate python ctags
:command! PythonCTags !ctags -R --languages=python -f ./tags .

" Search current directory for text
:command! -nargs=1 CSearch noautocmd vimgrep "<args>" ./**/*.py ./**/*.txt
:nnoremap <leader>] :CSearch 

" Copy line to OS clipboard
:command! CLine execute "normal! \"*yy"
:command! PLine execute "normal! \"*p"

" ********************* Python specific settings *********************

" F4 to run current dir
autocmd FileType python nnoremap <F4> <Esc><Esc>:!clear;python .<CR>
" F5 to run current file
autocmd FileType python nnoremap <F5> :w<CR>:vsp term://python %<CR>
" F6 to run unit tests
autocmd FileType python nnoremap <F6> :w<CR>:vsp term://pytest -v -m 'not long'<CR>
" F7 to run single test with debugging
autocmd FileType python nnoremap <F7> :w<CR>:vsp term://pytest -v --pdb %<CR>
" F8 to run all tests
autocmd FileType python nnoremap <F8> :w<CR>:vsp term://pytest -v<CR>
" F9 to run code coverage
autocmd FileType python nnoremap <F9> :w<CR>:vsp term://pytest --cov=. --cov-report term-missing:skip-covered<CR>
" F10 to run code coverage for single file
autocmd FileType python nnoremap <F10> :w<CR>:vsp term://pytest % --cov=. --cov-report term-missing<CR>
" F1 to auto format file
autocmd FileType python nnoremap <F1> :w<CR>:!autopep8 -i --aggressive --aggressive %<CR>

" Ctrl + / to comment
autocmd FileType python nnoremap <C-_> 0i# <Esc>j
" + to uncomment
autocmd FileType python nnoremap + 02xj

