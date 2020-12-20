" format.vim format layer for darkvim

function! darkvim#layers#format#plugins() abort
	let l:plugins = []

	call add(l:plugins, ['neoformat/neoformat',
				\ {'on_cmd' : ['Neoformat'],
				\ 'loadconf_before' : 1,
				\ }])

	return l:plugins
endfunction

function! darkvim#layers#format#config() abort
endfunction

