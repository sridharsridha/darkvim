" tools.vim --- darkvim tools layer

function! darkvim#layers#tools#plugins() abort
	let l:plugins = []

	" Show indent line highlight
	call add(l:plugins, ['nathanaelkane/vim-indent-guides', {
				\ 'on_cmd' : darkvim#util#prefix('IndentGuides', ['Enable', 'Toggle']),
				\ 'loadconf' : 1,
				\ }])

	" Highlight words under cursor
	call add(l:plugins, ['t9md/vim-quickhl' , {
				\ 'on_map' : {'nx' : '<Plug>(quickhl'},
				\ }])

	" Open symbols window
	call add(l:plugins, ['majutsushi/tagbar', {
				\ 'on_cmd' : ['TagbarToggle'],
				\ 'loadconf' : 1,
				\ }])

	" FileTree Explorer
	call add(l:plugins, ['kristijanhusak/defx-icons'])
	call add(l:plugins, ['Shougo/defx.nvim', {
				\ 'depends' : ['defx-icons'],
				\ 'on_cmd' : ['Defx'],
				\ 'loadconf' : 1,
				\ }])

	" Fancy start screen
	call add(l:plugins, ['mhinz/vim-startify', {
				\ 'on_cmd' : ['Startify'],
				\ 'loadconf' : 1,
				\ }])

	" Bookmarks
	call add(l:plugins, ['MattesGroeger/vim-bookmarks', {
				\ 'on_cmd' : darkvim#util#prefix('Bookmark',
				\                ['ShowAll', 'Toggle', 'Annotate', 'Next', 'Prev']),
				\ 'loadconf' : 1,
				\ }])

	" Capture command output to a buffer
	call add(l:plugins, ['tyru/capture.vim', {
				\ 'on_cmd' : ['Capture'],
				\ }])

	" Profile startuptime
	call add(l:plugins, ['tweekmonster/startuptime.vim', {
				\ 'on_cmd' : ['StartupTime'],
				\ }])

	" info window
	call add(l:plugins, ['mcchrish/info-window.nvim', {
				\ 'on_cmd': ['InfoWindowToggle'],
				\ 'on_func': ['infowindow#toggle'],
				\ }])

	" Cheat
	call add(l:plugins, ['dbeniamine/cheat.sh-vim', {
				\ 'name': 'cheat_sheet',
				\ 'on_func': ['cheat#cheat'],
				\ }])

	" Grammer checker
	call add(l:plugins, ['rhysd/vim-grammarous', {
				\ 'on_cmd': [ 'GrammarousCheck' ],
				\ }])

	" Scratch window
	call add(l:plugins, ['mtth/scratch.vim', {
				\ 'on_cmd': darkvim#util#prefix('Scratch',
				\              ['', 'Insert', 'Selection', 'Preview']),
				\ }])
	call add(l:plugins, ['chrisbra/NrrwRgn', {
				\ 'on_cmd': ['NUD', 'NR', 'NW']
				\ }])

	" Resize window automatically on switching
	call add(l:plugins, ['justincampbell/vim-eighties', {
				\ 'on_cmd': darkvim#util#prefix('Eighties', ['Disable', 'Enable']),
				\ }])

	return l:plugins
endfunction

