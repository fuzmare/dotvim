" jk
nnoremap gj gj<Plug>(gjk)
nnoremap gk gk<Plug>(gjk)
nnoremap <Plug>(gjk)j gj<Plug>(gjk)
nnoremap <Plug>(gjk)k gk<Plug>(gjk)

" Continuous macro execution
nnoremap @@ @@<Plug>(atmark)
nnoremap <Plug>(atmark)@ @@<Plug>(atmark)

" Cursor keys do not start undo block
inoremap <Left> <C-G>U<Left>
inoremap <Right> <C-G>U<Right>

" Scroll
" nnoremap <C-d> 3<C-e>
" nnoremap <C-u> 3<C-y>
" nnoremap <C-e> <C-d>
" nnoremap <C-y> <C-u>
