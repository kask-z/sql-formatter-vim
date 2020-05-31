let g:base_path = expand('<sfile>:p')

function! s:SqlFormatterVim() abort

	let s:shell_error_reset = system('echo 0')

	let s:js_path = substitute(g:base_path,'main.vim','util.js ','')

	let s:cmd = 'node ' . s:js_path
	let s:lines = system(s:cmd . ' "' . iconv(join(getline(1, '$'), ' '), &encoding, 'utf-8') . '"')

	if v:shell_error != 0
		echo s:lines
		echoerr 'Error occured in terminal. Please check if sql-formatter is installed correctly.'
		return
	else
		let pos = getcurpos()
		silent! %d _
		call setline(1, split(s:lines, "\n"))
		call setpos('.', pos)
	endif

endfunction

nnoremap <silent> <Plug>(SqlFormatterVim) :<c-u>call <SID>SqlFormatterVim()<cr>

command! -nargs=0 SQLFORMATTER call <SID>SqlFormatterVim()


