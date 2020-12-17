" core.vim core plugins for darkvim
scriptencoding utf-8

function! darkvim#layers#core#plugins() abort
	let l:plugins = []

	" Show a help screen for keymap
	call add(l:plugins, [ 'liuchengxu/vim-which-key', {
				\ 'on_cmd' : darkvim#util#prefix('WhichKey', ['', 'Visual', '!', 'Visual!']),
				\ 'loadconf' : 1,
				\ }])

	" Paste without needing to set paste. Needs xterm
	call add(l:plugins, ['ConradIrwin/vim-bracketed-paste', {
				\ 'nolazy' : 1,
				\ }])

	" Match paren
	call add(l:plugins, ['andymass/vim-matchup', {
				\ 'on_event' : ['BufReadPost'],
				\ 'loadconf' : 1,
				\ }])

	" Toggle search highlights automatically
	call add(l:plugins, ['romainl/vim-cool', {
				\ 'on_event' : ['BufReadPost'],
				\ 'loadconf' : 1,
				\ }])

	" Automagic indentation configuration, that just works.
	call add(l:plugins, ['tpope/vim-sleuth', {
				\ 'on_cmd': [ 'Sleuth' ],
				\ }])

	" Highlight jump
	"
	call add(l:plugins, ['deris/vim-shot-f', {
				\ 'on_map' : { 'nxo' : '<Plug>' }
				\ }])

	" copy paste
	call add(l:plugins, ['christoomey/vim-system-copy', {
				\ 'on_map' : { 'n' : [ 'cp', 'cP', 'cv', 'cV'], }
				\ }])

	" [, ], }, { mappings
	" call add(plugins, ['tpope/vim-unimpaired'])

	" Trigger a mode with a keymap and repeat it usign another keymap.
	call add(l:plugins, ['kana/vim-submode', {
				\ 'nolazy' : 1,
				\ }])

	" . operator repeat
	call add(l:plugins, ['tpope/vim-repeat'])

	" Operator global plugin
	call add(l:plugins, ['kana/vim-operator-user'])

	" TextObj globla plugins
	call add(l:plugins, ['kana/vim-textobj-user'])

	" Icons
	call add(l:plugins, ['ryanoasis/vim-devicons'])

	" Multiple cursor support
	call add(l:plugins, ['terryma/vim-multiple-cursors', {
				\ 'on_event' : ['BufReadPost'],
				\ 'loadconf' : 1,
				\ }])

	" Plugin Manager Wrapper
	call add(l:plugins, ['haya14busa/dein-command.vim', {
				\ 'on_cmd' : ['Dein'],
				\ }])

	" Commenter
	call add(l:plugins, ['tyru/caw.vim', {
				\ 'on_map' : {'nvx' : '<Plug>'},
				\ 'loadconf' : 1,
				\ }])

	" Searching for word/cword
	call add(l:plugins, ['mhinz/vim-grepper', {
				\ 'on_map' : {'nxv' : '<plug>(GrepperOperator)'},
				\ 'on_cmd' : ['Grepper'],
				\ 'loadconf' : 1,
				\ }])

	" Interactive replace
	call add(l:plugins, ['brooth/far.vim', {
				\ 'on_cmd': darkvim#util#prefix('F', ['ar', 'arp', '']),
				\ }])

	" Browser helper
	call add(l:plugins, ['tyru/open-browser.vim', {
				\ 'on_cmd' : darkvim#util#prefix('OpenBrowser', ['SmartSearch', '', 'Search']),
				\ 'on_map' : {'nx' : '<Plug>(openbrowser-'},
				\ }])

	" Quickfix
	call add(l:plugins, ['yssl/QFEnter', {
				\ 'on_ft' : ['qf'],
				\ 'loadconf' : 1,
				\ }])
	" call add(l:plugins, ['itchyny/vim-qfedit', {
	"			\ 'on_ft' : ['qf'],
	"			\ }])
	" call add(l:plugins, ['thinca/vim-qfreplace', {
	"			\ 'on_cmd' : ['Qfreplace'],
	"			\ }])

	" Choose window by visual selection
	call add(l:plugins, ['t9md/vim-choosewin', {
				\ 'on_map' : {'ni' : '<Plug>'},
				\ 'on_cmd' : darkvim#util#prefix('ChooseWin', ['', 'Swap']),
				\ 'loadconf' : 1,
				\ }])

	" Whitespace showing
	call add(l:plugins, ['ntpeters/vim-better-whitespace', {
				\ 'on_event' : ['InsertEnter'],
				\ 'loadconf' : 1,
				\ }])

	" Colorscheme
	call add(l:plugins, ['morhetz/gruvbox', {
				\ 'nolazy' : 1,
				\ }])

	return l:plugins
endfunction

