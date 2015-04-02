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

map <Leader>cs :Coveragepy show <CR>
map <Leader>cr :Coveragepy report <CR>
map <Leader>cx :Coveragepy session <CR>
