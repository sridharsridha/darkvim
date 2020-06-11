let s:CMP = darkvim#api#import('vim#compatible')
let s:SYS = darkvim#api#import('system')

function! darkvim#layers#fzf#plugins() abort
	let l:plugins = []

	" Fzf fuzzy finder support for vim
	call add(l:plugins, ['junegunn/fzf', {
				\ 'on_func' : ['fzf#wrap', 'fzf#run'],
				\ }])

	" Keep track of most recently used files
	call add(l:plugins, ['Shougo/neomru.vim', {
				\ 'on_func' : ['neomru#_gather_file_candidates'],
				\ }])

	" Yank list
	call add(l:plugins, ['Shougo/neoyank.vim'])

	" Fzf yank source
	call add(l:plugins, ['justinhoward/fzf-neoyank', {
				\ 'depends' : ['neoyank'],
				\ 'on_cmd' : darkvim#util#prefix('FZFNeoyank', ['', 'Selection']),
				\ }])
	return l:plugins
endfunction

function! darkvim#layers#fzf#config() abort
	let g:neomru#file_mru_path=g:darkvim_plugin_bundle_dir . 'neomru/file'
	let g:fzf_action = {
				\ 'ctrl-t': 'tab split',
				\ 'ctrl-g': 'split',
				\ 'ctrl-v': 'vsplit' }
	augroup fzf_layer
		autocmd!
		autocmd FileType fzf setlocal nonumber norelativenumber
		autocmd FileType fzf tnoremap <buffer> <C-j> <Down>
		autocmd FileType fzf tnoremap <buffer> <C-k> <Up>
		autocmd FileType fzf tnoremap <buffer> <Esc> <C-c>
		autocmd FileType fzf tnoremap <buffer> <C-u> <C-w>
	augroup END

	call darkvim#mapping#space#group(['f'], 'FuzzyFinder')
	call darkvim#mapping#space#def('nnoremap', ['f', '?'],
				\ 'exe "FzfHelpTags " . expand("<cword>")',
				\ 'help', 1)
	call darkvim#mapping#space#def('nnoremap', ['f', 'b'],
				\ 'FzfBuffers',
				\ 'buffers', 1)
	call darkvim#mapping#space#def('nnoremap', ['f', 'p'],
				\ 'FzfFiles',
				\ 'files-cwd', 1)
	call darkvim#mapping#space#def('nnoremap', ['f', 'o'],
				\ 'FzfOutline',
				\ 'outline', 1)

	call darkvim#mapping#def('nnoremap <silent><nowait>', '<C-p>',
				\ ':FzfFiles<cr>',
				\ 'files-cwd', 1)

	call darkvim#mapping#space#def('nnoremap', ['f', 'C'],
				\ 'FzfColors',
				\ 'colorschemes', 1)

	call darkvim#mapping#space#def('nnoremap', ['f', 'r'],
				\ 'FzfMru',
				\ 'recent-file', 1)

	call darkvim#mapping#space#def('nnoremap', ['f', 'f'],
				\ 'exe "FZF " . fnamemodify(bufname("%"), ":h")',
				\ 'files-buf-dir', 1)

	call darkvim#mapping#space#def('nnoremap', ['f', 'i'],
				\ 'FzfRegister',
				\ 'registers', 1)

	call darkvim#mapping#space#def('nnoremap', ['f', 'j'],
				\ 'FzfJumps',
				\ 'jumps', 1)

	call darkvim#mapping#space#def('nnoremap', ['f', 'y'],
				\ 'FZFNeoyank',
				\ 'yanks', 1)

	call darkvim#mapping#space#def('vnoremap', ['f', 'y'],
				\ 'FZFNeoyankSelection',
				\ 'yanks', 1)

	call darkvim#mapping#space#def('nnoremap', ['f', 'm'],
				\ 'FzfMessages',
				\ 'messages', 1)

	call darkvim#mapping#space#def('nnoremap', ['f', 'q'],
				\ 'FzfQuickfix',
				\ 'quickfix', 1)

	call darkvim#mapping#space#def('nnoremap', ['f', 'l'],
				\ 'FzfLocationList',
				\ 'locationlist', 1)

	call darkvim#mapping#space#def('nnoremap', ['f', 't'],
				\ 'FzfTags',
				\ 'tags', 1)
endfunction


