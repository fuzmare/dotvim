" Continuous macro execution
nnoremap @@ @@<Plug>(atmark)
nnoremap <Plug>(atmark)@ @@<Plug>(atmark)

" Cursor keys do not start undo block
inoremap <Left> <C-G>U<Left>
inoremap <Right> <C-G>U<Right>
