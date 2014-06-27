set nocompatible              " be iMproved, required

let vundle_is_present=1
let vundle_readme=expand('~/.vim/bundle/Vundle.vim/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle..."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/Vundle.vim ~/.vim/bundle/Vundle.vim
    let vundle_is_present=0
endif

filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'davidhalter/jedi-vim'
Plugin 'scrooloose/syntastic'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-fugitive'
Plugin 'majutsushi/tagbar'
Plugin 'kien/ctrlp.vim'
Plugin 'jmcantrell/vim-virtualenv'

" All of your Plugins must be added before the following line
call vundle#end()            " required

if vundle_is_present == 0
     echo "Installing vundle plugins"
     :PluginInstall
endif

filetype plugin indent on    " required
syntax enable
set nobackup
set nowritebackup
set history=500  " 500 commands to remember
set ruler  " show the cursor position all the time
set showcmd  " display incomplete commands
set incsearch  " do incremental searching
set background=dark

autocmd BufWrite * FixWhitespace

" Enabling colors in console
if (!has("gui_running"))
    set t_Co=256
endif

" switch on highlighting the last used search pattern.
set hlsearch

colorscheme pychimp

highlight Comment term=bold ctermfg=2
highlight Constant term=underline ctermfg=7

" Always display the status line
set laststatus=2

" \ is the leader character
let mapleader = ","

" Hide search highlighting
map <Leader>h :set invhls <CR>

" Line numbers
set number
set numberwidth=5

" case only matters with mixed case expressions
set ignorecase
set smartcase

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

map <Leader>t :Tagbar <CR>

" Ignores for CtrlP
set wildignore+=*.pyc

" Cursor coloring
if &term =~ "xterm\\|rxvt"
  " use an orange cursor in insert mode
  let &t_SI = "\<Esc>]12;orange\x7"
  " use a red cursor otherwise
  let &t_EI = "\<Esc>]12;red\x7"
  silent !echo -ne "\033]12;red\007"
  " reset cursor when vim exits
  autocmd VimLeave * silent !echo -ne "\003]12;gray\007"
  "autocmd VimLeave * silent !echo -ne "\033]112\007"
  " use \003]12;gray\007 for gnome-terminal
endif

set foldlevelstart=1
