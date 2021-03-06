"=========================================================="
" Bundles
"=========================================================="

call plug#begin('~/.vim/plugged')

Plug 'benekastah/neomake', { 'on': 'Neomake' }
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'chrisbra/NrrwRgn'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'elixir-lang/vim-elixir', { 'for': 'elixir' }
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'godlygeek/tabular'
Plug 'guns/vim-sexp'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/goyo.vim'
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
Plug 'ElmCast/elm-vim', { 'for': 'elm' }
Plug 'majutsushi/tagbar'
Plug 'mhinz/vim-grepper', { 'on': 'Grepper' }
Plug 'mhinz/vim-startify'
Plug 'moll/vim-bbye', { 'on': 'Bdelete' }
Plug 'moll/vim-node', { 'for': 'javascript' }
Plug 'mustache/vim-mode'
Plug 'ntpeters/vim-better-whitespace'
Plug 'Olical/vim-enmasse', { 'on': 'EnMasse' }
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'paradigm/TextObjectify'
Plug 'racer-rust/vim-racer', { 'for': 'rust' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'samuelsimoes/vim-jsx-utils', { 'for' : 'javascript.jsx' }
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'sk1418/last256'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-leiningen'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-scripts/EasyGrep'
Plug 'w0rp/ale'

call plug#end()


"=========================================================="
" Colorscheme/highlights
"=========================================================="
"
"
set background=dark
colorscheme last256

"" Startify
"
hi! StartifyBracket ctermfg=8
hi! StartifyFile    ctermfg=15
hi! StartifyNumber  ctermfg=15
hi! StartifyPath    ctermfg=8
hi! StartifySlash   ctermfg=7
hi! StartifySpecial ctermfg=8
hi! StartifyHeader  ctermfg=124

"" Search
hi! Search ctermfg=0 ctermbg=4

"" TODO
hi! Todo ctermbg=none ctermfg=11

hi! Subdued ctermfg=240

"" NERDTree
hi! link NERDTreeUp Subdued
hi! link NERDTreeDir Subdued
hi! link NERDTreeDirSlash Subdued

" Columns 'n' lines
hi ColorColumn ctermbg=0
hi CursorLine cterm=none ctermbg=0
hi VertSplit cterm=none ctermbg=8 ctermfg=8


hi WhiteOnBlue ctermfg=254 ctermbg=25 cterm=none
hi PurpleOnBlack ctermfg=235 ctermbg=141 cterm=none

hi! link Visual WhiteOnBlue

hi! link Search PurpleOnBlack
hi! link IncSearch Search

"=========================================================="
" Misc. Settings
"=========================================================="

" Use spacebar as leader.
let mapleader = " "
let g:mapleader = " "
let g:maplocalleader = " "

" Prevent Vim from clobbering the scrollback buffer.
" http://www.shallowsky.com/linux/noaltscreen.html
" via Gary Bernhardt
set t_ti= t_te=

if has('gui_running')
  " Set font in GUI.
  set guifont=Fira\ Mono:h12
endif

" Backup files, swapfiles, and undo files.
set backupdir=~/.vim/backup
set directory=~/.vim/backup
set undodir=~/.vim/undo

" Stop littering .swp files everywhere.
set noswapfile
" Stores undo info in a file so that it persists after vim closes.
set undofile

" Show listchars.
set listchars=nbsp:¬,tab:>-,extends:»,precedes:«,trail:·
set list

set iskeyword+=-

set conceallevel=2
set concealcursor=nc

set noshowmode


"=========================================================="
" Autocommands
"=========================================================="

augroup FileTypes
  autocmd!

" This makes editing crontab possible.
  " autocmd BufNewFile,BufRead crontab.* set nobackup | set nowritebackup

  autocmd CmdwinEnter * nnoremap <buffer> <cr> <cr>
  autocmd FileType qf nnoremap <buffer> <cr> <cr>

  " No ColorColumn in Startify.
  autocmd FileType startify setlocal colorcolumn=""

  autocmd BufNewFile,BufRead *.mustache setl ft=mustache
  autocmd FileType mustache setlocal syntax=html

  autocmd BufNewFile,BufRead *.md setl ft=markdown

  autocmd BufNewFile,BufRead CMakeLists.txt set ft=cmake

  autocmd FileType rust nnoremap <f4> :vsp \| te cargo run<cr>

  autocmd FileType elm setl shiftwidth=4
augroup END


augroup Markdown
  autocmd!

  " Treat all text files as markdown.
  autocmd BufNewFile,BufRead *.{txt,text} set filetype=markdown

  " Wrap text for txt/markdown.
  autocmd FileType markdown set wrap linebreak textwidth=0
  autocmd FileType txt set wrap linebreak textwidth=0

  " Don't showbreak for txt/markdown.
  autocmd FileType markdown set showbreak=
  autocmd FileType txt set showbreak=

  " Convert Markdown to HTML (in place!).
  autocmd FileType markdown command! Html %! /usr/local/bin/markdown --html4tags <cr>
augroup END


"=========================================================="
" Functions
"=========================================================="

function! Standard()
  set makeprg=./node_modules/.bin/standard
  autocmd! BufWritePost * Neomake!
  Neomake!
endfunction

function! Rubocop()
  set makeprg=./bin/rubocop
  autocmd! BufWritePost * NeomakeFile
endfunction

function! Pep8()
  set makeprg=pep8\ ./**/*.py
  autocmd! BufWritePost * Neomake!
endfunction

function! CopyMatches(reg)
  let hits = []
  %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/ge
  let reg = empty(a:reg) ? '+' : a:reg
  execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction
command! -register CopyMatches call CopyMatches(<q-reg>)


"=========================================================="
" Mappings
"=========================================================="

" Tab navigation.
nnoremap <silent> <c-n> :tabnext<cr>
nnoremap <silent> <c-p> :tabprev<cr>

" Switch between the last two files.
nnoremap <leader><leader> <c-^>

" Copy and paste from system clipboard.
noremap <leader>p "+p
noremap <leader>y "+y
noremap <leader>P "+P
noremap <leader>Y "+Y

" Write as root, when you forgot to sudo edit.
cnoreabbrev w!! w !sudo tee % >/dev/null

" Map <leader>f to open CtrlP in buffer mode.
nnoremap <silent> <leader>f :CtrlPBuffer<cr>

" Previous.
nnoremap <silent> <f7> :prev<cr>
" Next.
nnoremap <silent> <f9> :next<cr>

" Grepper
nnoremap <leader>a :Grepper<cr>
nnoremap <leader>w :Grepper -cword -noprompt<cr>

" Copy and paste from system clipboard.
noremap <leader>p "+p
noremap <leader>y "+y

" Switch to last buffer.
nnoremap <leader><leader> <c-^>

" Close a buffer without closing the window.
nnoremap <silent> <leader>d :Bdelete<cr>

" Commentary.
xmap <leader>c <Plug>Commentary
nmap <leader>c <Plug>Commentary
nmap <leader>c<space> <Plug>CommentaryLine
nmap <leader>cu <Plug>CommentaryUndo

" Toggle NERDTree.
nnoremap <leader>tr :NERDTreeToggle<cr>

nnoremap <leader>rw :StripWhitespace<cr>

if has('nvim')
  " Escape!
  tnoremap <leader><esc> <c-\><c-n>

  nnoremap <leader>irb :vsplit term://irb<cr>i
endif


"=========================================================="
" Commands
"=========================================================="

command! Standard call Standard()


"=========================================================="
" Plugins Settings
"=========================================================="

"" CtrlP
"
" Open with <c-f>.
let g:ctrlp_map = '<c-f>'

" Increase file limit from 10,000 to 100,000.
let g:ctrlp_max_files = 100000

" Don't remember the last input.
let g:ctrlp_persistent_input = 0

" Don't change working directory.
let g:ctrlp_working_path_mode = 0

let g:ctrlp_custom_ignore = {
            \ 'dir': '\v[\/]\.sass-cache'
            \ }

" Prevent opening a split beside the Startify buffer.
let g:ctrlp_reuse_window = 'startify'

"" Netrw
"
let g:netrw_liststyle=3
let g:netrw_browse_split=3
let g:netrw_preview=1
let g:netrw_winsize=20

"" Startify
"
let g:startify_bookmarks = [
  \ '~/.vimrc',
  \ '~/.vimrc.local',
  \ '~/.bashrc',
  \ '/usr/local/etc/nginx/nginx.conf'
\]
let g:startify_skiplist = [
  \ 'COMMIT_EDITMSG',
  \ '^/usr/local/Cellar/vim',
  \ '^/usr/local/Cellar/macvim'
\]
let g:startify_list_order = ['files', 'bookmarks', 'sessions']
let g:startify_files_number = 10
let g:startify_change_to_dir = 0
let g:startify_relative_path = 1
let g:startify_custom_header = [
 \ '',
 \ ' _____',
 \ '  \ 1 \__      _____',
 \ '   \ 5 \/_______\___\_____________',
 \ '   < /0/   .....................  `-.',
 \ '    `-----------,----,--------------´',
 \ '               _/____/'
\]
" Let NERDTree use the Startify buffer
autocmd User Startified setlocal buftype=


"" JSX
let g:jsx_ext_required = 0

"" Elm-vim
let g:elm_format_autosave = 1
let g:elm_setup_keybindings = 0

"" HACK to keep vim-javascript from complaining for now
if !exists("b:undo_ftplugin") | let b:undo_ftplugin = '' | endif

let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'relativepath', 'modified' ] ]
      \ }
      \ }


"" ALE
let g:ale_fixers = {
      \'javascript': ['prettier'],
\}

let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
"" end ALE

set shortmess=a

set t_Co=256

set tabstop=2
set shiftwidth=2
set autoindent
set smartindent
set expandtab

set nu

set nocompatible
filetype off

filetype plugin on
set viminfo='100,n$HOME/.vim/files/info/viminfo
set statusline +=%{ALEGetStatusLine()}
