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
