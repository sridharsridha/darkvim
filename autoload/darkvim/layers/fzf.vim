let s:CMP = darkvim#api#import('vim#compatible')
let s:SYS = darkvim#api#import('system')

function! darkvim#layers#fzf#plugins() abort
	let plugins = []

	" Fzf fuzzy finder support for vim
	call add(plugins, ['junegunn/fzf', {
				\ 'on_func' : ['fzf#wrap', 'fzf#run'],
				\ }])

	" Keep track of most recently used files
	call add(plugins, ['Shougo/neomru.vim', {
				\ 'on_func' : ['neomru#_gather_file_candidates'],
				\ }])

	" Yank list
	call add(plugins, ['Shougo/neoyank.vim'])

	" Fzf yank source
	call add(plugins, ['justinhoward/fzf-neoyank', {
				\ 'depends' : ['neoyank'],
				\ 'on_cmd' : darkvim#util#prefix('FZFNeoyank', ['', 'Selection']),
				\ }])
	return plugins
endfunction

function! darkvim#layers#fzf#config() abort
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
				\ "exe 'FZF ' . fnamemodify(bufname('%'), ':h')",
				\ "files-buf-dir", 1)

	call darkvim#mapping#space#def('nnoremap', ['f', 'i'],
				\ "FzfRegister",
				\ "registers", 1)

	call darkvim#mapping#space#def('nnoremap', ['f', 'j'],
				\ "FzfJumps",
				\ "jumps", 1)

	call darkvim#mapping#space#def('nnoremap', ['f', 'y'],
				\ "FZFNeoyank",
				\ "yanks", 1)

	call darkvim#mapping#space#def('vnoremap', ['f', 'y'],
				\ "FZFNeoyankSelection",
				\ "yanks", 1)

	call darkvim#mapping#space#def('nnoremap', ['f', 'm'],
				\ "FzfMessages",
				\ "messages", 1)

	call darkvim#mapping#space#def('nnoremap', ['f', 'q'],
				\ "FzfQuickfix",
				\ "quickfix", 1)

	call darkvim#mapping#space#def('nnoremap', ['f', 'l'],
				\ "FzfLocationList",
				\ "locationlist", 1)

	call darkvim#mapping#space#def('nnoremap', ['f', 't'],
				\ "FzfTags",
				\ "tags", 1)
endfunction


" Function below is largely lifted directly out of project junegunn/fzf.vim from
" file autoload/fzf/vim.vim ; w/ minor mods to better integrate into darkvim
function! s:wrap(name, opts)
	" fzf#wrap does not append --expect if 'sink' is found
	let opts = copy(a:opts)
	let options = ''
	if has_key(opts, 'options')
		let options = type(opts.options) == v:t_list ? join(opts.options) : opts.options
	endif
	if options !~ '--expect' && has_key(opts, 'sink')
		call remove(opts, 'sink')
		let wrapped = fzf#wrap(a:name, opts)
	else
		let wrapped = fzf#wrap(a:name, opts)
	endif
	return wrapped
endfunction

command! FzfColors call <SID>colors()
function! s:colors() abort
	let s:source = 'colorscheme'
	call fzf#run(fzf#wrap({'source': map(split(globpath(&rtp, 'colors/*.vim')),
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
	let list = split(a:e)
	if len(list) < 4
		return
	endif

	let [linenr, col, file_text] = [list[1], list[2]+1, join(list[3:])]
	let lines = getbufline(file_text, linenr)
	let path = file_text
	if empty(lines)
		if stridx(join(split(getline(linenr))), file_text) == 0
			let lines = [file_text]
			let path = bufname('%')
		elseif filereadable(path)
			let lines = ['buffer unloaded']
		else
			" Skip.
			return
		endif
	endif

	exe 'e '  . path
	call cursor(linenr, col)
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
	let line = a:e
	let filename = fnameescape(split(line, ':\d\+:')[0])
	let linenr = matchstr(line, ':\d\+:')[1:-2]
	let colum = matchstr(line, '\(:\d\+\)\@<=:\d\+:')[1:-2]
	exe 'e ' . filename
	call cursor(linenr, colum)
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
	let line = a:e
	let filename = fnameescape(split(line, ':\d\+:')[0])
	let linenr = matchstr(line, ':\d\+:')[1:-2]
	let colum = matchstr(line, '\(:\d\+\)\@<=:\d\+:')[1:-2]
	exe 'e ' . filename
	call cursor(linenr, colum)
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
	for list in a:lists
		let linenr = list[2][:len(list[2])-3]
		let line = getline(linenr)
		let idx = stridx(line, list[0])
		let len = len(list[0])
		let list[0] = line[:idx-1] . printf("\x1b[%s%sm%s\x1b[m", 34, '', line[idx : idx+len-1]) . line[idx + len :]
	endfor
	for list in a:lists
		call map(list, "printf('%s', v:val)")
	endfor
	return a:lists
