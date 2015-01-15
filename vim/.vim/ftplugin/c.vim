setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal smarttab
setlocal expandtab

set nosmartindent

set cino=N-s,g1,h3

" Warning and Danger sections
let &colorcolumn="80,".join(range(120,999),",")
highlight ColorColumn ctermbg=233 guibg=#2c2d27

" cpplint results in preview window
noremap <leader>c :let cloutput=system('cpplint.py --root=src '.expand('%'))<cr>:new<cr>:put =cloutput<cr>:q!

" clang-format
map <C-I> :%pyf /usr/share/vim/addons/syntax/clang-format-3.5.py<CR>
imap <C-I> <ESC>:pyf /usr/share/vim/addons/syntax/clang-format-3.5.py<CR>i
vmap <C-I> :pyf /usr/share/vim/addons/syntax/clang-format-3.5.py<CR>
