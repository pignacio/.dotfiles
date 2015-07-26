setlocal tabstop=8
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal smarttab
setlocal expandtab
setlocal foldmethod=indent
set nosmartindent
set list!
set listchars=tab:>-

highlight ColorColumn ctermbg=200
call matchadd('ColorColumn', '\%81v', 100)

let python_highlight_all=1

let g:syntastic_python_pylint_args = "-d C0111"

map <buffer> <Leader>cs :Coveragepy show <CR>
map <buffer> <Leader>cr :Coveragepy report <CR>
map <buffer> <Leader>cx :Coveragepy session <CR>

" yapf-format
map <buffer> <C-l> :YapfFullFormat<CR>
imap <buffer> <C-l> <ESC>:YapfFormat<CR>i
vmap <buffer> <C-l> :YapfFormat<CR>

" Run and show format diff in new buffer mappings
nmap <buffer> <C-e> :! ipython %<CR>
nmap <buffer> <C-g> :! ipython -i %<CR>
nmap <buffer> <C-f> :! time yapf --diff %<CR>
