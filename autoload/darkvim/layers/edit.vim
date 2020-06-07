" Improved editing layers for darkvim
"
scriptencoding utf-8

function! darkvim#layers#edit#plugins() abort
	let plugins = []

	" Bullets support
	call add(plugins, ['dkarter/bullets.vim', {
				\ 'on_ft': ['gitcommit', 'txt', 'markdown', 'md', 'config'],
				\ }])

	" Adds bunch of testobjs (quotes, brackets, etc with a, i, A, I, n, l)
	call add(plugins, ['wellle/targets.vim', {
				\ 'nolazy' : 1,
				\ }])

	" textobject 'i/I' for indentation
	call add(plugins, ['kana/vim-textobj-indent', {
				\ 'depends':[ 'vim-textobj-user' ],
				\ 'on_map':{'vo':'<Plug>(textobj-indent-'},
				\ }])

	" textobj 'L' for selecting line
	call add(plugins, ['kana/vim-textobj-line', {
				\ 'depends':[ 'vim-textobj-user' ],
				\ 'on_map':{'vo':'<Plug>(textobj-line-'},
				\ }])

	" textobj 'e' for selection entire text
	" Usefull for bulk copying result operator or clipboard
	call add(plugins, ['kana/vim-textobj-entire', {
				\ 'depends':[ 'vim-textobj-user' ],
				\ 'on_map':{'vo':'<Plug>(textobj-entire-'},
				\ }])

	" textobj 'c/C' for seletin comments
	call add(plugins, ['glts/vim-textobj-comment', {
				\ 'depends':[ 'vim-textobj-user' ],
				\ 'on_map':{'vo':'<Plug>(textobj-comment-'},
				\ }])

	" textobj 'f/F' for selecting functions
	call add(plugins, ['kana/vim-textobj-function', {
				\ 'depends':[ 'vim-textobj-user' ],
				\ 'on_map':{'vo':'<Plug>(textobj-function-'},
				\ }])

	" add/change/del quotes etc around word
	call add(plugins, ['tpope/vim-surround', {
				\ 'depends': 'vim-repeat',
				\ 'on_map': {
				\   'i': ['<C-g>S', '<C-g>s', '<C-s>'],
				\   'n': ['cS', 'cs', 'ds', 'yS', 'ys'],
				\   'x': 'S',
				\ },
				\ }])

	" Improved J
	call add(plugins, ['osyo-manga/vim-jplus', {
				\ 'on_map' : {'n' : '<Plug>(jplus'},
				\ }])

	" Table Mode for writing tables triggered using "||"
	call add(plugins, ['dhruvasagar/vim-table-mode', {
				\ 'on_cmd': darkvim#util#prefix('TableMode', ['Toggle', 'Enable', 'Disable']),
				\ }])

	" Align text motion support gl, gL motion
	call add(plugins, ['tommcdo/vim-lion', {
				\ 'on_map': {'n': ['gl', 'gL']},
				\ }])

	" Convert text into table using delimiters helful for formatting code
	call add(plugins, ['godlygeek/tabular', {
				\ 'on_cmd' : ['Tabularize'],
				\ }])

	" Faster j and k movement
	call add(plugins, ['rhysd/accelerated-jk', {
				\ 'on_map' : {'n' : '<Plug>(accelerated_'}
				\ }])

	" Split and join code
	call add(plugins, ['AndrewRadev/splitjoin.vim', {
				\ 'on_cmd': darkvim#util#prefix('Splitjoin', ['Join', 'Split']),
				\ 'on_map': {'n': ['gJ', 'gS']},
				\ 'loadconf' : 1,
				\ }])

	" Exchange text between two regions
	call add(plugins, ['tommcdo/vim-exchange', {
				\ 'on_map': {
				\   'n': 'cx',
				\   'v': 'X',
				\ },
				\ }])

	" Move an item in a delimiter-separated list left or right
	call add(plugins, ['AndrewRadev/sideways.vim', {
				\ 'on_cmd': darkvim#util#prefix('Sideways', ['Left', 'Right']),
				\ }])

	return plugins
endfunction