function! darkvim#layers#core#config() abort
   let g:which_key_use_floating_win = 1
	" Which-Key toplevel mappings, no guide need for these mappings
	nnoremap <silent> z :<c-u>WhichKey 'z'<CR>
	nnoremap <silent><nowait> g :<c-u>WhichKey 'g'<CR>
	exe 'nnoremap <silent> ' . g:darkvim_windows_leader .
				\ " :<c-u>WhichKey '" . g:darkvim_windows_leader . "'<CR>"
	nnoremap <silent> <leader> :<c-u>WhichKey ','<CR>
	vnoremap <silent> <leader> :<c-u>WhichKeyVisual ','<CR>

	nnoremap <silent> <localleader> :<c-u>WhichKey '\'<CR>
	vnoremap <silent> <localleader> :<c-u>WhichKeyVisual '\'<CR>

	nnoremap <silent> <space> :<c-u>WhichKey '<Space>'<CR>
	vnoremap <silent> <space> :<c-u>WhichKeyVisual '<Space>'<CR>

	" Submode
	let g:submode_always_show_submode = v:false
	let g:submode_keep_leaving_key = v:false
	let g:submode_keyseqs_to_leave = ['<Esc>']
	let g:submode_timeout = v:true
	let g:submode_timeoutlen = 1000

	" Dein command keymapping
	call darkvim#mapping#space#group(['p'], 'PackageManager')
	call darkvim#mapping#space#def('nnoremap', ['p', 'r'],
				\ ':Dein recache-runtimepath<CR>',
				\ 'recache-runtimepath', 0)
	call darkvim#mapping#space#def('nnoremap', ['p', 'i'],
				\ 'Dein install',
				\ 'install-plugins', 1)
	call darkvim#mapping#space#def('nnoremap', ['p', 'c'],
				\ 'Dein clean',
				\ 'clean-plugins', 1)
	call darkvim#mapping#space#def('nnoremap', ['p', 'l'],
				\ 'Dein list',
				\ 'list-plugins', 1)
	call darkvim#mapping#space#def('nnoremap', ['p', 'u'],
				\ 'Dein update',
				\ 'update-plugins', 1)

	" Toggles the comment state of the selected line(s).
	call darkvim#mapping#g#def('nmap', ['c'],
				\ '<plug>(caw:prefix)',
				\ 'comment-prefix', 2, 1)
	nmap <buffer> gcc <Plug>(caw:hatpos:toggle)
	xmap <buffer> gcc <Plug>(caw:hatpos:toggle)

	" Vim-Grepper
	call darkvim#mapping#space#group(['s'], 'Search')
	call darkvim#mapping#g#def('nmap', ['s'],
				\ '<plug>(GrepperOperator)',
				\ 'grep-selection', 2, 1)
	call darkvim#mapping#space#def('nnoremap', ['s', 's'],
				\ 'Grepper',
				\ 'search-in-project', 1)
	call darkvim#mapping#space#def('nnoremap', ['s', 'S'],
				\ 'Grepper -cword -noprompt',
				\ 'search-cwords-in-project', 1)
	call darkvim#mapping#space#def('nnoremap', ['s', 'v'],
				\ 'Grepper -side',
				\ 'search-in-project-vsplit-output', 1)
	call darkvim#mapping#space#def('nnoremap', ['s', 'V'],
				\ 'Grepper -cword -noprompt -side',
				\ 'search-cwords-in-project-vsplit-output', 1)
	call darkvim#mapping#space#def('nnoremap', ['s', 'b'],
				\ 'Grepper -buffers',
				\ 'search-in-buffers', 1)
	call darkvim#mapping#space#def('nnoremap', ['s', 'b'],
				\ 'Grepper -buffers -cword --nopromt',
				\ 'search-cword-in-buffers', 1)
	command! Todo Grepper -noprompt -tool git -query -E '(TODO|FIXME|XXX):'

	" Open browser
	call darkvim#mapping#g#def('nmap', ['x'],
				\ '<plug>(openbrowser-smart-search)',
				\ 'browser-smart-search-operator', 0, 1)

	" disable default key mappings for vim-shot-f
	let g:shot_f_no_default_key_mappings = 1
	nmap f  <Plug>(shot-f-f)
	nmap F  <Plug>(shot-f-F)
	nmap t  <Plug>(shot-f-t)
	nmap T  <Plug>(shot-f-T)
	xmap f  <Plug>(shot-f-f)
	xmap F  <Plug>(shot-f-F)
	xmap t  <Plug>(shot-f-t)
	xmap T  <Plug>(shot-f-T)
	omap f  <Plug>(shot-f-f)
	omap F  <Plug>(shot-f-F)
	omap t  <Plug>(shot-f-t)
	omap T  <Plug>(shot-f-T)

endfunction

