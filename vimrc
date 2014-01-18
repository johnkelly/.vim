""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Install
"git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
"
"Command T Install
"cd Command-T/ruby/command-t/
"/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/bin/ruby extconf.rb
"make
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Vundle
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'wincent/Command-T.git'
Bundle 'altercation/vim-colors-solarized'
Bundle 'vim-ruby/vim-ruby'
Bundle 'kchmck/vim-coffee-script'
Bundle 'rking/ag.vim'
Bundle 'skalnik/vim-vroom'
Bundle 'tsaleh/vim-matchit'
Bundle 'tpope/vim-bundler'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-rvm'

filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"General Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable on                  " Turn on syntax highlighting.
colorscheme solarized

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

"Tab mappings
map <leader>tt :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>to :tabonly<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprevious<cr>
map <leader>tf :tabfirst<cr>
map <leader>tl :tablast<cr>
map <leader>tm :tabmove
map <leader>ag :Ag 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Highlight trailing whitespace in red
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set listchars=tab:»·,trail:·
set list
hi SpecialKey ctermbg=red ctermfg=red guibg=red guifg=red

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
"MAPS TO JUMP TO SPECIFIC COMMAND-T TARGETS AND FILES
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>gr :topleft :split config/routes.rb<cr>
function! ShowRoutes()
  " Requires 'scratch' plugin
  :topleft 100 :split __Routes__
  " Make sure Vim doesn't write __Routes__ as a file
  :set buftype=nofile
  " Delete everything
  :normal 1GdG
  " Put routes output in buffer
  :0r! bundle exec rake -s routes
  " Size window to number of lines (1 plus rake output length)
  :exec ":normal " . line("$") . "_ "
  " Move cursor to bottom
  :normal 1GG
  " Delete empty trailing line
  :normal dd
endfunction
map <leader>gR :call ShowRoutes()<cr>

map <leader>ac :CommandTFlush<cr>\|:CommandT app/controllers<cr>
map <leader>ad :CommandTFlush<cr>\|:CommandT app/decorators<cr>
map <leader>ah :CommandTFlush<cr>\|:CommandT app/helpers<cr>
map <leader>ai :CommandTFlush<cr>\|:CommandT app/interactors<cr>
map <leader>ajc :CommandTFlush<cr>\|:CommandT app/assets/javascripts/controllers<cr>
map <leader>ajd :CommandTFlush<cr>\|:CommandT app/assets/javascripts/directives<cr>
map <leader>ajm :CommandTFlush<cr>\|:CommandT app/assets/javascripts/models<cr>
map <leader>ajs :CommandTFlush<cr>\|:CommandT app/assets/javascripts/services<cr>
map <leader>am :CommandTFlush<cr>\|:CommandT app/models<cr>
map <leader>as :CommandTFlush<cr>\|:CommandT app/serializers<cr>
map <leader>au :CommandTFlush<cr>\|:CommandT app/uploaders<cr>
map <leader>aw :CommandTFlush<cr>\|:CommandT app/workers<cr>
map <leader>av :CommandTFlush<cr>\|:CommandT app/views<cr>
map <leader>ci :CommandTFlush<cr>\|:CommandT config/intializers<cr>
map <leader>lt :CommandTFlush<cr>\|:CommandT lib/tasks<cr>
map <leader>gf :topleft 100 :split Gemfile<cr>
map <leader>tc :CommandTFlush<cr>\|:CommandT spec/controllers<cr>
map <leader>td :CommandTFlush<cr>\|:CommandT spec/decorators<cr>
map <leader>th :CommandTFlush<cr>\|:CommandT spec/helpers<cr>
map <leader>ti :CommandTFlush<cr>\|:CommandT spec/interactors<cr>
map <leader>tm :CommandTFlush<cr>\|:CommandT spec/models<cr>
map <leader>ts :CommandTFlush<cr>\|:CommandT spec/serializers<cr>
map <leader>tu :CommandTFlush<cr>\|:CommandT spec/uploaders<cr>
map <leader>tw :CommandTFlush<cr>\|:CommandT spec/workers<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap CTAGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>mc :!/usr/local/bin/ctags -R --exclude=.git --exclude=log * ~/.rvm/gems/ruby-2.0.0-p353@momcorp*

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
"Customize Vroom Plugin for tests
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vroom_use_bundle_exec = 1
let g:vroom_spec_command = 'rspec'
