" Vim Screen
:nmap <Leader>e <S-v>:ScreenSend<CR><S-v>`>
:vmap <Leader>e :ScreenSend<CR><S-v>`>
:smap <Leader>e :ScreenSend<CR><S-v>`>
:nmap <Leader>l <S-v>:ScreenSend<CR>
:vmap <Leader>l :ScreenSend<CR>
:smap <Leader>l :ScreenSend<CR>
:nmap <Leader>d <S-v>:ScreenSend<CR><Esc>j
:vmap <Leader>d :ScreenSend<CR><Esc>`>j0
:smap <Leader>d :ScreenSend<CR><Esc>`>j0
:map <Leader>fe :ScreenSend<CR>
:map <Leader>rq :ScreenQuit<CR>
:map <Leader>rf :IPython