" Function below is largely lifted directly out of project junegunn/fzf.vim from
" file autoload/fzf/vim.vim ; w/ minor mods to better integrate into darkvim
function! s:wrap(name, opts) abort
	" fzf#wrap does not append --expect if 'sink' is found
	let l:opts = copy(a:opts)
	let l:options = ''
	if has_key(l:opts, 'options')
		let l:options = type(l:opts.options) == v:t_list ? join(l:opts.options) : l:opts.options
	endif
	if l:options !~# '--expect' && has_key(l:opts, 'sink')
		call remove(l:opts, 'sink')
		let l:wrapped = fzf#wrap(a:name, l:opts)
	else
		let l:wrapped = fzf#wrap(a:name, l:opts)
	endif
	return l:wrapped
endfunction

command! FzfColors call <SID>colors()
function! s:colors() abort
	let s:source = 'colorscheme'
	call fzf#run(fzf#wrap({'source': map(split(globpath(&runtimepath, 'colors/*.vim')),
				\               "fnamemodify(v:val, ':t:r')"),
				\ 'sink': 'colo','options': '--reverse',  'down': '40%'}))
endfunction

command! FzfFiles call <SID>files()
function! s:files() abort
	let s:source = 'files'
	call fzf#run(s:wrap('files', {'sink': 'e', 'options': '--reverse', 'down' : '40%'}))
endfunction

let s:source = ''

function! darkvim#layers#fzf#sources() abort

	return s:source

endfunction
command! FzfJumps call <SID>jumps()
function! s:bufopen(e) abort
	let l:list = split(a:e)
	if len(l:list) < 4
		return
	endif

	let [l:linenr, l:col, l:file_text] = [l:list[1], l:list[2]+1, join(l:list[3:])]
	let l:lines = getbufline(l:file_text, l:linenr)
	let l:path = l:file_text
	if empty(l:lines)
		if stridx(join(split(getline(l:linenr))), l:file_text) == 0
			let l:lines = [l:file_text]
			let l:path = bufname('%')
		elseif filereadable(l:path)
			let l:lines = ['buffer unloaded']
		else
			" Skip.
			return
		endif
	endif

	exe 'e '  . l:path
	call cursor(l:linenr, l:col)
endfunction
function! s:jumps() abort
	let s:source = 'jumps'
	function! s:jumplist() abort
		return split(s:CMP.execute('jumps'), '\n')[1:]
	endfunction
	call fzf#run(fzf#wrap('jumps', {
				\   'source':  reverse(<sid>jumplist()),
				\   'sink':    function('s:bufopen'),
				\   'options': '+m',
				\   'down':    len(<sid>jumplist()) + 2
				\ }))
endfunction

command! FzfMessages call <SID>message()
function! s:yankmessage(e) abort
	let @" = a:e
	echohl ModeMsg
	echo 'Yanked'
	echohl None
endfunction
function! s:message() abort
	let s:source = 'message'
	function! s:messagelist() abort
		return split(s:CMP.execute('message'), '\n')
	endfunction
	call fzf#run(fzf#wrap('messages', {
				\   'source':  reverse(<sid>messagelist()),
				\   'sink':    function('s:yankmessage'),
				\   'options': '+m',
				\   'down':    len(<sid>messagelist()) + 2
				\ }))
endfunction

command! FzfMru call <SID>file_mru()
function! s:open_file(path) abort
	exe 'e' a:path
endfunction
function! s:file_mru() abort
	let s:source = 'mru'
	function! s:mru_files() abort
		return neomru#_gather_file_candidates()
	endfunction
	call fzf#run(s:wrap('mru', {
				\ 'source':  reverse(<sid>mru_files()),
				\ 'sink':    function('s:open_file'),
				\ 'options': '--reverse',
				\ 'down' : '40%',
				\ }))
endfunction

command! FzfQuickfix call s:quickfix()
function! s:open_quickfix_item(e) abort
	let l:line = a:e
	let l:filename = fnameescape(split(l:line, ':\d\+:')[0])
	let l:linenr = matchstr(l:line, ':\d\+:')[1:-2]
	let l:colum = matchstr(l:line, '\(:\d\+\)\@<=:\d\+:')[1:-2]
	exe 'e ' . l:filename
	call cursor(l:linenr, l:colum)
endfunction
function! s:quickfix_to_grep(v) abort
	return bufname(a:v.bufnr) . ':' . a:v.lnum . ':' . a:v.col . ':' . a:v.text
