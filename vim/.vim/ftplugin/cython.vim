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

function! GenerateCythonHtml()
  let b:extension = expand("%:e")
  if b:extension == "pxd"
    let b:source = expand("%:r") . ".pyx"
  else
    let b:source = expand("%")
  endif
  let b:basename = expand("%:t:r")
  let b:dest = '/tmp/' . b:basename . '.c'
  let b:html_dest = '/tmp/'  . b:basename . ".html"
  silent !clear
  execute "silent !cython -a --fast-fail " . b:source . " -o " . b:dest
  if v:shell_error == "0"
    execute "silent !cp " . b:html_dest . " " . expand("%:r") . ".html"
  endif
  !
endfunction

" yapf-format
" map <buffer> <C-l> :YapfFullFormat<CR>
" imap <buffer> <C-l> <ESC>:YapfFormat<CR>i
" vmap <buffer> <C-l> :YapfFormat<CR>

" Run and show format diff in new buffer mappings
nmap <buffer> mpr :call GenerateCythonHtml()<CR>
" nmap <buffer> mpi :! ipython -i %<CR>
" nmap <buffer> mpf :! time yapf --diff %<CR>



" goto
map <buffer> <leader>g :YcmCompleter GoTo<CR>

