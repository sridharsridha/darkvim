" mapping.vim --- mapping functions in darkvim
"
scriptencoding utf-8

function! darkvim#mapping#def(type, key, value, desc, ...) abort
	let map_visual = a:0 > 1 ? a:1 : 0
	let cmd = substitute(a:value, '|', '\\|', 'g')
	exe a:type.' '.a:key.' '.cmd
	if map_visual
		if a:type ==# 'nnoremap'
			exe 'xnoremap '.a:key.' '.cmd
		elseif a:type ==# 'nmap'
			exe 'xmap '.a:key.' ' .cmd
		endif
	endif
endfunction

