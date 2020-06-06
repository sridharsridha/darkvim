" tags.vim --- darkvim gtags layer
function! darkvim#layers#tags#plugins() abort
	let plugins = []

	" Automatic tag generation
	call add(plugins, ['ludovicchabant/vim-gutentags', {
				\ 'on_event' : [ 'BufReadPost' ],
				\ 'loadconf' : 1,
				\ }])

	return plugins
endfunction

function! darkvim#layers#tags#config() abort
	" Gutentags
	call darkvim#mapping#space#group(['t'], "Tags")
	call darkvim#mapping#space#def('nnoremap', ['t', 'u'],
				\ 'GutentagsUpdate!',
				\ 'update-tags-cur-proj', 1)
	call darkvim#mapping#space#def('nnoremap', ['t', 'U'],
				\ 'GutentagsUpdate',
				\ 'update-tags-cur-file', 1)

	" Cscope
	call darkvim#mapping#space#def('nnoremap', ['t', 'c'],
				\ 'call darkvim#plugins#cscope#find("d", expand("<cword>"))',
				\ 'find-functions-called-by-this-function', 1)
	call darkvim#mapping#space#def('nnoremap', ['t', 'C'],
				\ 'call darkvim#plugins#cscope#find("c", expand("<cword>"))',
				\ 'find-functions-calling-this-function', 1)
	call darkvim#mapping#space#def('nnoremap', ['t', 'd'],
				\ 'call darkvim#plugins#cscope#find("g", expand("<cword>"))',
				\ 'find-global-definition-of-a-symbol', 1)
	call darkvim#mapping#space#def('nnoremap', ['t', 'r'],
				\ 'call darkvim#plugins#cscope#find("s", expand("<cword>"))',
				\ 'find-references-of-a-symbol', 1)
	call darkvim#mapping#space#def('nnoremap', ['t', 'f'],
				\ 'call darkvim#plugins#cscope#find("f", expand("<cword>"))',
				\ 'find-files', 1)
	call darkvim#mapping#space#def('nnoremap', ['t', 'F'],
				\ 'call darkvim#plugins#cscope#find("i", expand("<cword>"))',
				\ 'find-files-including-this-file', 1)
	call darkvim#mapping#space#def('nnoremap', ['t', 'e'],
				\ 'call darkvim#plugins#cscope#find("e", expand("<cword>"))',
				\ 'Find-this-egrep-pattern', 1)
	call darkvim#mapping#space#def('nnoremap', ['t', 't'],
				\ 'call darkvim#plugins#cscope#find("t", expand("<cword>"))',
				\ 'find-this-text-string', 1)
	call darkvim#mapping#space#def('nnoremap', ['t', 'a'],
				\ 'call darkvim#plugins#cscope#find("a", expand("<cword>"))',
				\ 'find-assignments-to-this-symbol', 1)
endfunction


