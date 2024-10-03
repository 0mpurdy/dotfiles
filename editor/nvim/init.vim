" Needs manual installation of https://github.com/junegunn/vim-plug

set nocompatible          " not compatible with vi
syntax on                 " use syntax highlighting
filetype plugin indent on " vim autodetects file type (can't remember what indent does)

" ********************************** Tabbing **********************************

" (more info at https://tedlogan.com/techblog3.html)
set expandtab       " change tab key to insert spaces
set tabstop=2       " existing tabs look like 2 spaces
set shiftwidth=2    " >> indent 2 spaces
set softtabstop=2   " with expand tab not set combination of spaces will be used

" *********************************** Misc ************************************

set number relativenumber         " use hybrid line numbers (https://jeffkreeftmeijer.com/vim-number/)
set splitright                    " new windows in a vertical split open to the right
set hidden                        " don't ask to save before switching buffers
set directory^=$HOME/.vim/tmp//   " Use central location for swp files
set ignorecase
set colorcolumn=80,120            " Show column 80 and 120 line lengths

" ****************************** Leader mappings ******************************

let mapleader=" " " set leader to space
" map double leader (space) to command
:nnoremap <leader><leader> :
" Set indent folding
:nnoremap <leader>zi :set foldmethod=indent<CR>zM<CR>
:nnoremap <leader>zn zR<CR>:set foldmethod=manual<CR>
:nnoremap <leader>zf :norm zf%<CR>
:nnoremap <leader>zp :norm zfip<CR>
:nnoremap <leader>v :vsp<CR>

:vnoremap <leader>y "+y
:vnoremap <leader>p "+p
:vnoremap <leader>r d"0P

:nnoremap <leader>y "+y
:nnoremap <leader>p "+p
:nnoremap <leader>r diw"0P

" toggle list chars
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
:nnoremap <leader>= :set list!<cr>

" FZF Fuzzy find shortcut
:nnoremap <leader>f :GFiles<CR>
:nnoremap <leader>bb :Buffers<CR>

" Tail log file
:nnoremap <leader>G Gkzt

" insert log above
:nnoremap <leader>il Othis.logger.log(LogLevel.Trace, 'placeholder');<esc>==

" insert current date
:nnoremap <leader>id "=strftime("%F")<CR>p

" insert date time
:nnoremap <leader>it "=strftime('%FT%T%z')<cr>p

" insert random UUID
:nnoremap <leader>iu :r !uuidgen<cr>
:nnoremap <leader>iju :r !uuidgen\|sed 's/.*/"uuid": "&",/'\|tr "[A-Z]" "[a-z]"<cr>

" macro to convert PR link to markdown
" DevOps
"nnoremap <leader>mdp BEyiwa)<esc>Bi[PR !<esc>pa](<esc>

" macro to convert JIRA ticket link to markdown
nnoremap <leader>mdl gEWET/yEBEa)<esc>Bi[<esc>pa](<esc>

" macro to convert JIRA PR link to markdown
nnoremap <leader>mdp gEWEvT/ygEWEa)<esc>Bi[PR !<esc>pa](<esc>

" macro to remove markdown link syntax
nnoremap <leader>mdr F[xf]df)

