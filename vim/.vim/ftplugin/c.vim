setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal smarttab
setlocal expandtab

set nosmartindent

set cino=N-s

" Warning and Danger sections
let &colorcolumn="80,".join(range(120,999),",")
highlight ColorColumn ctermbg=233 guibg=#2c2d27
