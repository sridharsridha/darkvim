
function! darkvim#layers#lang#qf#plugins() abort
	let l:plugins = []

	" call add(plugins, ['romainl/vim-qf', {
	" \ 'on_ft' : 'qf',
	" \ 'on_func' : 'qf#OpenQuickfix'}])
	call add(l:plugins, ['romainl/vim-qf'])

	return l:plugins
endfunction

function! darkvim#layers#lang#qf#config() abort
	let g:qf_max_height = 20
	let g:qf_auto_open_quickfix = 1
	let g:qf_auto_open_loclist = 1
	let g:qf_auto_resize = 1
	let g:qf_mapping_ack_style = 1

	call darkvim#mapping#space#group(['q'], 'QuickfixList')

	call darkvim#mapping#space#submode('QuikfixN', 'n', 'r', ['q', 'n'], 'n',
				\ '<plug>(qf_qf_next)', 'next-entry')
	call darkvim#mapping#space#submode('QuikfixN', 'n', 'r', ['q', 'p'], 'p',
				\ '<plug>(qf_qf_previous)', 'previous-entry')

	call darkvim#mapping#space#group(['q', 'g'], 'FileGroup')
	call darkvim#mapping#space#submode('QuikfixF', 'n', 'r', ['q', 'g', 'n'], 'n',
				\ '<plug>(qf_next_file)', 'next-file-group')
	call darkvim#mapping#space#submode('QuikfixF', 'n', 'r', ['q', 'g', 'p'], 'p',
				\ '<plug>(qf_previous_file)', 'previous-file-group')

	call darkvim#mapping#space#def('nmap', ['q', 't'], '<Plug>(qf_qf_toggle)', 'toggle-window')
	call darkvim#mapping#space#def('nmap', ['q', 's'], '<Plug>(qf_qf_switch)', 'jump-to-from-quickfix-window')
	call darkvim#mapping#space#def('nnoremap', ['q', 'c'], ':call setqflist([])<CR>', 'clear-quickfix')

	call darkvim#mapping#space#group(['l'], 'LocationList')
	call darkvim#mapping#space#submode('LocationN', 'n', 'r', ['l', 'n'], 'n',
				\ '<plug>(qf_loc_next)', 'next-entry')
	call darkvim#mapping#space#submode('LocationN', 'n', 'r', ['l', 'p'], 'p',
				\ '<plug>(qf_loc_previous)', 'previous-entry')

	call darkvim#mapping#space#group(['l', 'g'], 'FileGroup')
	call darkvim#mapping#space#submode('LocationF', 'n', 'r', ['l', 'g', 'n'], 'n',
				\ '<plug>(qf_next_file)', 'next-file-group')
	call darkvim#mapping#space#submode('LocationF', 'n', 'r', ['l', 'g', 'p'], 'p',
				\ '<plug>(qf_previous_file)', 'previous-file-group')

	call darkvim#mapping#space#def('nmap', ['l', 't'], '<Plug>(qf_loc_toggle)', 'toggle-window')
	call darkvim#mapping#space#def('nmap', ['l', 's'], '<Plug>(qf_qf_switch)', 'jump-to-from-locationlist-window')
	call darkvim#mapping#space#def('nnoremap', ['l', 'c'], ':call setloclist([])<CR>', 'clear-locationlist')

	call darkvim#mapping#localleader#reg_lang_mappings_cb('qf',
				\ function('s:language_specified_mappings'))

endfunction

function! s:language_specified_mappings() abort
	call darkvim#mapping#localleader#def('nnoremap', ['s'], ':SaveList<space>', 'save-list')
	call darkvim#mapping#localleader#def('nnoremap', ['l'], ':LoadList<space>', 'load-saved-list')
	call darkvim#mapping#localleader#def('nnoremap', ['r'], ':Reject<space>', 'reject-entries')
	call darkvim#mapping#localleader#def('nnoremap', ['k'], ':Keep<space>', 'keep-entries')
	call darkvim#mapping#localleader#def('nnoremap', ['d'], ':RemoveList<space>', 'remove-entries')

	call darkvim#mapping#localleader#def('nnoremap', ['R'], 'Restore', 'restore-entries', 1)
	call darkvim#mapping#localleader#def('nnoremap', ['L'], 'ListLists', 'list-lists', 1)
endfunction

