" source a vimscript file
function! darkvim#util#load_config(file) abort
	if filereadable(g:_darkvim_root_dir. '/config/' . a:file)
		execute 'source ' . g:_darkvim_root_dir  . '/config/' . a:file
	endif
endfunction

" Prefix str to args and return the map
function! darkvim#util#prefix(str, args) abort
    return map(a:args, {_, s -> a:str . s})
endfunction

" Sufix str to args and return the map
function! darkvim#util#suffix(str, args) abort
    return map(a:args, {_, s -> s . a:str})
endfunction

" Cached executable() implemention)
let s:has_exec_cache = {}
function! darkvim#util#has_exec(command) abort
    if !has_key(s:has_exec_cache, a:command)
        let s:has_exec_cache[a:command] = executable(a:command)
    endif
    return s:has_exec_cache[a:command]
endfunction

" Find if given text in sart of line
function! darkvim#util#is_start_of_line(mapping) abort
	let l:text_before_cursor = getline('.')[0 : col('.')-1]
	let l:mapping_pattern = '\V' . escape(a:mapping, '\')
	let l:comment_pattern = '\V' . escape(substitute(&l:commentstring,
				\ '%s.*$', '', ''), '\')
	return (l:text_before_cursor =~? '^' . ('\v(' . l:comment_pattern . '\v)?') .
				\ '\s*\v' . l:mapping_pattern . '\v$')
endfunction


