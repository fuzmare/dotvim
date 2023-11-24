" hook_add {{{
nmap <C-j> i<Plug>(skkeleton-toggle)
imap <C-j> <Plug>(skkeleton-toggle)
cmap <C-j> <Plug>(skkeleton-toggle)
" }}}
" hook_post_source {{{
" let g:skkeleton#debug = v:true
call skkeleton#config({
  \ 'eggLikeNewline': v:true,
  \ 'registerConvertResult': v:true,
  \ 'globalDictionaries': [["~/.cache/dein/repos/github.com/skk-dev/dict/SKK-JISYO.L", "euc-jp"]],
  \ 'markerHenkan': '',
  \ 'markerHenkanSelect': '',
  \ })
call skkeleton#register_kanatable('rom', {
  \ 'dr': ['である', ''],
  \ 'jj': 'escape',
  \ '~': ['〜', ''],
  \ "z\<Space>": ["\u3000", ''],
  \ })

" skkeleton_pre
autocmd User skkeleton-enable-pre call s:skkeleton_pre()
function! s:skkeleton_pre() abort
  " Overwrite sources
  let s:prev_buffer_config = ddc#custom#get_buffer()
  call ddc#custom#patch_buffer('sources', ['skkeleton'])
endfunction

" skkeleton_post
autocmd User skkeleton-disable-pre call s:skkeleton_post()
function! s:skkeleton_post() abort
  " Restore sources
  call ddc#custom#set_buffer(s:prev_buffer_config)
endfunction

" ddc config
call ddc#custom#patch_global('sourceOptions', {
  \ 'skkeleton': {
  \   'mark': 'skk',
  \   'matchers': ['skkeleton'],
  \   'sorters': [],
  \   'minAutoCompleteLength': 2,
  \ }})
" }}}
