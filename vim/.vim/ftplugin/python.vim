setlocal tabstop=8
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal smarttab
setlocal expandtab
setlocal foldmethod=indent
set nosmartindent
set list!
set listchars=tab:>-

" Warning and Danger sections
let &colorcolumn="80,".join(range(120,999),",")
highlight ColorColumn ctermbg=233 guibg=#2c2d27

let python_highlight_all=1

let g:syntastic_python_pylint_args = "-d C0111"

map <Leader>cs :Coveragepy show <CR>
map <Leader>cr :Coveragepy report <CR>
map <Leader>cx :Coveragepy session <CR>
