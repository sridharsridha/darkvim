" windows.vim --- mapping window & buffer leader definition file for darkvim
"
" Key mapping guide for s ( windows and buffer leader mapping )
let g:_darkvim_mappings_windows = get(g:, '_darkvim_mappings_windows', {})

function! darkvim#mapping#windows#init()
	let g:_darkvim_mappings_windows = {'name' : 'Windows/Tabs/Buffers'}

	nnoremap  <silent>q :<C-u>call darkvim#mapping#windows#smart_close()<cr>

	call darkvim#mapping#windows#def('nnoremap', ['2'],
				\ 'silent only | vs | wincmd w',
				\ 'layout-double-columns', 1)
	call darkvim#mapping#windows#def('nnoremap', ['3'],
				\ 'silent only | vs | vs | wincmd H',
				\ 'layout-three-columns', 1)
	call darkvim#mapping#windows#def('nnoremap', ['='],
				\ 'wincmd =',
				\ 'balance-windows', 1)
	call darkvim#mapping#windows#def('nnoremap', ['v'],
				\ 'vsplit',
				\ 'vsplit-window', 1)
	call darkvim#mapping#windows#def('nnoremap', ['g'],
				\ 'split',
				\ 'split-window', 1)
	call darkvim#mapping#windows#def('nnoremap', ['o'],
				\ 'only<Space><Bar><Space>doautocmd WinEnter',
				\ 'close-other-windows', 1)
	call darkvim#mapping#windows#def('nnoremap <silent>', ['l'],
				\ 'try | b# | catch | endtry',
				\ 'switch-to-the-last-buffer', 1)
	call darkvim#mapping#windows#def('nnoremap', ['c'],
				\ 'close',
				\ 'close-current-windows', 1)
	call darkvim#mapping#windows#def('nnoremap <silent>', ['+'],
				\ 'call call('.string(function('s:window_toggle_layout')).',[])',
				\ 'window-toggle-layout', 1)
	call darkvim#mapping#windows#def('nnoremap <silent>', ['m'],
				\ 'call call('.string(function('s:window_zoom_toggle')).',[])',
				\ 'zoom-window', 1)
	call darkvim#mapping#windows#def('nnoremap', ['n'],
				\ 'call call('.string(function('s:window_next')).',[])',
				\ 'next-window', 1)
	call darkvim#mapping#windows#def('nnoremap', ['p'],
				\ 'call call('.string(function('s:window_previous')).',[])',
				\ 'previous-window', 1)

	if darkvim#layers#is_loaded('ui')
		call darkvim#mapping#windows#def('nnoremap', ['S'],
					\ "execute eval(\"winnr('$')<=2 ? 'wincmd x' : 'ChooseWinSwap'\")",
					\ 'swap windows', 1)
		call darkvim#mapping#windows#def('nnoremap', ['d'],
					\ 'ChooseWin | close | wincmd w',
					\ 'delete-window-(other-windows)', 1)
	endif

	let g:_darkvim_mappings_windows.b = {'name' : '+Buffers'}
	call darkvim#mapping#windows#def('nnoremap', ['b', 'v'],
				\ 'split +bp',
				\ 'split-previous-buffer', 1)
	call darkvim#mapping#windows#def('nnoremap', ['b', 'g'],
				\ 'vsplit +bp',
				\ 'vsplit-previous-buffer', 1)
	call darkvim#mapping#windows#def('nnoremap', ['b', 'n'],
				\ 'bnext',
				\ 'next-buffer', 1)
	call darkvim#mapping#windows#def('nnoremap', ['b', 'p'],
				\ 'bp',
				\ 'previous-buffer', 1)
	call darkvim#mapping#windows#def('nnoremap', ['b', 'C'],
				\ 'call call('.string(function('s:buffer_clear_all')).', [])',
				\ 'buffer-clear-all', 1)
	call darkvim#mapping#windows#def('nnoremap', ['b', 'x'],
				\ 'call call('.string(function('s:buffer_clear_saved')).', [])',
				\ 'buffer-clear-saved', 1)
	call darkvim#mapping#windows#def('nnoremap', ['b', 'c'],
				\ 'call call('.string(function('s:buffer_close_current')).', [])',
				\ 'buffer-close-current', 1)
	call darkvim#mapping#windows#def('nnoremap', ['b', 'D'],
				\ 'call call('.string(function('s:buffer_delete_force')).', [])',
				\ 'buffer-delete-force', 1)
	call darkvim#mapping#windows#def('nnoremap', ['b', 'e'],
				\ 'call call('.string(function('s:buffer_safe_erase')).', [])',
				\ 'buffer-safe-erase', 1)
	call darkvim#mapping#windows#def('nnoremap', ['b', 'r'],
				\ 'call call('.string(function('s:buffer_safe_revert')).', [])',
				\ 'buffer-safe-revert', 1)
	call darkvim#mapping#windows#def('nnoremap', ['b', 'X'],
				\ 'call call('.string(function('s:buffer_delete_current_file')).', [])',
				\ 'buffer-delete-current-file', 1)
	call darkvim#mapping#windows#def('nnoremap', ['b', 'w'],
				\ 'call call('.string(function('s:buffer_wipe_visible_choosewin')).', [])',
				\ 'buffer-wipe-visible-choosewin', 1)

	if darkvim#layers#is_loaded('ui')
		call darkvim#mapping#windows#def('nnoremap', ['b', 's'],
					\ 'call call('.string(function('s:buffer_swap_choosewin')).', [])',
					\ 'buffer-swap-choosewin', 1)
		call darkvim#mapping#windows#def('nnoremap', ['b', 'm'],
					\ 'call call('.string(function('s:buffer_move_choosewin')).', [])',
					\ 'buffer-move-choosewin', 1)
	endif

	let g:_darkvim_mappings_windows.t = {'name' : '+Tabs'}
	call darkvim#mapping#windows#def('nnoremap', ['t', 't'],
				\ 'tabnew',
				\ 'create-new-tab', 1)
	call darkvim#mapping#windows#def('nnoremap', ['t', 'f'],
				\ 'tabfirst',
				\ 'switch-to-first-tab', 1)
	call darkvim#mapping#windows#def('nnoremap', ['t', 'l'],
				\ 'tablast',
				\ 'switch-to-last-tab', 1)
	call darkvim#mapping#windows#def('nnoremap', ['t', 'n'],
				\ 'tabnext',
				\ 'next-tab', 1)
	call darkvim#mapping#windows#def('nnoremap', ['t', 'p'],
				\ 'tabprevious',
				\ 'previous-tab', 1)

