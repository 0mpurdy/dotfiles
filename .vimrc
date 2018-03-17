syntax on                 " use syntax highlighting
filetype plugin indent on " vim autodetects file type (can't remember what indent does)

" tab controls (more info at https://tedlogan.com/techblog3.html)
set expandtab       " change tab key to insert spaces
set tabstop=2       " existing tabs look like 2 spaces
set shiftwidth=2    " >> indent 2 spaces
set softtabstop=2   " with expand tab not set combination of spaces will be used

" use hybrid line numbers (https://jeffkreeftmeijer.com/vim-number/)
set number relativenumber

autocmd FileType python nmap <F5> <Esc>:w<CR>:!clear;python %<CR>

" add ctrlp pluging (http://ctrlpvim.github.io/ctrlp.vim/#installation)
set runtimepath^=~/.vim/bundle/ctrlp.vim
set wildignore+=*/node_modules/*    " Linux/Mac
let g:ctrlp_working_path_mode = 'r' " default ctrlp directory - nearest ancestor with .git
