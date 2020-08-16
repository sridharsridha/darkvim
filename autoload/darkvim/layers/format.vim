" format.vim format layer for darkvim

function! darkvim#layers#format#plugins() abort
	let l:plugins = []

	call add(l:plugins, ['neoformat/neoformat',
				\ {'on_cmd' : ['Neoformat'],
				\ 'loadconf' : 1,
				\ }])

	return l:plugins
endfunction

function! darkvim#layers#format#config() abort
	call darkvim#mapping#space#group(['F'], 'Format')
	call darkvim#mapping#space#def('nnoremap', ['F', 'f'],
				\ 'Neoformat',
				\ 'format-code', 1)
	command! ToggleAutoFormatCode :call ToggleAutoFormatCode()
	call darkvim#mapping#space#def('nnoremap', ['F', 't'], 'ToggleAutoFormatcode', 'toggle-auto-format', 1)
endfunction

function! ToggleAutoFormatCode() abort
	if !exists('#AutoFormatCode#BufWritePre')
		augroup AutoFormatCode
			autocmd!
			autocmd BufWritePre * undojoin | Neoformat
		augroup END
	else
		augroup AutoFormatCode
			autocmd!
		augroup END
	endif
endfunction