endfunction!

function! darkvim#mapping#windows#def(type, keys, value, desc, ...) abort
	let cmd_type = a:0 > 0 ? a:1 : 0
	let map_visual = a:0 > 1 ? a:2 : 0
	let feedkey_mode = a:type =~# 'nore' ? 'n' : 'm'
	let merged_keys = join(a:keys, '')
	if cmd_type == 1
		" a:value is a command
		let nmap_cmd = ':<C-u>' . a:value . '<CR>'
		let xmap_cmd = ':' . a:value . '<CR>'
	else
		" a:value is a key stream
		let nmap_cmd = a:value
		let xmap_cmd = a:value
	endif

	exe a:type . ' ' . g:darkvim_windows_leader.merged_keys . ' ' .
				\ substitute(nmap_cmd, '|', '\\|', 'g')
	if map_visual
		if a:type ==# 'nnoremap'
			exe 'xnoremap ' . g:darkvim_windows_leader.merged_keysi . ' ' .
						\ substitute(xmap_cmd, '|', '\\|', 'g')
		elseif a:type ==# 'nmap'
			exe 'xmap ' . g:darkvim_windows_leader.merged_keys . ' ' .
						\ substitute(xmap_cmd, '|', '\\|', 'g')
		elseif a:type ==# 'nnoremap <silent>'
			exe 'xnoremap <silent> ' . g:darkvim_windows_leader.merged_keys . ' ' .
						\ substitute(xmap_cmd, '|', '\\|', 'g')
		elseif a:type ==# 'nmap <silent>'
			exe 'xmap <silent> ' . g:darkvim_windows_leader.merged_keys . ' ' .
						\ substitute(xmap_cmd, '|', '\\|', 'g')
		endif
	endif

	call darkvim#mapping#windows#guide(a:keys, a:desc)