endfunction
function! s:quickfix() abort
	let s:source = 'quickfix'
	function! s:quickfix_list() abort
		return map(getqflist(), 's:quickfix_to_grep(v:val)')
	endfunction
	call fzf#run(fzf#wrap('quickfix', {
				\ 'source':  reverse(<sid>quickfix_list()),
				\ 'sink':    function('s:open_quickfix_item'),
				\ 'options': '--reverse',
				\ 'down' : '40%',
				\ }))
endfunction
command! FzfLocationList call s:location_list()
function! s:location_list_to_grep(v) abort
	return bufname(a:v.bufnr) . ':' . a:v.lnum . ':' . a:v.col . ':' . a:v.text
endfunction
function! s:open_location_item(e) abort
	let l:line = a:e
	let l:filename = fnameescape(split(l:line, ':\d\+:')[0])
	let l:linenr = matchstr(l:line, ':\d\+:')[1:-2]
	let l:colum = matchstr(l:line, '\(:\d\+\)\@<=:\d\+:')[1:-2]
	exe 'e ' . l:filename
	call cursor(l:linenr, l:colum)
endfunction
function! s:location_list() abort
	let s:source = 'location_list'
	function! s:get_location_list() abort
		return map(getloclist(0), 's:location_list_to_grep(v:val)')
	endfunction
	call fzf#run(fzf#wrap('location_list', {
				\ 'source':  reverse(<sid>get_location_list()),
				\ 'sink':    function('s:open_location_item'),
				\ 'options': '--reverse',
				\ 'down' : '40%',
				\ }))
endfunction


command! -bang FzfOutline call fzf#run(fzf#wrap('outline', s:outline(), <bang>0))
function! s:outline_format(lists) abort
	for l:list in a:lists
		let l:linenr = l:list[2][:len(l:list[2])-3]
		let l:line = getline(l:linenr)
		let l:idx = stridx(l:line, l:list[0])
		let l:len = len(l:list[0])
		let l:list[0] = l:line[:l:idx-1] . printf("\x1b[%s%sm%s\x1b[m", 34, '', l:line[l:idx : l:idx+l:len-1]) . l:line[l:idx + l:len :]
	endfor
	for l:list in a:lists
		call map(l:list, "printf('%s', v:val)")
	endfor
	return a:lists
endfunction

function! s:outline_source(tag_cmds) abort
	if !filereadable(expand('%'))
		return map(s:outline_format(map([], 'split(v:val, "\t")')), 'join(v:val, "\t")')
	endif

	let l:lines = []
	for l:cmd in a:tag_cmds
		let l:lines = split(system(l:cmd), "\n")
		if !v:shell_error
			break
		endif
	endfor
	if v:shell_error
		throw get(l:lines, 0, 'Failed to extract tags')
	elseif empty(l:lines)
		throw 'No tags found'
	endif
	return map(s:outline_format(map(l:lines, 'split(v:val, "\t")')), 'join(v:val, "\t")')
endfunction

function! s:outline_sink(lines) abort
	if !empty(a:lines)
		let l:line = a:lines[0]
		execute split(l:line, "\t")[2]
	endif
endfunction

function! s:outline(...) abort
	let s:source = 'outline'
	let l:tag_cmds = [
				\ printf('ctags -f - --sort=no --excmd=number --language-force=%s %s 2>/dev/null', &filetype, expand('%:S')),
				\ printf('ctags -f - --sort=no --excmd=number %s 2>/dev/null', expand('%:S'))]
	return {
				\ 'source':  s:outline_source(l:tag_cmds),
				\ 'sink*':   function('s:outline_sink'),
				\ 'options': '--reverse +m -d "\t" --with-nth 1 -n 1 --ansi --prompt "Outline> "'}
endfunction


command! FzfRegister call <SID>register()
function! s:yankregister(e) abort
	let @" = a:e
	echohl ModeMsg
	echo 'Yanked'
	echohl None
endfunction
function! s:register() abort
	let s:source = 'registers'
	function! s:registers_list() abort
		return split(s:CMP.execute('registers'), '\n')[1:]
	endfunction
	call fzf#run(fzf#wrap('registers', {
				\   'source':  reverse(<sid>registers_list()),
				\   'sink':    function('s:yankregister'),
				\   'options': '+m',
				\   'down': '40%'
				\ }))
endfunction

command! FzfBuffers call <SID>buffers()
function! s:open_buffer(e) abort
	execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction
function! s:buffers() abort
	let s:source = 'buffers'
	function! s:buffer_list() abort
		return split(s:CMP.execute('buffers'), '\n')
	endfunction
	call fzf#run(fzf#wrap('buffers', {
				\   'source':  reverse(<sid>buffer_list()),
				\   'sink':    function('s:open_buffer'),
				\   'options': '+m',
				\   'down': '40%'
				\ }))
