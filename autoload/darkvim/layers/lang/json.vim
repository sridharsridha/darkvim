function! darkvim#layers#lang#json#plugins() abort
	let plugins = []
	call add(plugins, ['elzr/vim-json', {
				\ 'on_ft' : ['javascript','json'],
				\ }])
	return plugins
endfunction

function! darkvim#layers#lang#json#config() abort
	let g:vim_json_syntax_conceal = 0
	let g:vim_json_syntax_concealcursor = ''
endfunction
