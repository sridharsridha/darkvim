" denite.vim fuzzyfinder layer for darkvim

function! darkvim#layers#denite#plugins() abort
	let plugins = []

	call add(plugins, ['Shougo/denite.nvim', {
				\  'on_cmd':['Denite','DeniteBufferDir','DeniteCursorWord',
				\            'DeniteProjectDir'],
				\  'loadconf':1}])
	call add(plugins, ['Shougo/unite-outline', {
				\ 'on_source':['denite.nvim']}])
	call add(plugins, ['chemzqm/denite-extra', {
				\ 'on_source':['denite.nvim']}])
	call add(plugins, ['Shougo/neoyank.vim', {
				\ 'on_source':['denite.nvim']}])
	call add(plugins, ['notomo/denite-keymap', {
				\ 'on_source':['denite.nvim']}])

	return plugins
endfunction

function! darkvim#layers#denite#config() abort
	" Neomru
	let g:neoyank#file = g:darkvim_plugin_bundle_dir . 'neoyank'

	" Quick access files
	call darkvim#mapping#def('nnoremap <silent><nowait>', '<C-p>',
				\ ':Denite -start-filter file/rec<cr>',
				\ 'files-in-current-working-dir')

	call darkvim#mapping#space#group(['f'], 'FuzzyFinder')

	call darkvim#mapping#space#def('nnoremap', ['f', '<space>'],
				\ 'Denite -resume',
				\ 'resume-denite', 1)

	" Buffers
	call darkvim#mapping#space#def('nnoremap', ['f', 'b'],
				\ 'Denite -default-action=switch -no-start-filter buffer',
				\ 'buffer-list', 1)

	" Files listing
	call darkvim#mapping#space#def('nnoremap', ['f', 'r'],
				\ 'Denite -start-filter file/old',
				\ 'open-recent-list', 1)
	call darkvim#mapping#space#def('nnoremap', ['f', 'f'],
				\ 'DeniteBufferDir -start-filter file/rec',
				\ 'files-in-current-buffer-dir', 1)

	" Directory
	call darkvim#mapping#space#def('nnoremap', ['f', 'd'],
				\ 'DeniteBufferDir -start-filter directory_rec',
				\ 'sub-dirs-in-current-buffer-dir', 1)

	" Register
	call darkvim#mapping#space#def('nnoremap', ['f', 'i'],
				\ 'Denite register',
				\ 'register', 1)
	call darkvim#mapping#space#def('nnoremap', ['f', 'y'],
				\ 'Denite neoyank',
				\ 'yank-history', 1)

	" Lines
	call darkvim#mapping#space#def('nnoremap', ['f', 'l'],
				\ 'Denite -start-filter line',
				\ 'lines', 1)
	call darkvim#mapping#space#def('nnoremap', ['f', 'L'],
				\ 'DeniteCursorWord -start-filter line',
				\ 'lines', 1)

	" Outline
	call darkvim#mapping#space#def('nnoremap', ['f', 'o'],
				\ 'Denite -start-filter outline',
				\ 'outline', 1)

	" Lists
	call darkvim#mapping#space#def('nnoremap', ['f', 'c'],
				\ 'Denite location_list',
				\ 'loc-list', 1)
	call darkvim#mapping#space#def('nnoremap', ['f', 'q'],
				\ 'Denite quickfix',
				\ 'quickfix', 1)
	call darkvim#mapping#space#def('nnoremap', ['f', 'j'],
				\ 'Denite jump',
				\ 'jumplist', 1)
	call darkvim#mapping#space#def('nnoremap', ['f', 'c'],
				\ 'Denite -start-filter change',
				\ 'changelist', 1)

	" Grep
	call darkvim#mapping#space#def('nnoremap', ['f', 's'],
				\ 'DeniteCursorWord -start-filter -no-empty grep',
				\ 'search-cursor-word', 1)
	call darkvim#mapping#space#def('nnoremap', ['f', 'g'],
				\ 'Denite -start-filter -no-empty grep',
				\ 'grep', 1)

	" History
	call darkvim#mapping#space#def('nnoremap', ['f', 'h'],
				\ 'Denite -start-filter -no-empty history',
				\ 'search-history', 1)
	call darkvim#mapping#space#def('nnoremap', ['f', 'H'],
				\ 'Denite -start-filter -no-empty command_history',
				\ 'command-history', 1)

	" Colorscheme
	call darkvim#mapping#space#def('nnoremap', ['f', 'C'],
				\ 'Denite -start-filter colorscheme',
				\ 'colorschemes', 1)

	" Command
	call darkvim#mapping#space#def('nnoremap', ['f', 'x'],
				\ 'Denite -start-filter command',
				\ 'commands', 1)

	" Tags
	call darkvim#mapping#space#def('nnoremap', ['f', 't'],
				\ 'Denite -start-filter tag',
				\ 'tags', 1)
	call darkvim#mapping#space#def('nnoremap', ['f', '?'],
				\ 'Denite -start-filter help',
				\ 'tags', 1)

	" Marks
	call darkvim#mapping#space#def('nnoremap', ['f', 'm'],
				\ 'Denite -start-filter mark',
				\ 'marks', 1)

	" Keymaps
	call darkvim#mapping#space#def('nnoremap', ['f', 'k'],
				\ 'Denite -start-filter keymaps',
				\ 'keymappings', 1)
endfunction

