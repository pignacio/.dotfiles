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

" Show hidden files in ctrlp
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = {
      \ 'dir': '\v[\/](bundle|target|dist|.*egg-info|assets|_build|.*.egg|\.(swp|bzr|git|svn|eggs|tox))$',
      \ 'file': '\v\.(exe|so|dll|d|o|py[cod])$',
      \ }


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
map <C-c> :let b:syntastic_skip_checks = 0<CR>:w<CR>:SyntasticCheck<CR>

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
