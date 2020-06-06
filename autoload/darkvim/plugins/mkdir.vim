" mkdir.vim --- auto mkdir when saving file

let s:save_cpo = &cpo
set cpo&vim

function! darkvim#plugins#mkdir#create_current() abort
	call s:create_directory(expand('%:p:h'))
endfunction

fun! s:mkdirp(dir) abort
	if exists('*mkdir')
		try
			call mkdir(a:dir, 'p')
		catch
		endtry
	else
		" @todo mkdir only exist in *nix os
		call system('mkdir -p '.shellescape(a:dir))
	end
endf

fun! s:create_directory(dir) abort
	let d = a:dir

	" @todo do not skip files that have schemes
	if d =~? '^[a-z]\+:/'
		return
	endif

	if !isdirectory(d)
		call s:mkdirp(d)
	end
endf

let &cpo = s:save_cpo
unlet s:save_cpo
