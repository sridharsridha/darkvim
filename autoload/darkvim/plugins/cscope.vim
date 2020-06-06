" use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
set cscopetag
" check cscope for definition of a symbol before checking ctags: set to 1
" if you want the reverse search order.
set csto=0

" Use quickfix window for cscope results. Clear previous results before the search.
set cscopequickfix=s+,c+,d+,i+,t+,e+,g+,f+

" Title String
function! s:set_title(what, query) abort
	let text = ""
	if a:what == '0' || a:what == 's'
		let text = 'symbol "'.a:query.'"'
	elseif a:what == '1' || a:what == 'g'
		let text = 'definition of "'.a:query.'"'
	elseif a:what == '2' || a:what == 'd'
		let text = 'functions called by "'.a:query.'"'
	elseif a:what == '3' || a:what == 'c'
		let text = 'functions calling "'.a:query.'"'
	elseif a:what == '4' || a:what == 't'
		let text = 'string "'.a:query.'"'
	elseif a:what == '6' || a:what == 'e'
		let text = 'egrep "'.a:query.'"'
	elseif a:what == '7' || a:what == 'f'
		let text = 'file "'.a:query.'"'
	elseif a:what == '8' || a:what == 'i'
		let text = 'files including "'.a:query.'"'
	elseif a:what == '9' || a:what == 'a'
		let text = 'assigned "'.a:query.'"'
	endif
	exec 'cexpr text'
	let title = text
	if has('nvim') == 0 && (v:version >= 800 || has('patch-7.4.2210'))
		call setqflist([], 'a', {'title':title})
	elseif has('nvim')
		call setqflist([], 'a', {'title':title})
	else
		call setqflist([], 'a')
	endif
endfunc

" Run cscope
function! s:run(search_query) abort
	let l:MESSAGE = darkvim#api#import('vim#message')
	let success = 1
	try
		silent! keepjumps execute a:search_query
		redrawstatus
	catch /^Vim\%((\a\+)\)\=:E567/
		redrawstatus
		call s:MESSAGE.error("E567: no cscope connections")
		let success = 0
	catch /^Vim\%((\a\+)\)\=:E/
		redrawstatus
		call s:MESSAGE.error("ERROR: cscope error")
		let success = 0
	endtry
	return success
endfunc

function! darkvim#plugins#cscope#open_list() abort
	botright copen
endfunction

" Find search
function! darkvim#plugins#cscope#find(what, query)
	if empty(a:query)
		let query = input(g:darkvim_commandline_prompt . " ")
		normal! :
	else
		let query = a:query
	endif
	let query = fnameescape(query)
	cclose
	call setqflist([])
	call s:set_title(a:what, query)
	let cmd = "cs find " . a:what . " " . query
	call s:run(cmd)
	call darkvim#plugins#cscope#open_list()
endfunc

