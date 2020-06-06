" shell.vim --- darkvim shell layer
let s:default_position = get(g:, 'darkvim_shell_default_position', 'top')
let s:default_height = get(g:, 'darkvim_shell_default_height', 30)

function! darkvim#layers#shell#plugins() abort
	let plugins = []

	call add(plugins,['Shougo/deol.nvim', {
				\ 'on_cmd':['Deol'],
				\ }])

	return plugins
endfunction

function! darkvim#layers#shell#config() abort
	" Deol
	call darkvim#mapping#space#group(['o'], 'Open')
	call darkvim#mapping#space#def('nnoremap', ['o', 's'], 'call call('
				\ . string(function('s:open_default_shell')) . ', [])',
				\ 'open-shell-in-buffer-dir', 1)

	if  exists(':tnoremap') == 2
		" exe 'tnoremap <silent><C-l> <C-\><C-n>:<C-u>wincmd l<CR>'
		" exe 'tnoremap <silent><C-h>  <C-\><C-n>:<C-u>wincmd h<CR>'
		" exe 'tnoremap <silent><C-k>    <C-\><C-n>:<C-u>wincmd k<CR>'
		" exe 'tnoremap <silent><C-j>  <C-\><C-n>:<C-u>wincmd j<CR>'
		" exe 'tnoremap <silent><C-Left> <C-\><C-n>:<C-u>wincmd l<CR>'
		" exe 'tnoremap <silent><C-Right>  <C-\><C-n>:<C-u>wincmd h<CR>'
		" exe 'tnoremap <silent><C-Up>    <C-\><C-n>:<C-u>wincmd k<CR>'
		" exe 'tnoremap <silent><C-Down>  <C-\><C-n>:<C-u>wincmd j<CR>'
		" exe 'tnoremap <silent><M-Left>  <C-\><C-n>:<C-u>bprev<CR>'
		" exe 'tnoremap <silent><M-Right>  <C-\><C-n>:<C-u>bnext<CR>'
		exe 'tnoremap <silent><esc>     <C-\><C-n>'
		exe 'tnoremap <silent>jk        <C-\><C-n>'
	endif
endfunction

" the shell should be cached base on the root of a project, cache the terminal
" buffer id in: s:shell_cached_br
let s:shell_cached_br = {}

let s:open_terminals_buffers = []
" shell windows shoud be toggleable, and can be hide.
function! s:open_default_shell() abort
	let path = expand('%:p:h')
	" look for already opened terminal windows
	let windows = []
	windo call add(windows, winnr())
	for window in windows
		if getwinvar(window, '&buftype') ==# 'terminal'
			exe window .  'wincmd w'
			if getbufvar(winbufnr(window), '_darkvim_shell_cwd') ==# l:path
				" fuck gvim bug, startinsert do not work in gvim
				if has('nvim')
					startinsert
				else
					normal! a
				endif
				return
			else
				" the opened terminal window is not the one we want.
				" close it, we're gonna open a new terminal window with the given l:path
				exe 'wincmd c'
				break
			endif
		endif
	endfor

	" no terminal window found. Open a new window
	let cmd = s:default_position ==# 'top' ?
				\ 'topleft split' :
				\ s:default_position ==# 'bottom' ?
				\ 'botright split' :
				\ s:default_position ==# 'right' ?
				\ 'rightbelow vsplit' : 'leftabove vsplit'
	exe cmd
	let w:shell_layer_win = 1
	let lines = &lines * s:default_height / 100
	if lines < winheight(0) &&
				\ (s:default_position ==# 'top' || s:default_position ==# 'bottom')
		exe 'resize ' . lines
	endif

	for open_terminal in s:open_terminals_buffers
		if bufexists(open_terminal)
			if getbufvar(open_terminal, '_darkvim_shell_cwd') ==# l:path
				exe 'silent b' . open_terminal
				" clear the message
				if has('nvim')
					startinsert
				else
					normal! a
				endif
				return
			endif
		else
			" remove closed buffer from list
			call remove(s:open_terminals_buffers, 0)
		endif
	endfor

	" no terminal window with l:path as cwd has been found, let's open one
	if exists(':terminal')
		if has('nvim')
			let shell = empty($SHELL) ? 'bash' : $SHELL
			enew
			call termopen(shell, {'cwd': l:path})
			if has('nvim')
				stopinsert
				startinsert
			endif
			let s:term_buf_nr = bufnr('%')
			call extend(s:shell_cached_br, {getcwd() : s:term_buf_nr})
		else
			" handle vim terminal
			let shell = empty($SHELL) ? 'bash' : $SHELL
			let s:term_buf_nr = term_start(shell,
						\ {'cwd': l:path, 'curwin' : 1, 'term_finish' : 'close'})
		endif
		call add(s:open_terminals_buffers, s:term_buf_nr)
		let b:_darkvim_shell = shell
		let b:_darkvim_shell_cwd = l:path

		" use WinEnter autocmd to update statusline
		doautocmd WinEnter
		setlocal nobuflisted nonumber norelativenumber

		" use q to hide terminal buffer in vim, if vimcompatible mode is not
		" enabled, and smart quit is on.
		exe 'nnoremap <buffer><silent> q :hide<CR>'
		startinsert
	else
		echo ':terminal is not supported in this version'
	endif
endfunction

function! darkvim#layers#shell#close_terminal() abort
	for terminal_bufnr in s:open_terminals_buffers
		if bufexists(terminal_bufnr)
			exe 'silent bd!' . terminal_bufnr
		endif
	endfor
endfunction

