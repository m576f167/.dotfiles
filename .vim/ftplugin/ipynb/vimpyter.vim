" Vim Screen
function HackUltiSnipsWarning()
	unlet b:did_autoload_ultisnips
	if !exists("g:_uspy")
		finish
	endif

	exec g:_uspy "sys.path.append('/Users/user/.vim/plugged/ultisnips/pythonx')"
endfunction

:map <Leader>rr :call HackUltiSnipsWarning()<CR>

:map <Leader>i :VimpyterInsertPythonBlock<CR>
:map <Leader>ri :VimpyterUpdate<CR>
:map <Leader>rf :VimpyterStartJupyter<CR>
:map <Leader>gn /```{.python\p*}<CR><C-f><C-c>j0
:map <Leader>gN ?```{.python\p*}<CR><C-f><C-c>j0
