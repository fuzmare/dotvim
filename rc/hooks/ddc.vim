" hook_add {{{
nnoremap :       <Cmd>call CommandlinePre(':')<CR>:
nnoremap ?       <Cmd>call CommandlinePre('/')<CR>?
xnoremap :       <Cmd>call CommandlinePre(':')<CR>:
nnoremap +       <Cmd>call CommandlinePre('dda')<CR>:Dda<Space>

function! CommandlinePre(mode) abort
  " Overwrite sources
  let b:prev_buffer_config = ddc#custom#get_buffer()

  if a:mode ==# ':'
    call ddc#custom#patch_buffer('sourceOptions', #{
          \   _: #{
          \     keywordPattern: '[0-9a-zA-Z_:#-]*',
          \   },
          \ })
  elseif a:mode ==# 'dda'
    " For AI completion
    call ddc#custom#patch_buffer('cmdlineSources', ['around', 'mocword'])
  endif

  autocmd User DDCCmdlineLeave ++once call CommandlinePost()

  call ddc#enable_cmdline_completion()
endfunction
function! CommandlinePost() abort
  " Restore config
  if 'b:prev_buffer_config'->exists()
    call ddc#custom#set_buffer(b:prev_buffer_config)
    unlet b:prev_buffer_config
  endif
endfunction
" }}}

" hook_source {{{
call ddc#custom#load_config(expand('$HOOKS_DIR/ddc.ts'))
call ddc#custom#patch_global('sourceParams', #{
      \   nvim-lsp: #{
      \     snippetEngine: denops#callback#register({
      \           body -> vsnip#anonymous(body)
      \     }),
      \   }
      \ })

" For insert mode completion
inoremap <expr> <TAB>
      \ pum#visible() ?
      \   '<Cmd>call pum#map#insert_relative(+1, "loop")<CR>' :
      \ vsnip#jumpable(1) ?
      \   '<Plug>(vsnip-jump-next)' :
      \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
      \   '<TAB>' : ddc#map#manual_complete()
inoremap <expr> <S-Tab>
      \ pum#visible() ?
      \   '<Cmd>call pum#map#insert_relative(-1, "loop")<CR>' :
      \ vsnip#jumpable(-1) ?
      \   '<Plug>(vsnip-jump-prev)' :
      \ '<TAB>'
inoremap <C-n>   <Cmd>call pum#map#select_relative(+1, "loop")<CR>
inoremap <C-p>   <Cmd>call pum#map#select_relative(-1, "loop")<CR>
inoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
inoremap <C-o>   <Cmd>call pum#map#confirm_word()<CR>
inoremap <expr> <Home> pum#visible() ? '<Cmd>call pum#map#insert_relative(-9999, "ignore")<CR>' : '<Home>'
inoremap <expr> <End> pum#visible() ? '<Cmd>call pum#map#insert_relative(+9999, "ignore")<CR>' : '<End>'
"inoremap <C-z>   <Cmd>call pum#update_current_item(#{ display: 'hoge' })<CR>

" Refresh the completion
inoremap <expr> <C-l> ddc#map#manual_complete()

" For command line mode completion
cnoremap <expr> <Tab>
      \ wildmenumode() ? &wildcharm->nr2char() :
      \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
      \ ddc#map#manual_complete()
cnoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
cnoremap <C-o>   <Cmd>call pum#map#confirm()<CR>
cnoremap <C-q>   <Cmd>call pum#map#select_relative(+1)<CR>
cnoremap <C-z>   <Cmd>call pum#map#select_relative(-1)<CR>
cnoremap <expr> <C-e> pum#visible()
      \ ? '<Cmd>call pum#map#cancel()<CR>'
      \ : '<End>'

"cnoremap <expr> <C-t>       ddc#map#insert_item(0)
"inoremap <expr> <C-t>       ddc#map#insert_item(0)


" For terminal completion
tnoremap <C-t> <Tab>
tnoremap <expr> <Tab> pum#visible() ?
      \ '<Cmd>call pum#map#select_relative(+1)<CR>' :
      \ '<Tab>'
tnoremap <expr> <S-Tab> pum#visible() ?
      \ '<Cmd>call pum#map#select_relative(-1)<CR>' :
      \ '<S-Tab>'
tnoremap <C-y>    <Cmd>call pum#map#confirm()<CR>
tnoremap <C-o>    <Cmd>call pum#map#confirm()<CR>
tnoremap <expr> <CR> pumvisible() ?
      \ '<Cmd>call pum#map#confirm()<CR>' :
      \ '<CR>'
call ddc#enable_terminal_completion()

" Narrowing by ddu
inoremap <C-a> <Cmd>call ddu#start(#{
      \   name: 'ddc',
      \   ui: 'ff',
      \   sync: v:true,
      \   input: matchstr(getline('.')[: col('.') - 1], '\k*$'),
      \   sources: [
      \     #{ name: 'ddc', options: #{ defaultAction: 'complete' } },
      \   ],
      \   uiParams: #{
      \     ff: #{
      \       startFilter: v:true,
      \       replaceCol: match(getline('.')[: col('.') - 1], '\k*$') + 1,
      \     },
      \   },
      \ })<CR>

call ddc#enable(#{
      \   context_filetype: has('nvim') ? 'treesitter' : 'context_filetype',
      \ })
" }}}
