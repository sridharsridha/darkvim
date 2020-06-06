function! darkvim#layers#lang#sh#plugins() abort
	let l:plugins = []

	call add(l:plugins, ['chrisbra/vim-zsh', {
				\ 'on_ft' : 'zsh',
				\ }])

	return l:plugins
endfunction

function! darkvim#layers#lang#sh#config() abort
	let g:zsh_fold_enable = 1
	call darkvim#mapping#space#regesit_lang_mappings('sh',
				\ function('s:language_specified_mappings'))
endfunction

function! s:language_specified_mappings() abort
	" Nothing zsh specific mapping yet
endfunction

