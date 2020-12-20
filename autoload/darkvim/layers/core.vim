" core.vim core plugins for darkvim
scriptencoding utf-8

function! darkvim#layers#core#plugins() abort
	let l:plugins = []

	" Show a help screen for keymap
	call add(l:plugins, [ 'liuchengxu/vim-which-key', {
				\ 'on_cmd' : darkvim#util#prefix('WhichKey', ['', 'Visual', '!', 'Visual!']),
				\ 'loadconf' : 1,
				\ 'loadconf_before': 1,
				\ }])

	" Paste without needing to set paste. Needs xterm
	call add(l:plugins, ['ConradIrwin/vim-bracketed-paste', {
				\ 'on_event' : ['InsertEnter'],
				\ }])

	" Match paren
	call add(l:plugins, ['andymass/vim-matchup', {
				\ 'on_event' : ['BufReadPost'],
				\ 'loadconf_before': 1,
				\ }])

	" Toggle search highlights automatically
	call add(l:plugins, ['romainl/vim-cool', {
				\ 'on_event' : ['BufReadPost'],
				\ 'loadconf_before' : 1,
				\ }])

	" Automagic indentation configuration, that just works.
	call add(l:plugins, ['tpope/vim-sleuth', {
				\ 'nolazy' : 1,
				\ }])

	" Highlight jump
	call add(l:plugins, ['deris/vim-shot-f', {
				\ 'on_map' : { 'nxo' : '<Plug>' },
				\ 'loadconf' : 1,
				\ 'loadconf_before' : 1,
				\ }])

	" Trigger a mode with a keymap and repeat it using another keymap.
	call add(l:plugins, ['kana/vim-submode', {
				\ 'loadconf_before' : 1,
				\ 'nolazy' : 1,
				\ }])

	" . operator repeat
	call add(l:plugins, ['tpope/vim-repeat'])

	" Context filetype support
	call add(l:plugins, ['Shougo/context_filetype.vim'])

	" Operator global plugin
	call add(l:plugins, ['kana/vim-operator-user'])

	" TextObj globla plugins
	call add(l:plugins, ['kana/vim-textobj-user'])

	" Icons
	call add(l:plugins, ['ryanoasis/vim-devicons', {
				\ 'nolazy' : 1,
				\ }])

	" Multiple cursor support
	call add(l:plugins, ['terryma/vim-multiple-cursors', {
				\ 'on_event' : ['BufReadPost'],
				\ 'loadconf_before' : 1,
				\ }])

	" Capture command output to a buffer
	call add(l:plugins, ['tyru/capture.vim', {
				\ 'on_cmd' : ['Capture'],
				\ }])

	" Plugin Manager Wrapper
	call add(l:plugins, ['haya14busa/dein-command.vim', {
				\ 'on_cmd' : ['Dein'],
				\ 'loadconf_before' : 1,
				\ }])

	" Dein ui
	call add(l:plugins, ['wsdjeg/dein-ui.vim', {
				\ 'on_cmd' : ['DeinUpdate'],
				\ 'loadconf_before' : 1,
				\ }])

	" Commenter
	call add(l:plugins, ['tyru/caw.vim', {
				\ 'on_map' : {'nvx' : '<Plug>'},
				\ 'loadconf_before' : 1,
				\ }])

	" Searching for word/cword
	call add(l:plugins, ['mhinz/vim-grepper', {
				\ 'on_map' : {'nxv' : '<plug>(GrepperOperator)'},
				\ 'on_cmd' : ['Grepper'],
				\ 'loadconf' : 1,
				\ 'loadconf_before' : 1,
				\ }])

	" Interactive replace
	call add(l:plugins, ['brooth/far.vim', {
				\ 'on_cmd': darkvim#util#prefix('F', ['ar', 'arp', '']),
				\ 'loadconf_before' : 1,
				\ }])

	" Browser helper
	call add(l:plugins, ['tyru/open-browser.vim', {
				\ 'on_cmd' : darkvim#util#prefix('OpenBrowser', ['SmartSearch', '', 'Search']),
				\ 'on_map' : {'nx' : '<Plug>(openbrowser-'},
				\ 'loadconf_before' : 1,
				\ }])

	" Quickfix
	call add(l:plugins, ['yssl/QFEnter', {
				\ 'on_ft' : ['qf'],
				\ 'loadconf_before' : 1,
				\ }])

	call add(l:plugins, ['itchyny/vim-qfedit', {
				\ 'on_ft' : ['qf'],
				\ }])

	call add(l:plugins, ['thinca/vim-qfreplace', {
				\ 'on_cmd' : ['Qfreplace'],
				\ 'on_ft' : ['qf'],
				\ }])

	" Choose window by visual selection
	call add(l:plugins, ['t9md/vim-choosewin', {
				\ 'on_map' : {'ni' : '<Plug>'},
				\ 'on_cmd' : darkvim#util#prefix('ChooseWin', ['', 'Swap']),
				\ }])

	" Colorscheme
	call add(l:plugins, ['morhetz/gruvbox', {
				\ 'nolazy' : 1,
				\ }])

	call add(l:plugins, ['altercation/vim-colors-solarized', {
				\ 'nolazy' : 1,
				\ }])

	call add(l:plugins, ['sonph/onehalf', {
				\ 'rtp': 'vim/',
				\ 'nolazy' : 1,
				\ }])

	return l:plugins
endfunction

function! darkvim#layers#core#config() abort

endfunction