function! darkvim#layers#edit#config() abort
	" TextObj Indent
	let g:textobj_indent_no_default_key_mappings=1
	vmap ai <Plug>(textobj-indent-a)
	omap ai <Plug>(textobj-indent-a)
	vmap ii <Plug>(textobj-indent-i)
	omap ii <Plug>(textobj-indent-i)
	vmap aI <Plug>(textobj-indent-same-i)
	omap aI <Plug>(textobj-indent-same-i)
	vmap iI <Plug>(textobj-indent-same-a)
	omap iI <Plug>(textobj-indent-same-a)

	" TextObj Line
	let g:textobj_line_no_default_key_mappings=1
	vmap aL <Plug>(textobj-line-a)
	omap aL <plug>(textobj-line-a)
	vmap iL <Plug>(textobj-line-i)
	omap iL <Plug>(textobj-line-i)

	" TextObj Entire
	let g:textobj_entire_no_default_key_mappings=1
	vmap ae <Plug>(textobj-entire-a)
	omap ae <Plug>(textobj-entire-a)
	vmap ie <Plug>(textobj-entire-i)
	omap ie <Plug>(textobj-entire-i)

	" TextObj Comment
	let g:textobj_comment_no_default_key_mappings = 1
	vmap ac <Plug>(textobj-comment-a)
	omap ac <Plug>(textobj-comment-a)
	vmap ic <Plug>(textobj-comment-i)
	omap ic <Plug>(textobj-comment-i)
	vmap aC <Plug>(textobj-comment-big-a)
	omap aC <Plug>(textobj-comment-big-a)
	vmap iC <Plug>(textobj-comment-big-i)
	omap iC <Plug>(textobj-comment-big-i)

	" TextObj Function
	let g:textobj_function_no_default_key_mappings = 1
	vmap af <Plug>(textobj-function-a)
	omap af <Plug>(textobj-function-a)
	vmap if <Plug>(textobj-function-i)
	omap if <Plug>(textobj-function-i)
	vmap aF <Plug>(textobj-function-A)
	omap aF <Plug>(textobj-function-A)
	vmap iF <Plug>(textobj-function-I)
	omap iF <Plug>(textobj-function-I)

	" Jplus
	nmap <silent> J <Plug>(jplus)
	vmap <silent> J <Plug>(jplus)

	" Table Mode trigger and disabling while in insert mode
	inoreabbrev <expr> <bar><bar>
				\ darkvim#layers#edit#is_start_of_line('\|\|')?
				\ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
	inoreabbrev <expr> __
				\ darkvim#layers#edit#is_start_of_line('__')?
				\ '<c-o>:silent! TableModeDisable<cr>' : '__'

	" Tablular
	call darkvim#mapping#space#group(['x'], 'Text')
	call darkvim#mapping#space#group(['x', 'a'], 'Align')
	call darkvim#mapping#space#def('nnoremap', ['x', 'a', '#'],
				\ 'Tabularize /#',
				\ 'align-region-at-#', 1, 1)
	call darkvim#mapping#space#def('nnoremap', ['x', 'a', '%'],
				\ 'Tabularize /%',
				\ 'align-region-at-%', 1, 1)
	call darkvim#mapping#space#def('nnoremap', ['x', 'a', '&'],
				\ 'Tabularize /&',
				\ 'align-region-at-&', 1, 1)
	call darkvim#mapping#space#def('nnoremap', ['x', 'a', '('],
				\ 'Tabularize /(',
				\ 'align-region-at-(', 1, 1)
	call darkvim#mapping#space#def('nnoremap', ['x', 'a', ')'],
				\ 'Tabularize /)',
				\ 'align-region-at-)', 1, 1)
	call darkvim#mapping#space#def('nnoremap', ['x', 'a', '['],
				\ 'Tabularize /[',
				\ 'align-region-at-[', 1, 1)
	call darkvim#mapping#space#def('nnoremap', ['x', 'a', ']'],
				\ 'Tabularize /]',
				\ 'align-region-at-]', 1, 1)
	call darkvim#mapping#space#def('nnoremap', ['x', 'a', '{'],
				\ 'Tabularize /{',
				\ 'align-region-at-{', 1, 1)
	call darkvim#mapping#space#def('nnoremap', ['x', 'a', '}'],
				\ 'Tabularize /}',
				\ 'align-region-at-}', 1, 1)
	call darkvim#mapping#space#def('nnoremap', ['x', 'a', ','],
				\ 'Tabularize /,',
				\ 'align-region-at-,', 1, 1)
	call darkvim#mapping#space#def('nnoremap', ['x', 'a', '.'],
				\ 'Tabularize /.',
				\ 'align-region-at-.', 1, 1)
	call darkvim#mapping#space#def('nnoremap', ['x', 'a', ':'],
				\ 'Tabularize /:',
				\ 'align-region-at-:', 1, 1)
	call darkvim#mapping#space#def('nnoremap', ['x', 'a', ';'],
				\ 'Tabularize /;',
				\ 'align-region-at-;', 1, 1)
	call darkvim#mapping#space#def('nnoremap', ['x', 'a', '='],
				\ 'Tabularize /===\|<=>\|\(&&\|||\|<<\|>>\|\/\/\)=\|=\~[#?]\?\|=>\|[:+/*!%^=><&|.?-]\?=[#?]\?/l1r1',
				\ 'align-region-at-=', 1, 1)
	call darkvim#mapping#space#def('nnoremap', ['x', 'a', 'o'],
				\ 'Tabularize /&&\|||\|\.\.\|\*\*\|<<\|>>\|\/\/\|[-+*/.%^><&|?]/l1r1',
				\ 'align-region-at-operator, such as +,-,*,/,%,^,etc', 1, 1)
	call darkvim#mapping#space#def('nnoremap', ['x', 'a', '¦'],
				\ 'Tabularize /¦',
				\ 'align-region-at-¦', 1, 1)
	call darkvim#mapping#space#def('nnoremap', ['x', 'a', '<Bar>'],
				\ 'Tabularize /|',
				\ 'align-region-at-|', 1, 1)
	call darkvim#mapping#space#def('nmap', ['x', 'a', '<space>'],
				\ 'Tabularize /\s\ze\S/l0',
				\ 'align-region-at-space', 1, 1)
	call darkvim#mapping#space#def('nnoremap', ['x', 'a', 'r'],
				\ 'call call(' . string(function('s:align_at_regular_expression')) . ',[])',
				\ 'align-region-at-user-specified-regexp', 1)

	" String concatination and spliting mapping
	call darkvim#mapping#space#group(['x', 's'], 'String')
	call darkvim#mapping#space#def('nnoremap', ['x', 's', 'j'],
				\ 'call call(' . string(function('s:string_join_with')) . ',[])',
				\ 'join-string-with', 1)
	call darkvim#mapping#space#def('nnoremap', ['x', 's', 's'],
				\ 'call call(' . string(function('s:string_split')) . ',[0])',
				\ 'split-sexp', 1)
	call darkvim#mapping#space#def('nnoremap', ['x', 's', 'S'],
				\ 'call call(' . string(function('s:string_split')) . ',[])',
				\ 'split-and-add-newline', 1)

	" Sideways
	call darkvim#mapping#space#def('nnoremap', ['x', 's', 'h'],
				\ 'SidewaysLeft',
				\ 'shift-string-left', 1)
	call darkvim#mapping#space#def('nnoremap', ['x', 's', 'l'],
				\ 'SidewaysRight',
				\ 'shift-string-right', 1)

	" Move lines using submode
	call darkvim#mapping#space#group(['x', 'm'], 'Move')
	call darkvim#mapping#space#submode2('TextMoveJ', 'n', '', ['x', 'm', 'j'],
				\ ':normal! ddp<cr>',
				\ 'move-text-down (enter submode j)')
	call darkvim#mapping#space#submode_map('TextMoveJ', 'n', '', 'j',
				\ ':noautocmd silent! m .+1<cr>')
	call darkvim#mapping#space#submode_map('TextMoveJ', 'n', '', 'k',
				\ ':noautocmd silent! m .-2<cr>')

	call darkvim#mapping#space#submode2('TextMoveK', 'n', '', ['x', 'm', 'k'],
				\ ':normal! ddkP<cr>',
				\ 'move-text-up(enter submode k)' )
	call darkvim#mapping#space#submode_map('TextMoveK', 'n', '', 'j',
				\ ':noautocmd silent! m .+1<cr>')
	call darkvim#mapping#space#submode_map('TextMoveK', 'n', '', 'k',
				\ ':noautocmd silent! m .-2<cr>')

	" Duplicate lines
	call darkvim#mapping#space#group(['x', 'd'], 'Duplicate')
	call darkvim#mapping#space#submode2('TextDupJ', 'n', '', ['x', 'd', 'j'],
				\ 'mzyyP`z',
				\ 'duplicate-line-down (enter submode j)')
	call darkvim#mapping#space#submode_map('TextDupJ', 'n', '', 'j',
				\ 'mzyyP`z')
	call darkvim#mapping#space#submode_map('TextDupJ', 'n', '', 'k',
				\ 'mzyyP`zk')
	call darkvim#mapping#space#submode2('TextDupK', 'n', '', ['x', 'd', 'k'],
				\ 'mzyyP`zk',
				\ 'duplicate-line-up (enter submode k)')
	call darkvim#mapping#space#submode_map('TextDupK', 'n', '', 'j',
				\ 'mzyyP`z')
	call darkvim#mapping#space#submode_map('TextDupK', 'n', '', 'k',
				\ 'mzyyP`zk')

	" Accelerated j and k
	nmap <silent>j <Plug>(accelerated_jk_gj)
	nmap <silent>k <Plug>(accelerated_jk_gk)

