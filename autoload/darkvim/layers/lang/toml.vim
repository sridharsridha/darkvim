" toml.vim --- toml layer for darkvim

function! darkvim#layers#lang#toml#plugins() abort
	let plugins = []
	call add(plugins, ['cespare/vim-toml', {
				\ 'on_ft' : ['toml'],
				\ }])
	return plugins
endfunction

function! darkvim#layers#lang#toml#config() abort

endfunction
