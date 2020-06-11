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

	" copy paste
	call add(l:plugins, ['christoomey/vim-system-copy', {
				\ 'on_map' : {
				\    'n' : [ 'cp', 'cP', 'cv', 'cV'],
				\ }
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
	call add(l:plugins, ['scrooloose/nerdcommenter', {
				\ 'on_map' : {'nvx' : '<plug>NERDCommenter'},
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
	call add(l:plugins, ['itchyny/vim-qfedit', {
				\ 'on_ft' : ['qf'],
				\ }])
	call add(l:plugins, ['thinca/vim-qfreplace', {
				\ 'on_cmd' : ['Qfreplace'],
				\ }])

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

	" NerdCommenter
	" Toggles the comment state of the selected line(s). If the topmost selected
	" line is commented, all selected lines are uncommented and vice versa.
	call darkvim#mapping#space#group(['c'], 'Comment')
	call darkvim#mapping#space#def('nmap', ['c', 'l'],
				\ '<Plug>NERDCommenterInvert',
				\ 'toggle-comments', 0, 1)
	call darkvim#mapping#space#def('nmap', ['c', 'L'],
				\ '<Plug>NERDCommenterComment',
				\ 'comment-lines', 0, 1)
	call darkvim#mapping#space#def('nmap', ['c', 'u'],
				\ '<Plug>NERDCommenterUncomment',
				\ 'uncomment-lines', 0, 1)
	call darkvim#mapping#space#def('nmap', ['c', 'v'],
				\ '<Plug>NERDCommenterInvertgv',
				\ 'toggle-visual-comments', 0, 1)
	call darkvim#mapping#space#def('nmap', ['c', 's'],
				\ '<Plug>NERDCommenterSexy',
				\ 'comment-with-sexy-layout', 0, 1)
	call darkvim#mapping#space#def('nmap', ['c', 'Y'],
				\ '<Plug>NERDCommenterYank',
				\ 'yank-and-comment', 0, 1)
	call darkvim#mapping#space#def('nmap', ['c', '$'],
				\ '<Plug>NERDCommenterToEOL',
				\ 'comment-from-cursor-to-end-of-line', 0, 1)
	call darkvim#mapping#space#def('nmap', ['c', 'a'],
				\ '<Plug>NERDCommenterAppend',
				\ 'append-comment-at-end-of-line', 0, 1)

	nnoremap <silent> <Plug>CommentToLine :call <SID>comment_to_line(0)<Cr>
	nnoremap <silent> <Plug>CommentToLineInvert :call <SID>comment_to_line(1)<Cr>
	nnoremap <silent> <Plug>CommentParagraphs :call <SID>comment_paragraphs(0)<Cr>
	nnoremap <silent> <Plug>CommentParagraphsInvert
				\ :call <SID>comment_paragraphs(1)<Cr>

	call darkvim#mapping#space#def('nmap', ['c', 't'],
				\ '<Plug>CommentToLineInvert',
				\ 'toggle-comment-until-line', 0, 1)
	call darkvim#mapping#space#def('nmap', ['c', 'T'],
				\ '<Plug>CommentToLine',
				\ 'comment-until-the-line', 0, 1)
	call darkvim#mapping#space#def('nmap', ['c', 'p'],
				\ '<Plug>CommentParagraphsInvert',
				\ 'toggle-comment-paragraphs', 0, 1)
	call darkvim#mapping#space#def('nmap', ['c', 'P'],
				\ '<Plug>CommentParagraphs',
				\ 'comment-paragraphs', 0, 1)

	" Comment operator
	nnoremap <silent> <Plug>CommentOperator :set operatorfunc=<SID>commentOperator<Cr>g@
	call darkvim#mapping#space#def('nmap', [';'],
				\ '<Plug>CommentOperator',
				\ 'comment-operator', 2)

	" Vim-Grepper
	call darkvim#mapping#space#group(['s'], 'Search')
	call darkvim#mapping#g#def('nmap', ['s'],
				\ '<plug>(GrepperOperator)',
				\ 'grep-selection', 2)
	call darkvim#mapping#g#def('vmap', ['s'],
				\ '<plug>(GrepperOperator)',
				\ 'grep-selection', 2)
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

endfunction

function! s:commentOperator(type, ...) abort
	let l:sel_save = &selection
	let &selection = 'inclusive'
	let l:reg_save = @@

	if a:0  " Invoked from Visual mode, use gv command.
		silent exe 'normal! gv'
		call feedkeys("\<Plug>NERDCommenterComment")
	elseif a:type ==# 'line'
		call feedkeys('`[V`]')
		call feedkeys("\<Plug>NERDCommenterComment")
	else
		call feedkeys('`[v`]')
		call feedkeys("\<Plug>NERDCommenterComment")
	endif

	let &selection = l:sel_save
	let @@ = l:reg_save
	set operatorfunc=
endfunction

function! s:comment_to_line(invert) abort
	let l:input = input('line number: ')
	if empty(l:input)
		return
	endif
	let l:line = str2nr(l:input)
	let l:ex = l:line - line('.')
	if l:ex > 0
		exe 'normal! V'. l:ex .'j'
	elseif l:ex == 0
	else
		exe 'normal! V'. abs(l:ex) .'k'
	endif
	if a:invert
		call feedkeys("\<Plug>NERDCommenterInvert")
	else
		call feedkeys("\<Plug>NERDCommenterComment")
	endif
endfunction

function! s:comment_paragraphs(invert) abort
	if a:invert
		call feedkeys("vip\<Plug>NERDCommenterInvert")
	else
		call feedkeys("vip\<Plug>NERDCommenterComment")
	endif
endfunction

