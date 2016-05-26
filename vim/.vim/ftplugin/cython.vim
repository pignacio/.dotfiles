setlocal tabstop=8
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal smarttab
setlocal expandtab
setlocal foldmethod=indent
setlocal nosmartindent
setlocal list!
setlocal listchars=tab:>-

highlight ColorColumn ctermbg=200
call matchadd('ColorColumn', '\%81v', 100)

" yapf-format
" map <buffer> <C-l> :YapfFullFormat<CR>
" imap <buffer> <C-l> <ESC>:YapfFormat<CR>i
" vmap <buffer> <C-l> :YapfFormat<CR>

" Run and show format diff in new buffer mappings
nmap <buffer> mpr :! cython -a %<CR>
" nmap <buffer> mpi :! ipython -i %<CR>
" nmap <buffer> mpf :! time yapf --diff %<CR>

" goto
map <buffer> <leader>g :YcmCompleter GoTo<CR>

