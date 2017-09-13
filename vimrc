""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Install
"git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Vundle
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Plugin 'gmarik/vundle'

Plugin 'altercation/vim-colors-solarized'
Plugin 'dockyard/vim-easydir'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'rking/ag.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'vim-scripts/matchit.zip'
Plugin 'tpope/vim-commentary'
Plugin 'janko-m/vim-test'
Plugin 'vim-airline/vim-airline'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"GIT
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Ruby
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-rvm'
Plugin 'vim-ruby/vim-ruby'
Plugin 'ngmy/vim-rubocop'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Golang
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'fatih/vim-go'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Elixir
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'elixir-lang/vim-elixir'
Plugin 'slashmili/alchemist.vim'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"General Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on

syntax enable on                  " Turn on syntax highlighting.

set autoindent                    " Copy indent from current line when starting a new line
set background=dark
set backspace=indent,eol,start    " Allow backspacing over autoindent, line breaks, & start of insert
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set encoding=utf-8
set expandtab                     " Use spaces instead of tabs
set hidden                        " Buffer becomes hidden when it is |abandon|ed
set hlsearch                      " Highlight matches.
set ignorecase                    " Case-insensitive searching.
set incsearch                     " Highlight matches as you type.
set laststatus=2                  " Always show the status line on the last window
set number                        " Show line numbers.
set ruler                         " Show cursor position.
set scrolloff=3                   " Display 3 lines of context around the cursor.
set shell=bash                    " This makes RVM work inside Vim. I have no idea why
set shiftwidth=2                  " Number of spaces to use for each step of (auto)indent <<, >>
set smartcase                     " Case-sensitive if search expression contains a capital letter.
set showcmd                       " Display inprogress commands.
set smartindent                   " Do smart autoindenting when starting a new line
set shortmess+=A                  " Prevent annoying 'swap file already exists -> delete' prompt
set showmode                      " Display the mode you're in (INSERT, VISUAL).
set softtabstop=2                 " Number of spaces that a <Tab> counts for while performing editing operations
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P
set statusline+=%{fugitive#statusline()} "  Git Hotness
set tabstop=2                     " Global tab width.
set title                         " Display the terminal's title
set visualbell                    " No beeping.
set wildmenu                      " Autocomplete for vim commands
set wildmode=list:longest         " When more than one match, list all matches & complete till longest string
set wrap                          " Turn on line wrapping.

let mapleader = ","

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Silver searcher
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>ag :Ag 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Highlight trailing whitespace in red
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set listchars=tab:»·,trail:·
" set listchars=trail:·
" set list
" hi SpecialKey ctermbg=red ctermfg=red guibg=red guifg=red

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Switch between two files
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader><leader> <c-^>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Clear the search buffer when hitting return
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! MapCR()
  nnoremap <cr> :nohlsearch<cr>
endfunction
call MapCR()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OPEN FILES IN DIRECTORY OF CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CUSTOM AUTOCMDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!
  autocmd FileType text setlocal textwidth=78
  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Leave the return key alone when in command line windows, since it's used
  " to run commands there.
"  autocmd! CmdwinEnter * :unmap <cr>
"  autocmd! CmdwinLeave * :call MapCR()
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"MAPS TO JUMP TO SPECIFIC CTRL-P TARGETS AND FILES
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_map = '<leader>t'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = {
      \ 'dir': '\v[\/]\.(dep)$',
      \ }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"RuboCop
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vimrubocop_keymap = 0
let g:vimrubocop_extra_args = '-R --require rubocop-rspec -a'
nmap <Leader>ru :RuboCop<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Vim Go
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <Leader>gd :GoDef<CR>
nmap <Leader>gp :GoPath<CR>
nmap <Leader>gl :GoMetaLinter<CR>
nmap <Leader>gv :GoVet<CR>
nmap <Leader>ge :GoErrCheck<CR>
nmap <Leader>gp :GoPlay<CR>
nmap <Leader>gt :GoTest<CR>

let g:go_fmt_command = "goimports"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Vim Test
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <silent> <leader>TN :TestNearest<CR>
nmap <silent> <leader>TF :TestFile<CR>
nmap <silent> <leader>TS :TestSuite<CR>
nmap <silent> <leader>TL :TestLast<CR>
nmap <silent> <leader>TV :TestVisit<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Vim GitGutter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set updatetime=250

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Vim Alchemist
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:alchemist#elixir_erlang_src = "/usr/local/share/src"
