" leader.vim --- mapping leader definition file for darkvim

" Key mapping guide for leader
let g:_darkvim_mappings_leader = get(g:,'_darkvim_mappings_leader', {})

function! darkvim#mapping#leader#init() abort

endfunction

function! darkvim#mapping#leader#def(type, keys, value, desc, ...) abort
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

	exe a:type.' <leader>'.merged_keys.' '.substitute(nmap_cmd, '|', '\\|', 'g')
	if map_visual
		if a:type ==# 'nnoremap'
			exe 'xnoremap <leader>'.merged_keys.' '.substitute(xmap_cmd, '|', '\\|', 'g')
		elseif a:type ==# 'nmap'
			exe 'xmap <leader>'.merged_keys.' ' .substitute(xmap_cmd, '|', '\\|', 'g')
		endif
	endif

	call darkvim#mapping#leader#guide(a:keys, a:desc)
endfunction

function! darkvim#mapping#leader#guide(keys, desc) abort
	if len(a:keys) == 3
		let g:_darkvim_mappings_leader[a:keys[0]][a:keys[1]][a:keys[2]] = a:desc
	elseif len(a:keys) == 2
		let g:_darkvim_mappings_leader[a:keys[0]][a:keys[1]] = a:desc
	elseif len(a:keys) == 1
		let g:_darkvim_mappings_leader[a:keys[0]] = a:desc
	else
	endif
endfunction

function! darkvim#mapping#leader#group(keys, desc) abort
	if len(a:keys) == 3
		if !has_key(g:_darkvim_mappings_leader[a:keys[0]][a:keys[1]], a:keys[2] )
			let g:_darkvim_mappings_leader[a:keys[0]][a:keys[1]][a:keys[2]] = { "name" : '+'.a:desc }
		else
			let tmp_desc = g:_darkvim_mappings_leader[a:keys[0]][a:keys[1]][a:keys[2]]['name']
			if tmp_desc !~? a:desc
				let g:_darkvim_mappings_leader[a:keys[0]][a:keys[1]][a:keys[2]]["name"] = tmp_desc.'/'.a:desc }
			endif
		endif
	elseif len(a:keys) == 2
		if !has_key(g:_darkvim_mappings_leader[a:keys[0]], a:keys[1] )
			let g:_darkvim_mappings_leader[a:keys[0]][a:keys[1]] = { "name" : '+'.a:desc }
		else
			let tmp_desc = g:_darkvim_mappings_leader[a:keys[0]][a:keys[1]]['name']
			if tmp_desc !~? a:desc
				let g:_darkvim_mappings_leader[a:keys[0]][a:keys[1]]["name"] = tmp_desc.'/'.a:desc
			endif
		endif
	elseif len(a:keys) == 1
		if !has_key(g:_darkvim_mappings_leader, a:keys[0] )
			let g:_darkvim_mappings_leader[a:keys[0]] = { "name" : '+'.a:desc }
		else
			let tmp_desc = g:_darkvim_mappings_leader[a:keys[0]]['name']
			if tmp_desc !~? a:desc
				let g:_darkvim_mappings_leader[a:keys[0]]["name"] = tmp_desc.'/'.a:desc
			endif
		endif
	else
	endif
endfunction