function! darkvim#layers#tools#config() abort
	let g:eighties_extra_width = 3
	let g:eighties_bufname_additional_patterns = [
				\ '__Gundo__',
				\ '__Gundo_Preview__',
				\ '__committia_diff__',
				\ '__committia_status__',
				\ 'Vista',
				\ 'Defx',
				\ 'agit',
				\ 'gina-blame',
				\ 'gina-log',
				\ ]
	call darkvim#mapping#space#group(['w'], 'Windows')
	call darkvim#mapping#space#def('nnoremap', ['w', 'a'],
				\ 'EightiesEnable',
				\ 'autoresize-window-on-switching', 1)
	call darkvim#mapping#space#def('nnoremap', ['w', 'A'],
				\ 'EightiesDisable',
				\ 'disable-autoresize-window-on-switching', 1)

	" IndentLine
	call darkvim#mapping#space#group(['h'], 'Highlight')
	call darkvim#mapping#space#def('nnoremap', ['h', 'i'],
				\ 'IndentGuidesToggle',
				\ 'toggle-highlight-indentation-levels', 1)

	" Quickhl
	call darkvim#mapping#space#def('nmap', ['h', 'h'],
				\ '<Plug>(quickhl-manual-this)',
				\ 'highlight-cword', 0, 1)
	call darkvim#mapping#space#def('nmap', ['h', 'r'],
				\ '<Plug>(quickhl-manual-reset)',
				\ 'highlight-reset', 0, 1)
	call darkvim#mapping#space#def('nmap', ['h', 'c'],
				\ '<Plug>(quickhl-manual-clear)',
				\ 'highlight-clear', 0, 1)
	call darkvim#mapping#space#def('nmap', ['h', 't'],
				\ '<Plug>(quickhl-cword-toggle)',
				\ 'highlight-cword-toggle', 0, 1)


	" Tagbar
	call darkvim#mapping#space#group(['o'], 'Open')
	call darkvim#mapping#space#def('nnoremap', ['o', 't'],
				\ 'TagbarToggle',
				\ 'open-tagbar-window', 1)

	" Defx
	call darkvim#mapping#space#group(['o', 'f'], 'FileExplorer')
	call darkvim#mapping#space#def('nnoremap <silent>', ['o', 'f', 'f'],
				\ "Defx -no-toggle -search=`expand('%:p')`
				\ `stridx(expand('%:p'), getcwd()) < 0? expand('%:p:h'): getcwd()`",
				\ 'open-file-tree', 1)
	call darkvim#mapping#space#def('nnoremap', ['o', 'f', 'b'],
				\ "Defx -no-toggle `fnameescape(expand('%:p:h'))`",
				\ 'show-file-tree-at-buffer-dir', 1)
	call darkvim#mapping#space#def('nnoremap', ['o', 'f', 'd'],
				\ 'call call(' . string(function('s:explore_current_dir')) . ', [])',
				\ 'explore-current-directory', 1)

	" Startify
	call darkvim#mapping#space#def('nnoremap', ['o','S'],
				\ 'Startify | doautocmd WinEnter',
				\ 'open-fancy-start-screen', 1)

	" StartupTime profile
	call darkvim#mapping#space#def('nnoremap', ['o', 'p'],
				\ 'StartupTime',
				\ 'profile-startuptime', 1)

	" Alternate files
	call darkvim#mapping#space#group(['j'], 'Jump')
	call darkvim#mapping#space#group(['j', 'a'], 'AlternateFile')
	call darkvim#mapping#space#def('nnoremap', ['j', 'a', 'a'],
				\ 'A',
				\ 'open', 1)
	call darkvim#mapping#space#def('nnoremap', ['j', 'a', 't'],
				\ 'AT',
				\ 'open-new-tab', 1)
	call darkvim#mapping#space#def('nnoremap', ['j', 'a', 'g'],
				\ 'AV',
				\ 'open-vertical-split', 1)
	call darkvim#mapping#space#def('nnoremap', ['j', 'a', 'v'],
				\ 'AS',
				\ 'open-horizontal-split', 1)
	call darkvim#mapping#space#submode('AltFile', 'n', '', ['j', 'a', 'n'], 'n',
				\ ':AN<cr>',
				\ 'next-alt-file (enter submode n)')

	call darkvim#mapping#space#def('nnoremap', ['j', 'a', 'A'],
				\ 'IH',
				\ 'open-uc', 1)
	call darkvim#mapping#space#def('nnoremap', ['j', 'a', 'T'],
				\ 'IHT',
				\ 'open-uc-new-tab', 1)
	call darkvim#mapping#space#def('nnoremap', ['j', 'a', 'G'],
				\ 'IHV',
				\ 'open-uc-vertical-split', 1)
	call darkvim#mapping#space#def('nnoremap', ['j', 'a', 'V'],
				\ 'IHS',
				\ 'open-uc-horizontal-split', 1)
	call darkvim#mapping#space#submode('AltFileF', 'n', '', ['j', 'a', 'N'], 'N',
				\ ':IHN<cr>',
				\ 'next-alt-file (enter submode n)')

	" bootmark key binding
	nnoremap <silent> mm :<C-u>BookmarkToggle<Cr>
	nnoremap <silent> mi :<C-u>BookmarkAnnotate<Cr>
	nnoremap <silent> ml :<C-u>BookmarkShowAll<Cr>
	nnoremap <silent> mn :<C-u>BookmarkNext<Cr>
	nnoremap <silent> mp :<C-u>BookmarkPrev<Cr>
	nnoremap <silent> mc :<C-u>BookmarkClear<Cr>
	nnoremap <silent> mx :<C-u>BookmarkClearAll<Cr>
	nnoremap <silent> mkk :<C-u>BookmarkMoveUp<Cr>
	nnoremap <silent> mjj :<C-u>BookmarkMoveDown<Cr>

	" Info window
	let g:infowindow_timeout = 0  " Do not close automatically
	" Toggle info window for current buffer
	nnoremap <silent> <C-g> <cmd>call plugin#info_window#toggle()<CR>

	" Cheatsheet
	let g:CheatSheetFt = 'cheatsheet'
	let g:CheatSheetShowCommentsByDefault = 1
	let g:CheatSheetDefaultSelection = 'line'
	let g:CheatSheetDefaultMode = 0
	let g:CheatSheetIdPath = '/tmp/cht.sh/id' " I hate cookies.
	let g:CheatSheetDoNotMap = 1
	let g:CheatDoNotReplaceKeywordPrg = 1
	call darkvim#mapping#space#group(['C'], 'Cheat')
	call darkvim#mapping#space#def('nnoremap', ['C', 'c'],
				\ 'call cheat#cheat("", getcurpos()[1], getcurpos()[1], 0, 0, "!")',
				\ 'search-current-line-cheat.sh (open-new-win)', 1)
	call darkvim#mapping#space#def('nnoremap', ['C', 'r'],
				\ 'call cheat#cheat("", getcurpos()[1], getcurpos()[1], 0, 1, "!")',
				\ 'search-current-line-cheat.sh (rep-cur-line)', 1)
	call darkvim#mapping#space#def('nnoremap', ['C', 'r'],
				\ 'call cheat#cheat("", getcurpos()[1], getcurpos()[1], 0, 1, "!")',
				\ 'search-current-line-cheat.sh (rep-cur-line)', 1)
	call darkvim#mapping#space#def('nnoremap', ['C', 'e'],
				\ 'call cheat#cheat("", getcurpos()[1], getcurpos()[1], 0, 1, "!")',
				\ 'search-first-error-cheat.sh (open-new-win)', 1)
	call darkvim#mapping#space#def('nnoremap', ['C', 'C'],
				\ 'call cheat#navigate(0, "C")',
				\ 'remove-comments-of-cheat.sh-replacement', 1)

	" Grammarous
	let g:grammarous#info_window_height = 10
	let g:grammarous#info_window_direction = 'botleft'
	let g:grammarous#use_vim_spelllang = 1
	let g:grammarous#move_to_first_error = 1
	let g:grammarous#show_to_first_error = 1
	let g:grammarous#default_comments_only_filetypes = {
				\ '*' : 1,
				\ 'tex': 0,
				\ 'texplain': 0,
				\ 'markdown' : 0,
				\ 'help' : 0
				\ }
	call darkvim#mapping#space#group(['G'], 'Grammar')
	call darkvim#mapping#space#def('nnoremap', ['G', 'g'],
				\ 'GrammarousCheck',
				\ 'start-check-grammar', 1)
	call darkvim#mapping#space#def('nmap', ['G', 'R'],
				\ '<Plug>(grammarous-reset)',
				\ 'reset-last-check-grammar')
	call darkvim#mapping#space#def('nmap', ['G', 'o'],
				\ '<Plug>(grammarous-open-info-window)',
				\ 'open-grammer-check-result-window')
	call darkvim#mapping#space#def('nmap', ['G', 'c'],
				\ '<Plug>(grammarous-close-info-window)',
				\ 'close-grammar-check-result-window')
	call darkvim#mapping#space#def('nmap', ['G', 'n'],
				\ '<Plug>(grammarous-move-to-next-error)',
				\ 'jump-to-next-grammar-check-error')
	call darkvim#mapping#space#def('nmap', ['G', 'N'],
				\ '<Plug>(grammarous-move-to-previous-error)',
				\ 'jump-to-previous-grammar-check-error')
	call darkvim#mapping#space#def('nmap', ['G', 'p'],
				\ '<Plug>(grammarous-move-to-previous-error)',
				\ 'jump-to-previous-grammar-check-error')
	call darkvim#mapping#space#def('nmap', ['G', 'f'],
				\ '<Plug>(grammarous-fixit)<Plug>(grammarous-move-to-next-error)',
				\ 'autofix-current-error-and-jump-to-next')
	call darkvim#mapping#space#def('nmap', ['G', 'r'],
				\ '<Plug>(grammarous-remove-error)<Plug>(grammarous-move-to-next-error)',
				\ 'remove/ignore-current-error-and-jump-to-next')

	" Scratch window
	let g:scratch_autohide = 1
	let g:scratch_filetype = 'markdown'
	let g:scratch_height = 10
	let g:scratch_top = 1
	let g:scratch_horizontal = 1
	let g:scratch_no_mappings = 1
	let g:scratch_persistence_file = g:darkvim_plugin_bundle_dir . '/scratch.md'
	call darkvim#mapping#space#group(['o', 'e'], 'Scratch')
	call darkvim#mapping#space#def('nnoremap', ['o', 'e', 'e'],
				\ 'Scratch',
				\ 'open-scratch-pad', 1)
	call darkvim#mapping#space#def('nnoremap', ['o', 'e', 'p'],
				\ 'ScratchPreview',
				\ 'open-scratch-pad-in-preview-window', 1)

endfunction

let g:_darkvim_autoclose_filetree = 1
function! s:explore_current_dir() abort
	let g:_darkvim_autoclose_filetree = 0
	Defx -no-toggle -no-resume -split=no `getcwd()`
	let g:_darkvim_autoclose_filetree = 1
endfunction

