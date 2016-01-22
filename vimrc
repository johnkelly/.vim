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

Bundle 'gmarik/vundle'

Bundle 'altercation/vim-colors-solarized'
Bundle 'dockyard/vim-easydir'
Bundle 'kien/ctrlp.vim'
Bundle 'rking/ag.vim'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'vim-scripts/matchit.zip'
Bundle 'tpope/vim-commentary'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"GIT
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'tpope/vim-fugitive'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Ruby
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'tpope/vim-bundler'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-rvm'
Bundle 'vim-ruby/vim-ruby'
Bundle 'ngmy/vim-rubocop'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"JS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'shutnik/jshint2.vim'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Clojure
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'tpope/vim-fireplace'
Bundle 'eapache/rainbow_parentheses.vim'
Bundle 'gregspurrier/vim-midje'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Golang 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'fatih/vim-go'

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
set showmode                      " Display the mode you're in (INSERT, VISUAL).
set softtabstop=2                 " Number of spaces that a <Tab> counts for while performing editing operations
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P
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

map <leader>ac :CtrlP app/controllers<cr>
map <leader>ai :CtrlP app/interactors<cr>
map <leader>am :CtrlP app/models<cr>
map <leader>as :CtrlP app/serializers<cr>
map <leader>aw :CtrlP app/workers<cr>
map <leader>av :CtrlP app/views<cr>
map <leader>tc :CtrlP spec/controllers<cr>
map <leader>ti :CtrlP spec/interactors<cr>
map <leader>tm :CtrlP spec/models<cr>
map <leader>ts :CtrlP spec/serializers<cr>
map <leader>tw :CtrlP spec/workers<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"RuboCop
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vimrubocop_keymap = 0
let g:vimrubocop_extra_args = '-R --require rubocop-rspec -a'
nmap <Leader>ru :RuboCop<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"JSHint
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let jshint2_save = 0
nmap <Leader>js :JSHint<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Clojure Rainbow Parens
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:rbpt_colorpairs = [
      \ ['brown',       'RoyalBlue3'],
      \ ['Darkblue',    'SeaGreen3'],
      \ ['darkgray',    'DarkOrchid3'],
      \ ['darkgreen',   'firebrick3'],
      \ ['darkcyan',    'RoyalBlue3'],
      \ ['darkred',     'SeaGreen3'],
      \ ['darkmagenta', 'DarkOrchid3'],
      \ ['brown',       'firebrick3'],
      \ ['gray',        'RoyalBlue3'],
      \ ['black',       'SeaGreen3'],
      \ ['darkmagenta', 'DarkOrchid3'],
      \ ['Darkblue',    'firebrick3'],
      \ ['darkgreen',   'RoyalBlue3'],
      \ ['darkcyan',    'SeaGreen3'],
      \ ['darkred',     'DarkOrchid3'],
      \ ['red',         'firebrick3'],
      \ ]
let g:rbpt_max = 15
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Vim GO
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <Leader>gd :GoDef<CR>
nmap <Leader>gp :GoPath<CR>
nmap <Leader>gl :GoMetaLinter<CR>
nmap <Leader>gv :GoVet<CR>
nmap <Leader>ge :GoErrCheck<CR>
nmap <Leader>gp :GoPlay<CR>
nmap <Leader>gt :GoTest<CR>

let g:go_fmt_command = "goimports"
