" c.vim --- darkvim lang#c layer

" This layer provides C family language code completion and syntax checking.
" Requires clang.

function! darkvim#layers#lang#c#plugins() abort
	let l:plugins = []

	call add(l:plugins, ['octol/vim-cpp-enhanced-highlight', {
				\ 'on_ft' : ['c', 'cpp'],
				\ }])
	if darkvim#layers#is_loaded('lsp')
		call add(l:plugins, ['jackguo380/vim-lsp-cxx-highlight', {
					\ 'on_ft' : ['c', 'cpp'],
					\ }])
	endif

	return l:plugins
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

