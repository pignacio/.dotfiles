setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal smarttab
setlocal expandtab

set nosmartindent

set cino=N-s,g1,h3

highlight ColorColumn ctermbg=200
call matchadd('ColorColumn', '\%81v', 100)

" cpplint results in preview window
noremap <leader>c :let cloutput=system('cpplint.py --root=src '.expand('%'))<cr>:new<cr>:put =cloutput<cr>:q!

" clang-format
map <C-o> :%pyf /usr/share/vim/addons/syntax/clang-format-3.5.py<CR>
imap <C-o> <ESC>:pyf /usr/share/vim/addons/syntax/clang-format-3.5.py<CR>i
vmap <C-o> :pyf /usr/share/vim/addons/syntax/clang-format-3.5.py<CR>

" goto
map <buffer> <leader>g :YcmCompleter GoTo<CR>

" switch between header and source
map <buffer> <leader>f :A<CR>

let b:colors_name = 'molokai'
