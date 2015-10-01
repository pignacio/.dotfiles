setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal smarttab
setlocal expandtab
setlocal foldmethod=syntax

set nosmartindent

set cino=N-s,g1,h3

highlight ColorColumn ctermbg=200
call matchadd('ColorColumn', '\%81v', 100)

" cpplint results in preview window
noremap <buffer> <leader>c :Shell cpplint.py --root=src %<CR><CR>

" clang-format
map <buffer> <C-l> :%pyf /usr/share/vim/addons/syntax/clang-format-3.5.py<CR>
imap <buffer> <C-l> <ESC>:pyf /usr/share/vim/addons/syntax/clang-format-3.5.py<CR>i
vmap <buffer> <C-l> :pyf /usr/share/vim/addons/syntax/clang-format-3.5.py<CR>

" goto
map <buffer> <leader>g :YcmCompleter GoTo<CR>

" switch between header and source
map <buffer> <leader>f :A<CR>

let b:colors_name = 'molokai'