endfunction

function! s:outline_source(tag_cmds) abort
	if !filereadable(expand('%'))
		return map(s:outline_format(map([], 'split(v:val, "\t")')), 'join(v:val, "\t")')
	endif

	let lines = []
	for cmd in a:tag_cmds
		let lines = split(system(cmd), "\n")
		if !v:shell_error
			break
		endif
	endfor
	if v:shell_error
		throw get(lines, 0, 'Failed to extract tags')
	elseif empty(lines)
		throw 'No tags found'
	endif
	return map(s:outline_format(map(lines, 'split(v:val, "\t")')), 'join(v:val, "\t")')
endfunction

function! s:outline_sink(lines) abort
	if !empty(a:lines)
		let line = a:lines[0]
		execute split(line, "\t")[2]
	endif
endfunction

function! s:outline(...) abort
	let s:source = 'outline'
	let tag_cmds = [
				\ printf('ctags -f - --sort=no --excmd=number --language-force=%s %s 2>/dev/null', &filetype, expand('%:S')),
				\ printf('ctags -f - --sort=no --excmd=number %s 2>/dev/null', expand('%:S'))]
	return {
				\ 'source':  s:outline_source(tag_cmds),
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
	let gui = has('termguicolors') && &termguicolors
	let fam = gui ? 'gui' : 'cterm'
	let pat = gui ? '^#[a-f0-9]\+' : '^[0-9]\+$'
	for group in a:000
		let code = synIDattr(synIDtrans(hlID(group)), a:attr, fam)
		if code =~? pat
			return code
		endif
	endfor
	return ''
endfunction
function! s:csi(color, fg) abort
	let prefix = a:fg ? '38;' : '48;'
	if a:color[0] ==# '#'
		return prefix.'2;'.join(map([a:color[1:2], a:color[3:4], a:color[5:6]], 'str2nr(v:val, 16)'), ';')
	endif
	return prefix.'5;'.a:color
endfunction

function! s:ansi(str, group, default, ...) abort
	let fg = s:get_color('fg', a:group)
	let bg = s:get_color('bg', a:group)
	let color = s:csi(empty(fg) ? s:ansi[a:default] : fg, 1) .
				\ (empty(bg) ? '' : s:csi(bg, 0))
	return printf("\x1b[%s%sm%s\x1b[m", color, a:0 ? ';1' : '', a:str)
endfunction
for s:color_name in keys(s:ansi)
	execute 'function! s:'.s:color_name."(str, ...)\n"
				\ "  return s:ansi(a:str, get(a:, 1, ''), '".s:color_name."')\n"
				\ 'endfunction'
endfor
function! s:helptag_sink(line) abort
	let [tag, file, path] = split(a:line, "\t")[0:2]
	unlet file
	let rtp = fnamemodify(path, ':p:h:h')
	if stridx(&rtp, rtp) < 0
		execute 'set rtp+='. fnameescape(rtp)
	endif
	execute 'help' tag
endfunction
command! -nargs=? FzfHelpTags call <SID>helptags(<q-args>)
function! s:helptags(...) abort
	let query = get(a:000, 0, '')
	let sorted = sort(split(globpath(&runtimepath, 'doc/tags', 1), '\n'))
	let tags = uniq(sorted)

	if exists('s:helptags_script')
		silent! call delete(s:helptags_script)
	endif
	let s:helptags_script = tempname()
	call writefile(['/('.(s:SYS.isWindows ? '^[A-Z]:\/.*?[^:]' : '.*?').'):(.*?)\t(.*?)\t/; printf(qq('. call('s:green', ['%-40s', 'Label']) . '\t%s\t%s\n), $2, $3, $1)'], s:helptags_script)
	let s:source = 'help'
	call fzf#run(fzf#wrap('helptags', {
				\ 'source':  'grep -H ".*" '.join(map(tags, 'shellescape(v:val)')).
				\ ' | perl -n '. shellescape(s:helptags_script).' | sort',
				\ 'sink':    function('s:helptag_sink'),
				\ 'options': ['--ansi', '--reverse', '+m', '--tiebreak=begin', '--with-nth', '..-2'] + (empty(query) ? [] : ['--query', query]),
				\   'down': '40%'
				\ }))
endfunction

function! s:tags_sink(line) abort
	let parts = split(a:line, '\t\zs')
	let excmd = matchstr(parts[2:], '^.*\ze;"\t')
	execute 'silent e' parts[1][:-2]
	let [magic, &magic] = [&magic, 0]
	execute excmd
	let &magic = magic
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