" macro to copy previous link
nnoremap <leader>mdL ?\[.*\](<cr>f("+yi)

" Macro for tsx comment
vnoremap <leader>gc <esc>`<i{/*<esc>`>a*/}<esc>

" fuzzy search
command! -bang -nargs=* Agi call fzf#vim#ag(<q-args>, '--ignore=node_modules --ignore=package-lock.json', fzf#vim#with_preview(), <bang>0)
:nnoremap <leader>a :Agi<cr>

" Git mappings
nnoremap <leader>gl :Gclog %<cr>
nnoremap <leader>gh :0Gclog<cr>
nnoremap <leader>gb :Git blame<cr>

nnoremap <leader>gd <Plug>(doge-generate)

" *************************** Function key mappings ***************************

" toggle search highlighting
:noremap <F2> :set hlsearch! hlsearch?<cr>
:noremap <leader>2 :set hlsearch! hlsearch?<cr>

" *************************** Keyboard mappings *******************************

" handier end of line key
:noremap \ $

" Use Firefox as default browser
":let g:netrw_browsex_viewer= "open -a Firefox"

" next in quickfix list
:nnoremap ) :cn<CR>zz
" previous in quickfix list
:nnoremap ( :cp<CR>zz
" http://vim.wikia.com/wiki/Macros
:nnoremap , @q
:nnoremap Y y$

function! Test()
  if has('win32')
    :exe 'norm i' . expand('$USERNAME') . " is testing"
    echo "test"
  else
    :norm itesting
  endif
endfunction

" function! ReplaceConsole()
"     :bd!
"     :terminal
"     i
" endfunction

function! Split(match)
  :exe 's/' . a:match . '/\0\r/g'
endfunction

function! CopyJasmineTest()
  :norm VaB$hoky
  :exe "norm jjvaB\<esc>"
  :exe "norm o\<esc>pjzz0\<c-a>"
endfunction

function! CreateMockProvider()
  :norm ma
  :exe "norm 0wdf:i{ provide:\<esc>w\"yywA useValue: mock\<esc>\"ypA },\<esc>"
  :exe "norm ?beforeEach\<cr>Oconst mock\<esc>\"ypA = jasmine.createSpyObj(\'\<esc>\"ypA', ['placeholder']);\<cr>\<esc>"
  :norm 'aj
endfunction

" ***************************** Plugins ***************************************

let g:no_python_maps = 1

" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
if has('win32')
  call plug#begin('$USERPROFILE\AppData\Local\nvim-data\site\autoload')

  " Fuzzy find
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  " Neovim in firefox https://github.com/glacambre/firenvim
  "Plug 'file://c:\dev\nvim\firenvim', { 'do': function('firenvim#install') }

  " Powershell syntax highlighting
  Plug 'PProvost/vim-ps1'
else
  call plug#begin('~/.local/share/nvim/plugged')

  " Fuzzy find
  Plug 'junegunn/fzf.vim'
  set rtp+=~/.fzf
  let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'

  function! s:build_quickfix_list(lines)
    call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
    copen
    cc
  endfunction

  let g:fzf_action = {
    \ 'ctrl-q': function('s:build_quickfix_list') }

  " HTML edit
  Plug 'mattn/emmet-vim'

  " Colorschemes
  " surround with quotes or brackets
  Plug 'tpope/vim-surround'
  " For repeating plugin actions
  Plug 'tpope/vim-repeat'
  " For incrementing dates properly
  Plug 'tpope/vim-speeddating'
  " Better comment support
  Plug 'tpope/vim-commentary'
  " Some useful normal mode mappings
  "Plug 'tpope/vim-unimpaired'
  " Alignment tool
  Plug 'junegunn/vim-easy-align'
  " Start interactive EasyAlign in visual mode (e.g. vipga)
  xmap ga <Plug>(EasyAlign)
  " Start interactive EasyAlign for a motion/text object (e.g. gaip)
  nmap ga <Plug>(EasyAlign)

  " Auto completion
  if has('nvim')
    " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  else
    " if using venv - `pip install pynvim`
    "Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
  endif
  " let g:deoplete#enable_at_startup = 1
  " " deoplete tab-complete
  " :inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

  " Docs generation
  Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }

  " Linting
  Plug 'w0rp/ale'
  " ALE error navigation
  :nnoremap ]e :ALENextWrap<cr>
  :nnoremap [e :ALEPreviousWrap<cr>

  let g:ale_linters = {
  \ 'cs': ['OmniSharp'],
  \ 'javascript': ['eslint'],
  \ 'typescript': ['eslint'],
  \ 'typescriptreact': ['eslint'],
  \}

  let g:ale_fixers = {
  \ 'javascript': ['prettier'],
  \ 'typescript': ['prettier'],
  \ 'typescriptreact': ['prettier'],
  \ 'css': ['prettier'],
  \}

  let g:ale_linters_explicit = 1
  let g:ale_fix_on_save = 1

  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp'

  " Snippet support
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  let g:UltiSnipsExpandTrigger="ƒ"
  let g:UltiSnipsJumpForwardTrigger="<c-b>"
  let g:UltiSnipsJumpBackwardTrigger="<c-z>"

  " Required for nvim-typescript
  Plug 'HerringtonDarkholme/yats.vim'
  " Required for nvim-typescript
  Plug 'Shougo/denite.nvim'

  " Typescript support
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-lua/plenary.nvim'
  " Plug 'pmizio/typescript-tools.nvim'
  "Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
  " Typescript syntax highlighting
  "Plug 'leafgarland/typescript-vim'

  " Neovim syntax highlighting
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

  " React prettify tsx
  Plug 'prettier/vim-prettier', {
    \ 'do': 'yarn install --frozen-lockfile --production',
    \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }

endif

" Colorscheme
Plug 'navarasu/onedark.nvim'

" a nice one but not using right now
" Plug 'bluz71/vim-moonfly-colors'

" Directory navigation
Plug 'scrooloose/nerdtree'
:nnoremap <leader>no :NERDTreeToggle<cr>
:nnoremap <leader>nf :NERDTreeFind<cr>

" Git integration
Plug 'tpope/vim-fugitive'
set diffopt+=vertical

" C# support
Plug 'OmniSharp/omnisharp-vim'
" Use the stdio version of OmniSharp-roslyn:
let g:OmniSharp_server_stdio = 1
" let g:OmniSharp_server_path = '/Users/mike/Downloads/omnisharp-osx/run'

" Language Server Protocol manager (LSP)
Plug 'williamboman/mason.nvim'

" LSP configs
" Plug 'neovim/nvim-lspconfig'

" Initialize plugin system
call plug#end()

" ******************************** Colorscheme ********************************

let g:colors = getcompletion('', 'color')
func! NextColors()
    let idx = index(g:colors, g:colors_name)
    let current_color = g:colors_name
    let nextColor = (idx + 1 >= len(g:colors) ? g:colors[0] : g:colors[idx + 1])
    echo current_color .. '->' .. nextColor
    return nextColor
endfunc
func! PrevColors()
    let idx = index(g:colors, g:colors_name)
    let current_color = g:colors_name
    let prevColor = (idx - 1 < 0 ? g:colors[-1] : g:colors[idx - 1])
    echo current_color .. '->' .. prevColor
    return prevColor
endfunc
" nnoremap + :exe "colo " .. NextColors()<CR>
" nnoremap _ :exe "colo " .. PrevColors()<CR>

colorscheme industry

" Like Atom
let g:onedark_config = {
    \ 'style': 'warmer',
\}
silent! colorscheme onedark

" **************************** Navigating windows *****************************

" map half page moves to ctrl + direction
:nnoremap <C-j> <C-d>zz
:nnoremap <C-k> <C-u>zz
" map window moves to leader
:nnoremap <leader>w <C-w>
:nnoremap <leader>h <C-w>h
:nnoremap <leader>j <C-w>j
:nnoremap <leader>k <C-w>k
:nnoremap <leader>l <C-w>l
:nnoremap <leader>x <C-w>c

" Open visually selected file path in split to the left
:vnoremap <leader>o "1y<C-w>h:e <C-r>1<cr>

" ***************************** Find and replace ******************************

" search for visually selected text
:vnoremap // y/<C-R>"<CR>
" find and replace visually selected text
:vnoremap /s y:%s/<C-R>"/
" replace from yank register without overriding yank
:vnoremap R "_d"0P
" find word in all files
:nnoremap K :vimgrep ' **/*.ts<S-Left><S-Left>'
" :nnoremap <leader>K :grep -r --exclude-dir=node_modules --exclude="*.d.ts" --include "*.ts" --include "*.tsx" --include "*.py" ' ./src/ ./e2e<S-Left><S-Left><S-Left>'
:nnoremap <leader>K :grep -r --exclude-dir=node_modules --exclude-dir=venv --exclude="*.d.ts" --include "*.ts" --include "*.tsx" --include "*.py" ' ./<S-Left><S-Left>'
" replace word under cursor
:nnoremap <Leader>s :%s/\<<C-r><C-w>\>/
" find word under cursor
:nnoremap <Leader>/ /\<<C-r><C-w>\><CR>

" ************************* Neovim terminal mappings **************************

" Open neovim terminal
:nnoremap <leader>t :terminal<CR>A
" Map <Esc> to quitting the terminal
:tnoremap <Esc> <C-\><C-n>

" ********************************* Commands **********************************

" git diff
":command GD !clear;git diff
" Edit vim settings
:command! EVIM e ~/.vimrc
" Edit vim settings
:command! ECFG e ~/.bashrc
:command! ENVIM e ~/.config/nvim/init.vim
if has('win32')
    :command! ENVIM :exe "e C:/Users/" . expand('$USERNAME') . "/AppData/Local/nvim/init.vim"
endif
" Source vim settings
:command! RVIM source ~/.config/nvim/init.vim
if has('win32')
    :command! RVIM :exe "source C:/Users/" . expand('$USERNAME') . "/AppData/Local/nvim/init.vim"
endif

:command! ENLUA e ~/.config/nvim/lua/config.lua

" Ag (silver searcher) but only search files
" https://github.com/junegunn/fzf.vim/issues/346#issuecomment-288483704
command! -bang -nargs=* Au call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

" Edit oni configuration
if has('win32')
    :command! OpenOniConfig :exe "e C:/Users/" . expand('$USERNAME') . "/AppData/Roaming/Oni/config.tsx"
else
    :command! OpenOniConfig e ~/.config/oni/config.tsx
endif

" Cover short tests pytorch
:command! PyCS !pytest --cov=. --cov-report term-missing:skip-covered -m 'not long'
" Cover all pytest
:command! PytestCoverAll !pytest --cov=. --cov-report term-missing
" Recreate python ctags
:command! PythonCTags !ctags -R --languages=python -f ./tags .

" Replace to end of doc
:command! ReplaceFromQuotes exe 'norm! 0"kyi""lyi''}:.,$s/\C<c-r>k/<c-r>l/g<cr><c-o>'
:command! SwapQuotes exe 'norm! 0di"f''vi''p0p'

" Search current directory for text
:set wildignore+=objd/**,obj/**,*.tmp,test.c,**/node_modules/**
:command! -nargs=1 CSearch noautocmd vimgrep "<args>" ./**/*.py ./**/*.txt ./**/*.html ./**/*.ts

" Navigating buffers
:nnoremap <tab> :bnext<cr>
:nnoremap <S-tab> :bprevious<cr>

:nnoremap <leader>+ :vertical resize +10<CR>
:nnoremap <leader>- :vertical resize -10<CR>

:nnoremap <leader>qa :bd!<CR> :qa
:nnoremap <leader>w :w<CR> :bd<CR>
" close buffer, while maintaining split
" https://stackoverflow.com/questions/4465095/vim-delete-buffer-without-losing-the-split-window
:nnoremap <leader>bd :bn\|bd #<CR>
:nnoremap <leader>!bd :bn\|bd! #<CR>

" Copy line to OS clipboard
:command! CLine execute "normal! \"*yy"
:command! PLine execute "normal! \"*p"

:command! Less :!lessc ./css/style.less ./style.css

" Can also add --sort-keys arg
:command! JsonFormat :set syntax=json | %!python -m json.tool
" I don't love this vimscript, but it did the job I needed this time
"%delete | 0put =json_encode(json_decode(@@))
:command! XmlFormat :%!python -c "import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml(newl='',indent=''))"
:nnoremap =j :JsonFormat<cr>

:command! EightyOn set colorcolumn=80
:command! OneTwentyOn set colorcolumn=120
:command! ColourColumnOff set colorcolumn=

" ******************************** Functions **********************************

function! LogFile()

 syn match fatal ".* FATAL .*"
 syn match fatal "^FATAL: .*"
 syn match error ".* ERROR .*"
 syn match error "^ERROR: .*"
 syn match error "\[ERROR\] .*"
 syn match warn ".* WARN .*"
 syn match warn "\[WARN\] .*"
 syn match warn "^WARN: .*"
 syn match info ".* INFO .*"
 syn match info "\c\[INFO\(RMATION\)\?\]"
 syn match info "^INFO: .*"
 syn match debug ".* DEBUG .*"
 syn match debug "\c^DEBUG: .*"
 syn match debug "\c\[DEBUG\]"
 syn match error "^java.*Exception.*"
 syn match error "^java.*Error.*"
 syn match error "^\tat .*"

 " nextgroup and skipwhite makes vim look for logTime after the match
 syn match logDate /^\d\{4}-\d\{2}-\d\{2}/ nextgroup=logTime skipwhite

 " This creates a match on the time (but only if it follows the date)
 syn match logTime /\d\{2}:\d\{2}:\d\{2}.\d\{3}/ nextgroup=logTimeOffset skipwhite
 syn match logTimeOffset /[+-]\d\{2}:\d\{2}/

 " Highlight colors for log levels.
 hi fatal ctermfg=Red ctermbg=Black
 hi error ctermfg=Red ctermbg=Black
 hi warn ctermfg=Yellow ctermbg=Black
 hi info ctermfg=lightblue
 hi debug ctermfg=darkblue

 " Def means default colour - colourschemes can override
 hi def logDate ctermfg=green
 hi def logTime ctermfg=green
 hi def logTimeOffset ctermfg=green

 let b:current_syntax = "log"

endfunction

function! ShortenCsprojVersion()
  :exe "norm j_ditk$i Version=\"\<esc>pEDA\" />\<esc>jdd._"
endfunction

function! MinifyMarkdownTable()
  :'<,'>s/  \+/ /g
endfunction

function! MarkdownToCss()
  :call MinifyMarkdownTable()
  :'<,'>s/\( |\)\+$//g
  :'<,'>s/^| //g
  :'<,'>s/ | | /,,/g
  :'<,'>s/ | /,/g
endfunction

function! CssToMarkdown()
  :'<,'>s/,/ | /g
  :'<,'>s/^\(.\)/| \1/g
  :'<,'>s/\(.\)$/\1 |/g
endfunction

" ************************* Python specific settings **************************

" F1 to auto format file
autocmd FileType python nnoremap <F1> :w<CR>:!autopep8 -i --aggressive --aggressive %<CR>
" autocmd FileType python nnoremap <leader>e :w<CR>:!autopep8 -i %<CR>
autocmd FileType python nnoremap <leader>e :w<CR>:!black %<CR>
" F4 to run current file
autocmd FileType python nnoremap <F4> :w<CR>:vsp term://python3 %<CR>i
" F5 to run current dir
autocmd FileType python nnoremap <F5> :w<CR>:vsp term://python3 __main__.py<CR>i
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

" K to vimgrep
autocmd FileType python nnoremap K :vimgrep ' **/*.py<S-Left><S-Left>'

" Ctrl + / to comment
autocmd FileType python nnoremap <C-_> 0i# <Esc>j
" + to uncomment
autocmd FileType python nnoremap + 02xj

" ************************** Rust specific settings ***************************

" F5 to run current file
autocmd FileType rust nnoremap <F5> :w<CR>:vsp term://cargo run %<CR>

" ************************** Bash specific settings ***************************

autocmd Filetype sh nnoremap <c-_> 0i# <Esc>j

" *********************** Typescript specific settings ************************

autocmd Filetype typescript,typescriptreact nnoremap <F3> :!tslint --fix %<cr>
autocmd Filetype typescript,typescriptreact nnoremap <F5> :!tsc --experimentalDecorators --target ES5 %<CR>:vsp term://node %:r.js<CR>i
autocmd Filetype typescript,typescriptreact nnoremap <F6> :vsp term://npm run test<CR>i
autocmd Filetype typescript,typescriptreact nnoremap <F12> :TSDef<CR>

" autocmd Filetype typescript,typescriptreact nnoremap <leader>gd :TSDef<CR>
autocmd Filetype typescript,typescriptreact nnoremap <leader>gi :TSDoc<CR>
autocmd Filetype typescript,typescriptreact nnoremap <leader>gf :TSGetCodeFix<CR>

" Macro for prettier
autocmd Filetype typescript,typescriptreact nnoremap <leader>e <Plug>(Prettier)

" ************************* csharp specific settings **************************

autocmd Filetype cs let b:match_words = '\s*#\s*region.*$:\s*#\s*endregion'

" https://github.com/OmniSharp/Omnisharp-vim#configuration
autocmd FileType cs nmap <silent> <buffer> od <Plug>(omnisharp_go_to_definition)
autocmd FileType cs nmap <silent> <buffer> <leader>osfu <Plug>(omnisharp_find_usages)
autocmd FileType cs nmap <silent> <buffer> <leader>osfi <Plug>(omnisharp_find_implementations)
autocmd FileType cs nmap <silent> <buffer> <leader>ospd <Plug>(omnisharp_preview_definition)
autocmd FileType cs nmap <silent> <buffer> <leader>ospi <Plug>(omnisharp_preview_implementations)
autocmd FileType cs nmap <silent> <buffer> <leader>ost <Plug>(omnisharp_type_lookup)
autocmd FileType cs nmap <silent> <buffer> <leader>osd <Plug>(omnisharp_documentation)
autocmd FileType cs nmap <silent> <buffer> <leader>osfs <Plug>(omnisharp_find_symbol)
autocmd FileType cs nmap <silent> <buffer> <leader>osfx <Plug>(omnisharp_fix_usings)
autocmd FileType cs nmap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)
autocmd FileType cs imap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)