endfunction

" String Joinning functions
let s:string_info = {
			\ 'vim' : {
			\ 'connect' : '.',
			\ 'line_prefix' : '\',
			\ },
			\ 'java' : {
			\ 'connect' : '+',
			\ 'line_prefix' : '',
			\ },
			\ 'cpp' : {
			\ 'connect' : '+',
			\ 'line_prefix' : '',
			\ },
			\ 'perl' : {
			\ 'connect' : '.',
			\ 'line_prefix' : '\',
			\ },
			\ 'python' : {
			\ 'connect' : '+',
			\ 'line_prefix' : '\',
			\ 'quotes_hi' : ['pythonQuotes']
			\ },
			\ }

function! s:string_join_with() abort
	if s:is_string(line('.'), col('.'))
		let c = col('.')
		let a = 0
		let b = 0
		let _c = c
		while c > 0
			if s:is_string(line('.'), c)
				let c -= 1
			else
				let a = c
				break
			endif
		endwhile
		let c = _c
		while c > 0
			if s:is_string(line('.'), c)
				let c += 1
			else
				let b = c
				break
			endif
		endwhile
		let l:save_register_m = @m
		let line = getline('.')[:a] . join(split(getline('.')[a+1 : b]), '-') .
					\ getline('.')[b :]
		call setline('.', line)
		let @m = l:save_register_m
	endif
