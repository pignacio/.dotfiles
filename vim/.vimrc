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
Plugin 'alfredodeza/coveragepy.vim'
Plugin 'aperezdc/vim-template'
Plugin 'bling/vim-airline'
Plugin 'davidhalter/jedi-vim'
Plugin 'elzr/vim-json'
Plugin 'gmarik/Vundle.vim'
Plugin 'godlygeek/tabular'
Plugin 'honza/vim-snippets'
Plugin 'jmcantrell/vim-virtualenv'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'raimondi/delimitmate'
Plugin 'rhysd/vim-clang-format'
Plugin 'rodjek/vim-puppet'
Plugin 'scrooloose/syntastic'
Plugin 'sirver/ultisnips'
Plugin 'tejr/vim-nagios'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'
Plugin 'valloric/youcompleteme'

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
let g:tagbar_autofocus = 1
" Ignores for CtrlP
set wildignore+=*.pyc

" Show hidden files in ctrlp, except bundle
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = '\v[\/](bundle|target|dist|.*egg-info|assets)|(\.(swp|bzr|git|svn))$'

set foldlevelstart=0

" Open splits to the right
set splitright

" Paste mode shortcut
nnoremap <leader>p :setlocal paste!<cr>

" swap files directory
set directory=~/.vim/tmp,/tmp
if !isdirectory(&directory)
    call mkdir(&directory, "p")
endif

" tabswap mappings
map <leader>j :tabp <cr>
map <leader>k :tabn <cr>

" sort mapping
map <leader>s :sort <cr>

" syntastic for c++11
let g:syntastic_cpp_compiler_options = ' -std=c++11'

" so jedi does not step in youcompleteme toes
let g:jedi#popup_select_first = 0
let g:jedi#popup_on_dot = 0

" global YCM conficuration
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

" email
let g:email = 'rossi.ignacio@gmail.com'

" default license
let g:license = 'GPLv3'

" UltiSnips configuration
let g:UltiSnipsExpandTrigger="<c-a>"
let g:UltiSnipsJumpForwardTrigger="<c-a>"
let g:UltiSnipsJumpBackwardTrigger="<c-s>"

" Enable puppet's future parser
let g:syntastic_puppet_puppet_args = '--parser future'