endfunction

function! darkvim#mapping#windows#guide(keys, desc) abort
	if len(a:keys) == 3
		let g:_darkvim_mappings_windows[a:keys[0]][a:keys[1]][a:keys[2]] = a:desc
	elseif len(a:keys) == 2
		let g:_darkvim_mappings_windows[a:keys[0]][a:keys[1]] = a:desc
	elseif len(a:keys) == 1
		let g:_darkvim_mappings_windows[a:keys[0]] = a:desc
	else
	endif
endfunction

function! darkvim#mapping#windows#group(keys, desc) abort
	if len(a:keys) == 3
		if !has_key(g:_darkvim_mappings_windows[a:keys[0]][a:keys[1]], a:keys[2] )
			let g:_darkvim_mappings_windows[a:keys[0]][a:keys[1]][a:keys[2]] =
						\ { "name" : '+'.a:desc }
		else
			let tmp_desc =
						\ g:_darkvim_mappings_windows[a:keys[0]][a:keys[1]][a:keys[2]]['name']
			if tmp_desc !~? a:desc
				let g:_darkvim_mappings_windows[a:keys[0]][a:keys[1]][a:keys[2]]["name"] =
							\ tmp_desc.'/'.a:desc }
			endif
		endif
	elseif len(a:keys) == 2
		if !has_key(g:_darkvim_mappings_windows[a:keys[0]], a:keys[1] )
			let g:_darkvim_mappings_windows[a:keys[0]][a:keys[1]] =
						\ { "name" : '+'.a:desc }
		else
			let tmp_desc = g:_darkvim_mappings_windows[a:keys[0]][a:keys[1]]['name']
			if tmp_desc !~? a:desc
				let g:_darkvim_mappings_windows[a:keys[0]][a:keys[1]]["name"] =
							\ tmp_desc.'/'.a:desc
			endif
		endif
	elseif len(a:keys) == 1
		if !has_key(g:_darkvim_mappings_windows, a:keys[0] )
			let g:_darkvim_mappings_windows[a:keys[0]] = { "name" : '+'.a:desc }
		else
			let tmp_desc = g:_darkvim_mappings_windows[a:keys[0]]['name']
			if tmp_desc !~? a:desc
				let g:_darkvim_mappings_windows[a:keys[0]]["name"] = tmp_desc.'/'.a:desc
			endif
		endif
	else
	endif
endfunction

function! darkvim#mapping#windows#smart_close() abort
	let ignorewin = get(g:,'darkvim_smartcloseignorewin',[])
	let ignoreft = get(g:, 'darkvim_smartcloseignoreft',[])
	let win_count = winnr('$')
	let num = win_count
	for i in range(1,win_count)
		if index(ignorewin , bufname(winbufnr(i))) != -1 ||
					\ index(ignoreft, getbufvar(bufname(winbufnr(i)),'&filetype')) != -1
			let num = num - 1
		elseif getbufvar(winbufnr(i),'&buftype') ==# 'quickfix'
			let num = num - 1
		elseif getwinvar(i, '&previewwindow') == 1 && winnr() !=# i
			let num = num - 1
		endif
	endfor
	if num == 1
	else
		quit
	endif
endfunction


