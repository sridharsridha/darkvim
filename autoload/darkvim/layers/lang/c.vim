" c.vim --- darkvim lang#c layer

" This layer provides C family language code completion and syntax checking.
" Requires clang.

let g:darkvim_clang_path = 'clang'

function! darkvim#layers#lang#c#plugins() abort
	let plugins = []

	call add(plugins, ['octol/vim-cpp-enhanced-highlight', {
				\ 'on_ft' : ['c', 'cpp'],
				\ }])

	return plugins
endfunction

function! darkvim#layers#lang#c#config() abort
	call darkvim#mapping#localleader#reg_lang_mappings_cb('c',
				\ function('s:language_specified_mappings'))
	call darkvim#mapping#localleader#reg_lang_mappings_cb('cpp',
				\ function('s:language_specified_mappings'))
endfunction

function! s:language_specified_mappings() abort
	" Nothing here yet
endfunction

