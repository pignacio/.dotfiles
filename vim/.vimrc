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
Plugin 'conradirwin/vim-bracketed-paste'
" Plugin 'davidhalter/jedi-vim'
Plugin 'elzr/vim-json'
Plugin 'gmarik/Vundle.vim'
Plugin 'godlygeek/tabular'
Plugin 'genoma/vim-less'
Plugin 'honza/vim-snippets'
Plugin 'jmcantrell/vim-virtualenv'
Plugin 'juleswang/css.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'luochen1990/rainbow'
Plugin 'majutsushi/tagbar'
Plugin 'mattn/emmet-vim'
Plugin 'octol/vim-cpp-enhanced-highlight'
" Plugin 'pignacio/vim-yapf-format'
set runtimepath+=$HOME/.vim/bundle/vim-yapf-format
Plugin 'raimondi/delimitmate'
Plugin 'rhysd/vim-clang-format'
Plugin 'rodjek/vim-puppet'
Plugin 'scrooloose/syntastic'
Plugin 'sirver/ultisnips'
Plugin 'tejr/vim-nagios'
Plugin 'terryma/vim-expand-region'
Plugin 'tmhedberg/SimpylFold'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'tshirtman/vim-cython'
Plugin 'valloric/listtoggle'
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

autocmd BufEnter * let &titlestring = hostname() . "[vim(" . expand("%") . ")]"
set title

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

" Show hidden files in ctrlp
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = {
      \ 'dir': '\v[\/](bundle|target|dist|.*egg-info|assets|_build|.*.egg|node_modules|\.(swp|bzr|git|svn|eggs|tox))$',
      \ 'file': '\v\.(exe|so|dll|d|o|py[cod])$',
      \ }
let g:ctrlp_user_command = {
      \ 'types': {
      \   1: ['.ctrlpignore', 'find %s -type f | grep -v -E "`cat .ctrlpignore`"'],
      \ },
      \ 'ignore': 1
      \ }
let g:ctrlp_open_new_file = 't'

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
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_always_populate_location_list = 1

" email
let g:email = 'rossi.ignacio@gmail.com'

" default license
let g:license = 'GPLv3'

" UltiSnips configuration
let g:UltiSnipsExpandTrigger="<c-a>"
let g:UltiSnipsJumpForwardTrigger="<c-a>"
let g:UltiSnipsJumpBackwardTrigger="<c-s>"

" snippets author
let g:snips_author = 'Ignacio Rossi'

" Enable puppet's future parser
let g:syntastic_puppet_puppet_args = '--parser future'

" Syntastic recommended settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

" make syntastic passive by default
let g:syntastic_mode_map = {
    \ "mode": "acive",
    \ "active_filetypes": [],
    \ "passive_filetypes": ["python"] }

" SyntasticCheck binding
map <C-x> :let b:syntastic_skip_checks = 0<CR>:w<CR>:SyntasticCheck<CR>

" Use all python checkers
let g:syntastic_python_checkers = ['python', 'pep8', 'pylint']

" Use rstcheck
let g:syntastic_rst_checkers = ['rstcheck']

" Aggregate errors
let g:syntastic_aggregate_errors = 1

" disable delimitMate pairs in htmldjango
au FileType htmldjango let b:delimitMate_matchpairs = ""

" custom vim-templates dir
let g:templates_directory = '~/.vim/templates'

let g:templates_user_variables = [
      \['MY_GUARD', 'GetSrcGuard'],
      \['NS_START', 'GetSrcNamespacesStart'],
      \['NS_END', 'GetSrcNamespacesEnd'],
      \['HEADER', 'GetSrcHeader'],
      \]
function GetSrcPath()
  return split(expand('%:p'), '/src/')[-1]
endfunction

function GetSrcGuard()
  return toupper(substitute(GetSrcPath(), "[^a-zA-Z0-9]", "_", "g")) . '_'
endfunction