" Navigate up and down by method/property/field
" autocmd FileType cs nmap <silent> <buffer> [[ <Plug>(omnisharp_navigate_up)
" autocmd FileType cs nmap <silent> <buffer> ]] <Plug>(omnisharp_navigate_down)
" Find all code errors/warnings for the current solution and populate the quickfix window
autocmd FileType cs nmap <silent> <buffer> <leader>osgcc <Plug>(omnisharp_global_code_check)

autocmd FileType cs nmap <silent> <buffer> <leader>os= <Plug>(omnisharp_code_format)

autocmd FileType cs setlocal tabstop=4
autocmd FileType cs setlocal shiftwidth=4

" ************************** xaml specific settings ***************************

autocmd Filetype xaml let b:match_words = '\s*<!--\s*#\s*region.*$:\s*<!--\s*#\s*endregion'

" ******************************** Lua config *********************************

lua require('config')

" ******************************* LSP mappings ********************************

nnoremap <leader>od :lua vim.lsp.buf.definition()<cr>
nnoremap <leader>ot :lua vim.lsp.buf.type_definition()<cr>
nnoremap <leader>of :lua vim.lsp.buf.references()<cr>
nnoremap <leader>orr :lua vim.lsp.buf.rename()<cr>
nnoremap ]] :lua vim.diagnostic.goto_next()<cr>
nnoremap [[ :lua vim.diagnostic.goto_prev()<cr>

