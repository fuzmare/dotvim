" hook_add {{{
nnoremap s<Space> <Cmd>Ddu
      \ -name=files file
      \ -source-option-file-path=`expand('$BASE_DIR')`
      \ <CR>
nnoremap ss
      \ <Cmd>Ddu -name=files file_point file_old
      \ `'.git'->finddir(';') != '' ? 'file_git' : ''`
      \ file -source-option-file-volatile
      \ file -source-param-file-new -source-option-file-volatile
      \ -unique -expandInput
      \ -resume=`ddu#get_items(#{ sources: ['file_point'] })->empty() ?
      \          'v:true' : 'v:false'`
      \ -ui-param-ff-displaySourceName=short
      \ -filter-param-matcher_ignore_current_buffer-ignores=
      \`'%'->bufname()->fnamemodify(':p')`
      \ -filter-param-matcher_ignore_current_buffer-actionKey=path
      \ <CR>
nnoremap sr
      \ <Cmd>Ddu -name=files -resume<CR>
nnoremap ;g <Cmd>Ddu
      \ -name=search rg -resume=v:false
      \ -ui-param-ff-ignoreEmpty
      \ -source-param-rg-input='`'Pattern: '->input('<cword>'->expand())`'
      \ <CR>
xnoremap ;g y<Cmd>Ddu
      \ -name=search rg -resume=v:false
      \ -ui-param-ff-ignoreEmpty
      \ -source-param-rg-input='`'Pattern: '->input(v:register->getreg())`'
      \ <CR>
nnoremap ;f <Cmd>Ddu
      \ -name=search rg -resume=v:false
      \ -ui-param-ff-ignoreEmpty
      \ -source-param-rg-input='`'Pattern: '->input('<cword>'->expand())`'
      \ -source-option-rg-path='`'Directory: '->input($'{getcwd()}/', 'dir')`'
      \ <CR>
nnoremap ;r <Cmd>Ddu
      \ -name=register register
      \ -source-option-register-defaultAction=
      \`'.'->col() == 1 ? 'insert' : 'append'`
      \ -ui-param-ff-autoResize
      \ <CR>
nnoremap ;d <Cmd>Ddu
      \ -name=outline markdown
      \ -ui-param-ff-ignoreEmpty
      \ -ui-param-ff-displayTree
      \ <CR>
xnoremap <expr> ;r
      \ (mode() ==# 'V' ? '"_R<Esc>' : '"_d')
      \ .. '<Cmd>Ddu -name=register register
      \ -source-option-ff-defaultAction=insert
      \ -ui-param-autoResize<CR>'
nnoremap sg <Cmd>Ddu dein<CR>
nnoremap <C-o> <Cmd>Ddu jumplist <CR>

"inoremap <C-q> <Cmd>Ddu
"\ -name=register register
"\ -sync
"\ -source-option-register-defaultAction=append
"\ -ui-param-ff-startFilter=v:false
"\ <CR>
inoremap <C-q> <Cmd>call ddu#start(#{
      \   name: 'file',
      \   ui: 'ff',
      \   sync: v:true,
      \   input: '.'->getline()[: '.'->col() - 1]->matchstr('\f*$'),
      \   sources: [
      \     #{ name: 'file', options: #{ defaultAction: 'feedkeys' } },
      \   ],
      \   uiParams: #{
      \     ff: #{
      \       startFilter: v:true,
      \       replaceCol: '.'->getline()[: '.'->col() - 1]->match('\f*$') + 1,
      \     },
      \   },
      \ })<CR>
"cnoremap <C-q> <Cmd>Ddu
"\ -name=register register
"\ -sync
"\ -source-option-register-defaultAction=feedkeys
"\ -ui-param-ff-startFilter=v:false
"\ <CR><Cmd>call setcmdline('')<CR><CR>
cnoremap <C-q> <Cmd>call ddu#start(#{
      \   name: 'file',
      \   ui: 'ff',
      \   sync: v:true,
      \   input: getcmdline()[: getcmdpos() - 2]->matchstr('\f*$'),
      \   sources: [
      \     #{ name: 'file', options: #{ defaultAction: 'feedkeys' } },
      \   ],
      \   uiParams: #{
      \     ff: #{
      \       startFilter: v:true,
      \       replaceCol: getcmdline()[: getcmdpos() - 2]->match('\f*$') + 1,
      \     },
      \   },
      \ })<CR><Cmd>call setcmdline('')<CR><CR>

" Initialize ddu.vim lazily.
  call timer_start(10, { _ ->
        \   ddu#load('ui', ['ff'])
        \ })
  call timer_start(10, { _ ->
        \   ddu#load('source', [
        \     'file', 'file_point', 'file_old', 'file_git',
        \   ])
        \ })
  call timer_start(10, { _ ->
        \   ddu#load('filter', [
        \     'matcher_kensaku', 'matcher_relative', 'matcher_substring',
        \     'matcher_ignore_current_buffer', 'matcher_hidden',
        \     'sorter_alpha',
        \     'converter_hl_dir',
        \   ])
        \ })
  call timer_start(10, { _ ->
        \   ddu#load('kind', ['file'])
        \ })
" }}}

" hook_source = {{{
call ddu#custom#load_config(expand('$HOOKS_DIR/ddu/ddu.ts'))
" }}}
