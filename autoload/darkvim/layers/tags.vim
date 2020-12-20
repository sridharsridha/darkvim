" tags.vim --- darkvim gtags layer
function! darkvim#layers#tags#plugins() abort
	let l:plugins = []

	" Automatic tag generation
	call add(l:plugins, ['ludovicchabant/vim-gutentags', {
				\ 'on_event' : [ 'BufReadPost' ],
				\ 'loadconf' : 1,
				\ 'loadconf_before' : 1,
				\ }])

	" Open symbols window
	call add(l:plugins, ['majutsushi/tagbar', {
				\ 'on_cmd' : ['TagbarToggle'],
				\ 'loadconf' : 1,
				\ 'loadconf_before' : 1,
				\ }])


	return l:plugins
endfunction

function! darkvim#layers#tags#config() abort
	" Gutentags
	call darkvim#mapping#space#group(['c'], 'Tags')
	call darkvim#mapping#space#def('nnoremap', ['c', 'u'],
				\ 'GutentagsUpdate!',
				\ 'update-tags-cur-proj', 1)
	call darkvim#mapping#space#def('nnoremap', ['c', 'U'],
				\ 'GutentagsUpdate',
				\ 'update-tags-cur-file', 1)

	" Cscope
	call darkvim#mapping#space#group(['c'], 'Tags')
	call darkvim#mapping#space#def('nnoremap', ['c', 'd'],
				\ 'call darkvim#plugins#cscope#find("d", expand("<cword>"))',
				\ 'find-functions-called-by-this-function', 1)
	call darkvim#mapping#space#def('nnoremap', ['c', 'c'],
				\ 'call darkvim#plugins#cscope#find("c", expand("<cword>"))',
				\ 'find-functions-calling-this-function', 1)
	call darkvim#mapping#space#def('nnoremap', ['c', 'g'],
				\ 'call darkvim#plugins#cscope#find("g", expand("<cword>"))',
				\ 'find-global-definition-of-a-symbol', 1)
	call darkvim#mapping#space#def('nnoremap', ['c', 's'],
				\ 'call darkvim#plugins#cscope#find("s", expand("<cword>"))',
				\ 'find-references-of-a-symbol', 1)
	call darkvim#mapping#space#def('nnoremap', ['c', 'f'],
				\ 'call darkvim#plugins#cscope#find("f", expand("<cword>"))',
				\ 'find-files', 1)
	call darkvim#mapping#space#def('nnoremap', ['c', 'i'],
				\ 'call darkvim#plugins#cscope#find("i", expand("<cword>"))',
				\ 'find-files-including-this-file', 1)
	call darkvim#mapping#space#def('nnoremap', ['c', 'e'],
				\ 'call darkvim#plugins#cscope#find("e", expand("<cword>"))',
				\ 'Find-this-egrep-pattern', 1)
	call darkvim#mapping#space#def('nnoremap', ['c', 't'],
				\ 'call darkvim#plugins#cscope#find("t", expand("<cword>"))',
				\ 'find-this-text-string', 1)
	call darkvim#mapping#space#def('nnoremap', ['c', 'a'],
				\ 'call darkvim#plugins#cscope#find("a", expand("<cword>"))',
				\ 'find-assignments-to-this-symbol', 1)
endfunction