endfunction

let s:ansi = {'black': 30, 'red': 31, 'green': 32, 'yellow': 33, 'blue': 34, 'magenta': 35, 'cyan': 36}

function! s:get_color(attr, ...) abort
	let l:gui = has('termguicolors') && &termguicolors
	let l:fam = l:gui ? 'gui' : 'cterm'
	let l:pat = l:gui ? '^#[a-f0-9]\+' : '^[0-9]\+$'
	for l:group in a:000
		let l:code = synIDattr(synIDtrans(hlID(l:group)), a:attr, l:fam)
		if l:code =~? l:pat
			return l:code
		endif
	endfor
	return ''
endfunction
function! s:csi(color, fg) abort
	let l:prefix = a:fg ? '38;' : '48;'
	if a:color[0] ==# '#'
		return l:prefix.'2;'.join(map([a:color[1:2], a:color[3:4], a:color[5:6]], 'str2nr(v:val, 16)'), ';')
	endif
	return l:prefix.'5;'.a:color
endfunction

function! s:ansi(str, group, default, ...) abort
	let l:fg = s:get_color('fg', a:group)
	let l:bg = s:get_color('bg', a:group)
	let l:color = s:csi(empty(l:fg) ? s:ansi[a:default] : l:fg, 1) .
				\ (empty(l:bg) ? '' : s:csi(l:bg, 0))
	return printf("\x1b[%s%sm%s\x1b[m", l:color, a:0 ? ';1' : '', a:str)
endfunction
for s:color_name in keys(s:ansi)
	execute 'function! s:'.s:color_name."(str, ...)\n"
				\ "  return s:ansi(a:str, get(a:, 1, ''), '".s:color_name."')\n"
				\ 'endfunction'
endfor
function! s:helptag_sink(line) abort
	let [l:tag, l:file, l:path] = split(a:line, "\t")[0:2]
	unlet l:file
	let l:runtimepath = fnamemodify(l:path, ':p:h:h')
	if stridx(&runtimepath, l:runtimepath) < 0
		execute 'set runtimepath+='. fnameescape(l:runtimepath)
	endif
	execute 'help' l:tag
endfunction
command! -nargs=? FzfHelpTags call <SID>helptags(<q-args>)
function! s:helptags(...) abort
	let l:query = get(a:000, 0, '')
	let l:sorted = sort(split(globpath(&runtimepath, 'doc/tags', 1), '\n'))
	let l:tags = uniq(l:sorted)

	if exists('s:helptags_script')
		silent! call delete(s:helptags_script)
	endif
	let s:helptags_script = tempname()
	call writefile(['/('.(s:SYS.isWindows ? '^[A-Z]:\/.*?[^:]' : '.*?').'):(.*?)\t(.*?)\t/; printf(qq('. call('s:green', ['%-40s', 'Label']) . '\t%s\t%s\n), $2, $3, $1)'], s:helptags_script)
	let s:source = 'help'
	call fzf#run(fzf#wrap('helptags', {
				\ 'source':  'grep -H ".*" '.join(map(l:tags, 'shellescape(v:val)')).
				\ ' | perl -n '. shellescape(s:helptags_script).' | sort',
				\ 'sink':    function('s:helptag_sink'),
				\ 'options': ['--ansi', '--reverse', '+m', '--tiebreak=begin', '--with-nth', '..-2'] + (empty(l:query) ? [] : ['--query', l:query]),
				\   'down': '40%'
				\ }))
endfunction

function! s:tags_sink(line) abort
	let l:parts = split(a:line, '\t\zs')
	let l:excmd = matchstr(l:parts[2:], '^.*\ze;"\t')
	execute 'silent e' l:parts[1][:-2]
	let [l:magic, &magic] = [&magic, 0]
	execute l:excmd
	let &magic = l:magic
endfunction

function! s:tags() abort
	if empty(tagfiles())
		echohl WarningMsg
		echom 'Preparing tags'
		echohl None
		call system('ctags -R')
	endif

	call fzf#run({
				\ 'source':  'cat '.join(map(tagfiles(), 'fnamemodify(v:val, ":S")')).
				\            '| grep -v -a ^!',
				\ 'options': '+m -d "\t" --with-nth 1,4.. -n 1 --tiebreak=index --reverse',
				\ 'down':    '40%',
				\ 'sink':    function('s:tags_sink')})
endfunction

command! FzfTags call s:tags()
