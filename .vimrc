" FIRST, install pathogen via
" mkdir -p ~/.vim/autoload ~/.vim/bundle
" curl 'www.vim.org/scripts/download_script.php?src_id=16224' > ~/.vim/autoload/pathogen.vim

" 'Solarized' Color Scheme installed via
" git clone https://github.com/altercation/vim-colors-solarized.git ~/.vim/bundle/solarized
" 
" NOTE
" Must also install solarized theme for Lion Terminal.app (or other terminal)
" for this to look right at all when running vim from a terminal
" https://github.com/tomislav/osx-lion-terminal.app-colors-solarized
"
" Other Solarized profiles can be found at
" http://ethanschoonover.com/solarized

" Markdown support installed via
" git clone https://github.com/hallison/vim-markdown.git ~/.vim/bundle/markdown

" CtrlP fuzzy file finder extension installed via
" git clone https://github.com/kien/ctrlp.vim.git ~/.vim/bundle/ctrlp

" vim-commentary
" git clone git://github.com/tpope/vim-commentary.git ~/.vim/bundle/vim-commentary

" Define :Bclose to close a buffer without closing a window using
" the first script on
" http://vim.wikia.com/wiki/Deleting_a_buffer_without_closing_the_window
" and placing it in
" ~/.vim/bundle/bclose/plugin/bclose.vim

" Repeat plugin to repeat plugin actions via
" git clone https://github.com/tpope/vim-repeat.git ~/.vim/bundle/repeat

" Surround plugin to add 'surrounding' as a vim context ('s') via
" git clone https://github.com/tpope/vim-surround.vim !/.vim/bundle/surround

" Syntastic syntax checker installed via
" git clone https://github.com/scrooloose/syntastic.git ~/.vim/bundle/syntastic

" Indent Guides installed via
" git clone https://github.com/nathanaelkane/vim-indent-guides.git ~/.vim/bundle/vim-indent-guides

" Need to create directory for undo files
" mkdir -p ~/.vim/undo


" CUSTOM CONFIGURATION

" Use zsh
set shell=zsh

" Disable silly vi-compatibility
set nocompatible

" Turn off the MacVim toolbar
if has("gui_running")
    set guioptions=-t
endif

" Enable filetype plugins
filetype plugin indent on

" Pathogen Bundle Manager
call pathogen#infect()

" Make all text files markdown
autocmd BufNewFile,BufRead *.{txt,text} set filetype=markdown

" Enable todo.txt filetype detection
autocmd BufNewFile,BufRead todo.txt set syntax=todo foldmethod=indent

" Function to activate degraded colors for 256 color terminals without
" solarized scheme
function! FixColors()
    if g:solarized_termcolors == 256
        let g:solarized_termcolors = 16
    else
        let g:solarized_termcolors = 256
    endif
    colorscheme solarized
    set background=dark
endfunction
command! FixColors call FixColors()

" Colors, solarized theme.  See above for note.
syntax enable
set background=dark
colorscheme solarized


" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
" via Gary Bernhardt
" set t_ti= t_te=

" Kill some security exploits and also modelines are a dumb idea
set modelines=0


" Switches between 2 and four space indents
set expandtab
function! s:IndentTwo(...)
  set tabstop=2
  set shiftwidth=2
  set softtabstop=2
endfunction
command! IndentTwo call <SID>IndentTwo()
function! s:IndentFour(...)
  set tabstop=4
  set shiftwidth=4
  set softtabstop=4
endfunction
command! IndentFour call <SID>IndentFour()
set tabstop=2
set shiftwidth=2
set softtabstop=2

" Keep a really long command/search history
set history=1000

" Don't write any backup or swap files ever.
" They're more annoying than they are safe.
set noswapfile
set nowritebackup
set nobackup

" Allow open buffers that are not visible
set hidden

" All other encodings are bad
set encoding=utf-8

" Force showing three extra lines above and below cursor (so you're never
" typing on the last line of the window)
set scrolloff=3

" Turn on auto-indentation, for better or worse
set autoindent

" Do not beep.
set visualbell

" Highlight the line the cursor is in
set cursorline

" Enable mouse support in terminals that can handle it (iTerm can,
" Terminal.app can't)
set mouse=a

" Make backspace also delete indents d line endings
set backspace=indent,eol,start

" Always show the status line above the command line
set laststatus=2

" Show the cursor position at the end of the status line
set ruler

" Show tidbits of info in bottom right about current keyboard command
set showcmd

" Make tab completion a lot smarter (this mostly makes it work like zsh)
set wildmenu
set wildmode=longest,list

" Stores undo info in a file so that it persists after vim closes
" Need to have ~/.vim/undo created
set undofile
set undodir=~/.vim/undo

" Turn off vim-mode regexes because nobody knows how they work
nnoremap / /\v
vnoremap / /\v

" Searches should be case insensitive unless there is a capital letter
set ignorecase
set smartcase

" Adds the /g option to replace all occurences by default instead
" of just the first.  Using /g turns this off.
set gdefault

" Make searches perform/highlight automatically while you type
set incsearch
set showmatch
set hlsearch

" Display a colored column at 81 characters
" (This means text appearing on top of the line is BAD)
set colorcolumn=81

" Don't wrap text, but add characters indicating hidden parts of a line
" and change horizontal scrolling to be sane
set nowrap
set sidescroll=1
set sidescrolloff=1
set listchars=extends:>,precedes:<

" But wrap text for txt/markdown
autocmd FileType markdown set wrap linebreak textwidth=0
autocmd FileType txt set wrap linebreak textwidth=0

" If wrapping is enabled, mark wrapped lines
set showbreak=\ ->\ 

" But not for txt/markdown
autocmd FileType markdown set showbreak=
autocmd FileType txt set showbreak=

