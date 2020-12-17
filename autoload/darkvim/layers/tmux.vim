" tmux.vim tmux layer for darkvim
"
function! darkvim#layers#tmux#plugins() abort
	let l:plugins = []

	" Tmux and vim navigation
	call add(l:plugins, ['christoomey/vim-tmux-navigator', {
				\ 'on_cmd': darkvim#util#prefix('TmuxNavigate', ['Left', 'Down', 'Up', 'Right']),
				\ }])

	" Vim and tmux clipboard sharing
	call add(l:plugins, ['roxma/vim-tmux-clipboard', {
				\ 'nolazy' : 1,
				\ }])

	" Vim and tmux pane common resize command
	call add(l:plugins, ['RyanMillerC/better-vim-tmux-resizer', {
				\ 'on_cmd': darkvim#util#prefix('TmuxResize', ['Left', 'Down', 'Up', 'Right']),
				\ }])

	" tmux config file support
	call add(l:plugins, ['tmux-plugins/vim-tmux', {
				\ 'on_ft' : [ 'tmux' ],
				\ }])

	return l:plugins
endfunction

function! darkvim#layers#tmux#config() abort
	" Disable tmux navigator when zooming the Vim pane
	let g:tmux_navigator_disable_when_zoomed = 1
	let g:tmux_navigator_no_mappings = 1
	nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
	nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
	nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
	nnoremap <silent> <C-l> :TmuxNavigateRight<cr>

	" Diable tmux resizeer default keymapping and lazy load it
	" using commands
	let g:tmux_resizer_no_mappings = 1
	nnoremap <silent> <M-h> :TmuxResizeLeft<cr>
	nnoremap <silent> <M-j> :TmuxResizeDown<cr>
	nnoremap <silent> <M-k> :TmuxResizeUp<cr>
	nnoremap <silent> <M-l> :TmuxResizeRight<cr>
endfunction
