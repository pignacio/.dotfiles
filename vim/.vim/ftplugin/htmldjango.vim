command! ReIndent call ReIndent()
function! ReIndent()
  let l:cursor_pos = getpos(".")
  :normal gg=G
  call setpos(".", l:cursor_pos)
endfunction


map <buffer> <C-o> :ReIndent<CR>