endfunction

function! s:string_split(newline) abort
	if s:is_string(line('.'), col('.'))
		let save_cursor = getcurpos()
		let c = col('.')
		let sep = ''
		while c > 0
			if s:is_string(line('.'), c)
				let c -= 1
			else
				if !empty(get(get(s:string_info, &filetype, {}), 'quotes_hi', []))
					let sep = getline('.')[c - 1]
				else
					let sep = getline('.')[c]
				endif
				break
			endif
		endwhile
		let addedtext = a:newline ? "\n" .
					\ get(get(s:string_info, &filetype, {}), 'line_prefix', '') : ''
		let connect = get(get(s:string_info, &filetype, {}), 'connect', '')
		if !empty(connect)
			let connect = ' ' . connect . ' '
		endif
		if a:newline
			let addedtext = addedtext . connect
		else
			let addedtext = connect
		endif
		let save_register_m = @m
		let @m = sep . addedtext . sep
		normal! "mp
		let @m = save_register_m
		if a:newline
			normal! j==
		endif
		call setpos('.', save_cursor)
	endif
endfunction

" @toto add sting highlight for other filetype
let s:string_hi = {
			\ 'c' : 'cCppString',
			\ 'cpp' : 'cCppString',
			\ 'python' : 'pythonString',
			\ }

function! s:is_string(l, c) abort
	return synIDattr(synID(a:l, a:c, 1), 'name') ==
				\ get(s:string_hi, &filetype, &filetype . 'String')
endfunction

function! s:align_at_regular_expression() abort
	let re = input(':Tabularize /')
	if !empty(re)
		exe 'Tabularize /' . re
	else
		normal! :
		echo 'empty input, canceled!'
	endif
endfunction

" quickly enable / disable table mode in insert mode by using || or __ :
function! darkvim#layers#edit#is_start_of_line(mapping)
	let text_before_cursor = getline('.')[0 : col('.')-1]
	let mapping_pattern = '\V' . escape(a:mapping, '\')
	let comment_pattern = '\V' . escape(substitute(&l:commentstring,
				\ '%s.*$', '', ''), '\')
	return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') .
				\ '\s*\v' . mapping_pattern . '\v$')
endfunction