function! darkvim#mapping#windows#close_term(...) abort
	let buffers = get(g:, '_darkvim_list_buffers', [])
	let abuf = str2nr(g:_darkvim_termclose_abuf)
	let index = index(buffers, abuf)
	if get(w:, 'shell_layer_win', 0) == 1
		exe 'bd!' . abuf
		" fuck the terminal windows
		if get(w:, 'shell_layer_win', 0) == 1
			close
		endif
		return
	endif
	if index != -1
		if index == 0
			if len(buffers) > 1
				exe 'b' . buffers[1]
				exe 'bd!' . abuf
			else
				exe 'bd! ' . abuf
			endif
		elseif index > 0
			if index + 1 == len(buffers)
				exe 'b' . buffers[index - 1]
				exe 'bd!' . abuf
			else
				exe 'b' . buffers[index + 1]
				exe 'bd!' . abuf
			endif
		endif
	endif
endfunction

function! s:window_clean_zoom_session_file()
	if exists('t:zoom_session_file')
		call delete(t:zoom_session_file)
	endif
endfunction

function! s:window_zoom_session_file()
	if !exists('t:zoom_session_file')
		let t:zoom_session_file = tempname().'_'.tabpagenr()
		if exists('##TabClosed')
			autocmd TabClosed * call s:window_clean_zoom_session_file()
		elseif exists('##TabLeave')
			autocmd TabLeave * call s:window_clean_zoom_session_file()
		end
	endif
	return t:zoom_session_file
endfunction

function! s:window_zoom_toggle()
	if get(t:, 'zoomed', 0)
		let cursor_pos = getpos('.')
		let l:current_buffer = bufnr('')
		exec 'silent! source' s:window_zoom_session_file()
		call setqflist(s:qflist)
		silent! exe 'b'.l:current_buffer
		let t:zoomed = 0
		call setpos('.', cursor_pos)
	else
		" skip if only window
		if len(tabpagebuflist()) == 1
			return
		endif
		let oldsessionoptions = &sessionoptions
		let oldsession = v:this_session
		set sessionoptions-=tabpages
		let s:qflist = getqflist()
		exec 'mksession!' s:window_zoom_session_file()
		wincmd o
		let t:zoomed = 1
		let v:this_session = oldsession
		let &sessionoptions = oldsessionoptions
	endif
endfunction

function! s:window_next() abort
	try
		exe (winnr() + 1 ) . 'wincmd w'
	catch
		exe 1 . 'wincmd w'
	endtry
endfunction

function! s:window_previous() abort
	try
		if winnr() == 1
			exe winnr('$') . 'wincmd w'
		else
			exe (winnr() - 1 ) . 'wincmd w'
		endif
	catch
		exe winnr('$') . 'wincmd w'
	endtry
endfunction

function! s:window_toggle_layout() abort
	if winnr('$') != 2
		let curwin= winnr()
		if curwin == 1
			" try to go down one window
			wincmd j
			let isvert= winnr() != curwin
			wincmd k
		else
			" try to go up one window
			wincmd k
			let isvert= winnr() != curwin
			wincmd j
		endif
		if isvert
			noautocmd windo wincmd H
		else
			noautocmd windo wincmd K
		endif
	else
		if winnr() == 1
			let b = winbufnr(2)
		else
			let b = winbufnr(1)
		endif
		if winwidth(1) == &columns
			only
			vsplit
		else
			only
			split
		endif
		exe 'b'.b
		wincmd w
	endif
endfunction

