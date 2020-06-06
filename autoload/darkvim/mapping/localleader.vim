" localleader.vim --- mapping buffer specific localleader definition file for darkvim
" We use localleader for buffer only mappings example language specific mappings

" Key mapping guide for localleader
let g:_darkvim_mappings_localleader = get(g:,'_darkvim_mappings_localleader', {})

function! darkvim#mapping#localleader#init() abort

endfunction

function! darkvim#mapping#localleader#def(type, keys, value, desc, ...) abort
	let cmd_type = a:0 > 0 ? a:1 : 0
	let map_visual = a:0 > 1 ? a:2 : 0
	let feedkey_mode = a:type =~# 'nore' ? 'n' : 'm'
	let merged_keys = join(a:keys, '')
	if cmd_type == 1
		" a:value is a command
		let nmap_cmd = ':<C-u>'.a:value.'<CR>'
		let xmap_cmd = ':'.a:value.'<CR>'
	else
		" a:value is a key stream
		let nmap_cmd = a:value
		let xmap_cmd = a:value
	endif

	exe a:type.' <buffer> <localleader>'.merged_keys.' '.substitute(nmap_cmd, '|', '\\|', 'g')
	if map_visual
		if a:type ==# 'nnoremap'
			exe 'xnoremap <buffer> <localleader>'.merged_keys.' '.substitute(xmap_cmd, '|', '\\|', 'g')
		elseif a:type ==# 'nmap'
			exe 'xmap <buffer> <localleader>'.merged_keys.' ' .substitute(xmap_cmd, '|', '\\|', 'g')
		elseif a:type ==# 'nnoremap <silent>'
			exe 'xnoremap <silent> <buffer> <localleader>'.merged_keys.' '.substitute(xmap_cmd, '|', '\\|', 'g')
		elseif a:type ==# 'nmap <silent>'
			exe 'xmap <silent> <buffer> <localleader>'.merged_keys.' '.substitute(xmap_cmd, '|', '\\|', 'g')
		endif
	endif

	call darkvim#mapping#localleader#guide(a:keys, a:desc)
endfunction

function! darkvim#mapping#localleader#guide(keys, desc) abort
	if len(a:keys) == 3
		let g:_darkvim_mappings_localleader[a:keys[0]][a:keys[1]][a:keys[2]] = a:desc
	elseif len(a:keys) == 2
		let g:_darkvim_mappings_localleader[a:keys[0]][a:keys[1]] = a:desc
	elseif len(a:keys) == 1
		let g:_darkvim_mappings_localleader[a:keys[0]] = a:desc
	else
	endif
endfunction

function! darkvim#mapping#localleader#group(keys, desc) abort
	if len(a:keys) == 3
		if !has_key(g:_darkvim_mappings_localleader[a:keys[0]][a:keys[1]], a:keys[2] )
			let g:_darkvim_mappings_localleader[a:keys[0]][a:keys[1]][a:keys[2]] = { "name" : '+'.a:desc }
		else
			let tmp_desc = g:_darkvim_mappings_localleader[a:keys[0]][a:keys[1]][a:keys[2]]['name']
			if tmp_desc !~? a:desc
				let g:_darkvim_mappings_localleader[a:keys[0]][a:keys[1]][a:keys[2]]["name"] = tmp_desc.'/'.a:desc }
			endif
		endif
	elseif len(a:keys) == 2
		if !has_key(g:_darkvim_mappings_localleader[a:keys[0]], a:keys[1] )
			let g:_darkvim_mappings_localleader[a:keys[0]][a:keys[1]] = { "name" : '+'.a:desc }
		else
			let tmp_desc = g:_darkvim_mappings_localleader[a:keys[0]][a:keys[1]]['name']
			if tmp_desc !~? a:desc
				let g:_darkvim_mappings_localleader[a:keys[0]][a:keys[1]]["name"] = tmp_desc.'/'.a:desc
			endif
		endif
	elseif len(a:keys) == 1
		if !has_key(g:_darkvim_mappings_localleader, a:keys[0] )
			let g:_darkvim_mappings_localleader[a:keys[0]] = { "name" : '+'.a:desc }
		else
			let tmp_desc = g:_darkvim_mappings_localleader[a:keys[0]]['name']
			if tmp_desc !~? a:desc
				let g:_darkvim_mappings_localleader[a:keys[0]]["name"] = tmp_desc.'/'.a:desc
			endif
		endif
	else
	endif
endfunction

let g:language_specified_mappings = get(g:, 'language_specified_mappings', {})
function! darkvim#mapping#localleader#refresh_lang_mappings() abort
	let ftype = &filetype
	let g:_darkvim_mappings_localleader = {}
	let g:_darkvim_mappings_localleader = {'name' : 'LanguageSpecific'}
	if !empty(ftype) && has_key(g:language_specified_mappings, ftype)
		call call(g:language_specified_mappings[ftype], [])
	endif
endfunction

function! darkvim#mapping#localleader#reg_lang_mappings_cb(ft, func) abort
	call extend(g:language_specified_mappings, {a:ft : a:func})
endfunction