function GetSrcHeader()
  let l:values = split(GetSrcPath(), '\.')
  echo "len" . len(l:values) . ' path ' . GetSrcPath()
  let l:values[-1] = 'h'
  return join(l:values, '.')
endfunction

function GetSrcNamespaces()
  return  split(GetSrcPath(), '/')[:-2]
endfunction

function GetSrcNamespacesStart()
  let l:declarations = []
  for l:namespace in GetSrcNamespaces()
    call add(l:declarations, 'namespace ' . l:namespace . ' {')
  endfor
  return join(l:declarations, '\r')
endfunction

function GetSrcNamespacesEnd()
  let l:declarations = []
  for l:namespace in GetSrcNamespaces()
    call add(l:declarations, '}  // namespace ' . l:namespace)
  endfor
  call reverse(l:declarations)
  return join(l:declarations, '\r')
endfunction


" yapf location
let g:yapf_format_yapf_location = '~/src/yapf'

" Run command and push output to another buffer
command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  echo a:cmdline
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
    if part[0] =~ '\v[%#<]'
      let expanded_part = fnameescape(expand(part))
      let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
    endif
  endfor
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:    ' . a:cmdline)
  call setline(2, 'Expanded Form:  ' .expanded_cmdline)
  call setline(3,substitute(getline(2),'.','=','g'))
  execute '$read !'. expanded_cmdline
  setlocal nomodifiable
  1
endfunction

let g:alternateExtensions_h = 'cpp'

" Custom colorscheme for buffers
au BufEnter * if (exists("b:colors_name")) | let b:current_colors=colors_name
 \| execute "colorscheme " . b:colors_name | endif
au BufLeave * if (exists("b:current_colors")) | execute "colorscheme " . b:current_colors | endif

" Select last paste
nnoremap gp `[V`]

" run make mapping
nmap mm :!make<cr>
nmap mr :!make run<cr>
nmap mt :!make test<cr>

" rainbow config
let g:rainbow_active = 1

let g:rainbow_conf = {
    \   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
    \   'ctermfgs': ['darkblue', 'darkyellow', 'darkmagenta', 'darkred', 'darkgreen'],
    \   'operators': '_,_',
    \   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
    \   'separately': {
    \       '*': {},
    \       'tex': {
    \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
    \       },
    \       'python': {
    \           'operators': '_[:,]_',
    \       },
    \       'vim': {
    \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
    \       },
    \       'html': {
    \           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
    \       },
    \       'htmldjango': {
    \           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
    \       },
    \       'css': 0,
    \   }
    \}

execute "set <M-q>=\eq"
nmap <M-q> :RainbowToggle<CR>

let g:lt_location_list_toggle_map = '<leader>v'
let g:lt_height = 10

vmap <leader>c :w !xclip -selection c<CR><CR>
nmap <leader>c :w% !xclip -selection c

" Exclude html from automatic traling whitespace trimming
fun! StripTrailingWhitespace()
  " Only strip if the b:noStripeWhitespace variable isn't set
  if exists('b:noStripWhitespace')
    return
  endif
  FixWhitespace
endfun

autocmd BufWrite * call StripTrailingWhitespace()
autocmd FileType html,htmldjango let b:noStripWhitespace=1

" Fix whitespace mapping
nmap mfw :FixWhitespace<CR>

" Map semicolon to colon
nnoremap ; :

" use django filetype for all html files
autocmd BufRead,BufNewFile *.html set ft=htmldjango

" show dosctring preview
let g:SimpylFold_docstring_preview = 1

" map folding toggle to spacebar
nnoremap <space> za

" Split to the bottom by default
set splitbelow

" Error list toggle
function! ToggleErrors()
    let old_last_winnr = winnr('$')
    lclose
    if old_last_winnr == winnr('$')
        " Nothing was closed, open syntastic error location panel
        Errors
    endif
endfunction

nnoremap <silent> ll :call ToggleErrors()<CR>

" Open YCM goto in new tabs
let g:ycm_goto_buffer_command = 'new-tab'