function! s:buffer_close_current()
	let s:BUFFERS = darkvim#api#import('vim#buffer')
	let buffers = s:BUFFERS.listed_buffers()
	let bn = bufnr('%')
	let f = ''
	if getbufvar(bn, '&modified', 0)
		redraw
		echohl WarningMsg
		if len(a:000) > 0
			let rs = get(a:000, 0)
		else
			echon 'save changes to "' . bufname(bn) . '"?  Yes/No/Cancel'
			let rs = nr2char(getchar())
		endif
		echohl None
		if rs ==? 'y'
			write
		elseif rs ==? 'n'
			let f = '!'
			redraw
			echohl ModeMsg
			echon 'discarded!'
			echohl None
		else
			redraw
			echohl ModeMsg
			echon 'canceled!'
			echohl None
			return
		endif
	endif

	if &buftype ==# 'terminal'
		exe 'bd!'
		return
	endif

	let cmd_close_buf = 'bd' . f
	let index = index(buffers, bn)
	if index != -1
		if index == 0
			if len(buffers) > 1
				exe 'b' . buffers[1]
				exe cmd_close_buf . bn
			else
				exe cmd_close_buf . bn
			endif
		elseif index > 0
			if index + 1 == len(buffers)
				exe 'b' . buffers[index - 1]
				exe cmd_close_buf . bn
			else
				exe 'b' . buffers[index + 1]
				exe cmd_close_buf . bn
			endif
		endif
	endif

endfunction

function! s:buffer_wipe_visible_choosewin() abort
	ChooseWin
	let nr = bufnr('%')
	for i in range(1, winnr('$'))
		if winbufnr(i) == nr
			exe i .  'wincmd w'
			enew
		endif
	endfor
	exe 'bwipeout ' . nr
endfunction

function! s:buffer_clear_saved() abort
	let s:BUFFERS = darkvim#api#import('vim#buffer')
	call s:BUFFER.filter_do(
				\ {
				\ 'expr' : [
				\ 'buflisted(v:val)',
				\ 'index(tabpagebuflist(), v:val) == -1',
				\ 'getbufvar(v:val, "&mod") == 0',
				\ ],
				\ 'do' : 'bd %d'
				\ }
				\ )
endfunction

function! s:buffer_clear_all() abort
	let l:MESSAGE = darkvim#api#import('vim#message')
	if l:MESSAGE.confirm('Kill all other buffers')
		let blisted = filter(range(1, bufnr('$')), 'buflisted(v:val)')
		for i in blisted
			if i != bufnr('%')
				try
					exe 'bw ' . i
				catch
				endtry
			endif
		endfor
	endif
endfunction

function! s:buffer_delete_force() abort
	let l:current = bufnr('%')
	if ! getbufvar(l:current, '&modified')
		enew
		silent! execute 'bdelete! '.l:current
	endif
endfunction


function! s:buffer_safe_erase() abort
	let l:MESSAGE = darkvim#api#import('vim#message')
	if l:MESSAGE.confirm('Erase content of buffer ' . expand('%:t'))
		normal! ggdG
	else
		echo 'canceled!'
	endif
endfunction

function! s:buffer_safe_revert() abort
	let l:MESSAGE = darkvim#api#import('vim#message')
	if l:MESSAGE.confirm('Revert buffer form ' . expand('%:p'))
		edit!
	else
		echo 'canceled!'
	endif
	redraw!
endfunction

function! s:buffer_delete_current_file() abort
	let l:MESSAGE = darkvim#api#import('vim#message')
	if l:MESSAGE.confirm('Are you sure you want to delete this file')
		let f = expand('%')
		if delete(f) == 0
			call s:buffer_close_current('n')
			echo "File '" . f . "' successfully deleted!"
		else
			call l:MESSAGE.warn('Failed to delete file:' . f)
		endif
	endif
endfunction

function! s:buffer_swap_choosewin() abort
	let cb = bufnr('%')
	ChooseWin
	let nr = bufnr('%')
	let tb = winbufnr(nr)
	if cb != tb
		exe nr . 'wincmd w'
		exe 'b' . cb
		wincmd p
		exe 'b' . tb
	endif
endfunction

function! s:buffer_move_choosewin() abort
	let cb = bufnr('%')
	ChooseWin
	let nr = bufnr('%')
	bp
	exe nr . 'wincmd w'
	exe 'b' . cb
	wincmd p
endfunction


