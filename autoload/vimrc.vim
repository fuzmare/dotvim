function! vimrc#bw() abort
  while match($BW_SESSION, '\(==\)$') != 86
    let $BW_SESSION = system('$HOME/.local/share/rtx/installs/bitwarden/latest/bin/bw unlock --raw ' . inputsecret('bw password: '))
  endwhile
endfunction

function! vimrc#dein_update() abort
  call vimrc#bw()
  let g:dein#install_github_api_token = system('$HOME/.local/share/rtx/installs/bitwarden/latest/bin/bw get notes dein_token')
  call dein#check_update(v:true)
endfunction

function! vimrc#datetime() abort
  return system("date '+%Y-%m-%dT%H:%M:%S'")
endfunction

function! vimrc#termmap() abort
  "tnoremap <ESC> <c-\><c-n><Plug>(esc)
  "nnoremap <Plug>(esc)<ESC> i<ESC>
  tnoremap <C-W>n       <cmd>new<cr>
  tnoremap <C-W><C-N>   <cmd>new<cr>
  tnoremap <C-W>q       <cmd>quit<cr>
  tnoremap <C-W><C-Q>   <cmd>quit<cr>
  tnoremap <C-W>c       <cmd>close<cr>
  tnoremap <C-W>o       <cmd>only<cr>
  tnoremap <C-W><C-O>   <cmd>only<cr>
  tnoremap <C-W><Down>  <cmd>wincmd j<cr>
  tnoremap <C-W><C-J>   <cmd>wincmd j<cr>
  tnoremap <C-W>j       <cmd>wincmd j<cr>
  tnoremap <C-W><Up>    <cmd>wincmd k<cr>
  tnoremap <C-W><C-K>   <cmd>wincmd k<cr>
  tnoremap <C-W>k       <cmd>wincmd k<cr>
  tnoremap <C-W><Left>  <cmd>wincmd h<cr>
  tnoremap <C-W><C-H>   <cmd>wincmd h<cr>
  tnoremap <C-W><BS>    <cmd>wincmd h<cr>
  tnoremap <C-W>h       <cmd>wincmd h<cr>
  tnoremap <C-W><Right> <cmd>wincmd l<cr>
  tnoremap <C-W><C-L>   <cmd>wincmd l<cr>
  tnoremap <C-W>l       <cmd>wincmd l<cr>
  tnoremap <C-W>w       <cmd>wincmd w<cr>
  tnoremap <C-W><C-W>   <cmd>wincmd w<cr>
  tnoremap <C-W>W       <cmd>wincmd W<cr>
  tnoremap <C-W>t       <cmd>wincmd t<cr>
  tnoremap <C-W><C-T>   <cmd>wincmd t<cr>
  tnoremap <C-W>b       <cmd>wincmd b<cr>
  tnoremap <C-W><C-B>   <cmd>wincmd b<cr>
  tnoremap <C-W>p       <cmd>wincmd p<cr>
  tnoremap <C-W><C-P>   <cmd>wincmd p<cr>
  tnoremap <C-W>P       <cmd>wincmd P<cr>
  tnoremap <C-W>r       <cmd>wincmd r<cr>
  tnoremap <C-W><C-R>   <cmd>wincmd r<cr>
  tnoremap <C-W>R       <cmd>wincmd R<cr>
  tnoremap <C-W>x       <cmd>wincmd x<cr>
  tnoremap <C-W><C-X>   <cmd>wincmd x<cr>
  tnoremap <C-W>K       <cmd>wincmd K<cr>
  tnoremap <C-W>J       <cmd>wincmd J<cr>
  tnoremap <C-W>H       <cmd>wincmd H<cr>
  tnoremap <C-W>L       <cmd>wincmd L<cr>
  tnoremap <C-W>T       <cmd>wincmd T<cr>
  tnoremap <C-W>=       <cmd>wincmd =<cr>
  tnoremap <C-W>-       <cmd>wincmd -<cr>
  tnoremap <C-W>+       <cmd>wincmd +<cr>
  tnoremap <C-W>z       <cmd>pclose<cr>
  tnoremap <C-W><C-Z>   <cmd>pclose<cr>
endfunction
