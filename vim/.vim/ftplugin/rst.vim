" Warning and Danger sections
setlocal tabstop=4
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal smarttab
setlocal expandtab
set textwidth=79
set formatoptions+=t

let &colorcolumn="80,".join(range(120,999),",")
highlight ColorColumn ctermbg=233 guibg=#2c2d27
