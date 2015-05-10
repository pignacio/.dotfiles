command! ReIndent call ReIndent()
function! ReIndent()
  let l:winview = winsaveview()
  :normal gg=G
  call winrestview(l:winview)
endfunction


map <buffer> <C-o> :ReIndent<CR>
