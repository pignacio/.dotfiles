setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal smarttab
setlocal expandtab
setlocal foldmethod=indent
set nosmartindent
set list!
set listchars=tab:>-

highlight ColorColumn ctermbg=200
call matchadd('ColorColumn', '\%81v', 100)