" Set indent guide colors to sane values for solarized
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=8 guibg=#002b36
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=0 guibg=#073642

" Increase ctrlp file limit from 10,000 to 100,000
let g:ctrlp_max_files = 100000

" CtrlP should ignore dot files
let g:ctrlp_dotfiles = 0

" CtrlP shouldn't remember the last input
let g:ctrlp_persistent_input = 0

" Don't let ctrlp change working directory
let g:ctrlp_working_path_mode = 0

" CtrlP should ignore some files
"
" This is kind of a mess. Better solution?
let g:ctrlp_custom_ignore = {
    \ 'dir': '\v[\/](build-app|build-web|release-app|release-web|build-phonegap|release-phonegap|node_modules|vendor|app\/cache)$',
    \ }

" Enable syntastic error signs in the line number column
let g:syntastic_enable_signs = 1


" Shrink inactive splits to 10 rows and 20 cols
set winwidth=20
set winminwidth=20
set winwidth=120
set winheight=10
set winminheight=10
set winheight=999

" Improve completion menu

" CUSTOM KEY BINDINGS

" Change the leader key to comma
let mapleader = ","

" Open a file in the same directory as the current file
" (Stolen from Gary Bernhardt)
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%

" Use leader-s to automatically enter search-and-replace when in visual
vnoremap <leader>s :s/\v

" Clear highlighted search
nnoremap <enter> :noh<cr>

" Force use of hjkl instead of arrows to break bad habits
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Shortcuts for creating splits
nnoremap <leader>v <C-w>v<C-w>l<C-w>L
nnoremap <leader>h <C-w>s<C-w>j

" Easier split navigation
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" Shortcut to close a buffer without closing the window
nnoremap <silent> <leader>d :Bclose<cr> 

" Set CtrlP map to ctrl-f because it's easier to hit
let g:ctrlp_map = '<c-f>'

" Map <leader>f to open CtrlP in buffer mode
nnoremap <silent> <leader>f :CtrlPBuffer<cr>

" Map <leader><leader> to switch to last buffer
nnoremap <leader><leader> <c-^>

" Add a blank line below in normal mode, stay in normal mode
nnoremap <c-o> o<esc>

" Make scroll up/down scroll faster
noremap <c-e> 5<c-e>
noremap <c-y> 5<c-y>

" Turn on and off textwrap
nnoremap <leader>w :set nowrap!<cr>

" Map ,t to tidy up files based on file type
autocmd BufNewFile,BufRead *.{json} nnoremap <leader>y :%!python -mjson.tool<cr>

" Rename Current File
" (Stolen from Gary Bernhardt)
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>


" Use Tab for indent if on a blank/whitespace line,
" or completion if there is text entered
" (Stolen from Gary Benhardt)
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

" Files should open with cursor at same line as when closed
" From vim docs, via Gary Bernhardt
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif




" I don't use anything below here anymore.
" Rethink?



" Switch between spec and src
" Modified from Gary Bernhardt
function! OpenTestAlternate()
    let new_file = AlternateForCurrentFile()
    exec ':e ' . new_file
endfunction

function! AlternateForCurrentFile()
    let current_file = expand("%")
    let new_file = current_file
    let in_spec = match(current_file, '/specs/') != -1
    let going_to_spec = !in_spec
    let in_js = match(current_file, 'javascripts') != -1
    if going_to_spec
        if in_js
            let new_file = substitute(new_file, '/src/', '/specs/', '')
        endif
    else
        if in_js
            let new_file = substitute(new_file, '/specs/', '/src/', '')
        endif
    endif
    return new_file
endfunction
nnoremap <leader>. :call OpenTestAlternate()<cr>


" Run Tests
" Modified from Gary Bernhardt
map <leader>t :call RunTestFile()<cr>
map <leader>a :call RunTests('')<cr>

function! SetTestFile()
    let current_file = expand("%")
    let t:dpm_test_binary="bin/behat"
    let in_js = match(current_file, 'js') != -1
    if in_js
        let current_file = substitute(current_file, '^.*spec/', '', '')
        let current_file = substitute(current_file, '\.js$', '', '')
        let t:dpm_test_binary="bin/jasmine"
    endif
    if match(current_file, 'php') != -1
        let t:dpm_test_binary="bin/phpunit -c app/ --color"
    endif
    let t:dpm_test_file=current_file
endfunction

function! RunTestFile(...)
    if a:0
        let command_suffix = a:1
    else
        let command_suffix = ""
    end

    let in_test_file = match(expand("%"), '/spec/') != -1
    if (!in_test_file)
        let in_test_file = match(expand("%"), 'Feature') != -1
    end
    if (in_test_file)
        let in_test_file = match(expand("%"), 'Context') == -1
    end
    if (!in_test_file)
        let in_test_file = match(expand("%"), 'Test') != -1
    end
    if in_test_file
        call SetTestFile()
    elseif !exists("t:dpm_test_file")
        return
    end
    call RunTests(t:dpm_test_file . command_suffix)
endfunction

function! RunTests(filename)
    :w
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo;echo;echo;
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo;echo;echo;
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo;echo;echo;
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo;echo;echo;
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo;echo;echo;
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo;echo;echo;
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo;echo;echo;
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo;echo;echo;
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo;echo;echo;

    exec ":!" . t:dpm_test_binary . " " . a:filename
endfunction

function! BuildAndRunXcode()
    exec ":!xcodebuild -target \"Digideck\" -configuration Debug -project \"Digideck.xcodeproj\" -sdk iphonesimulator6.1 && ios-sim launch \"build/Debug-iphonesimulator/Digideck.app\" --family ipad"
endfunction

map <leader>b :call BuildAndRunXcode()<cr>