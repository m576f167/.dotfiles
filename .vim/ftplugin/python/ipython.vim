" Vim Screen
function HackUltiSnipsWarning()
	unlet b:did_autoload_ultisnips
	if !exists("g:_uspy")
		finish
	endif

	exec g:_uspy "sys.path.append('/Users/user/.vim/plugged/ultisnips/pythonx')"
endfunction

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
:map <Leader>rf :IPython<CR>
":map <Leader>ce {<S-v>}:ScreenSend<CR><S-v>`>
":map <Leader>ca {<S-v>}:ScreenSend<CR><Esc>`>j0
:map <Leader>ce ?###{python *\w*}<CR>j<S-v>/###<CR>k:ScreenSend<CR><C-f><C-c><S-v>`>
:map <Leader>ca ?###{python *\w*}<CR>j<S-v>/###<CR>k:ScreenSend<CR><Esc>/###{python *\w*}<CR><C-f><C-c>j0
:map <Leader>rr :call HackUltiSnipsWarning()<CR>
