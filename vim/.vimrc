set nocp
filetype plugin on
filetype plugin indent on
syntax enable
set nobackup
set nowritebackup
set history=500  " 500 commands to remember
set ruler  " show the cursor position all the time
set showcmd  " display incomplete commands
set incsearch  " do incremental searching
set background=dark

execute pathogen#infect()

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

" Warning and Danger sections
let &colorcolumn="80,".join(range(120,999),",")
highlight ColorColumn ctermbg=233 guibg=#2c2d27

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

let python_highlight_all=1

let g:airline_powerline_fonts = 1

let g:syntastic_python_pylint_args = "-d C0111"

map <Leader>t :Tagbar <CR>

set wildignore+=*.pyc

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
