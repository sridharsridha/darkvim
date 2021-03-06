"=============================================================================
" buffer.vim --- darkvim buffer API
"=============================================================================

""
" @section vim#buffer, api-vim-buffer
" @parentsection api
" @subsection Intro
"
" vim#buffer API provides some basic functions for setting and getting config
" of vim buffer.
"
" @subsection Functions
"
" is_cmdwin()
"
" Check if current windows is command line windows.
"
" open(opt)
"
" Open a new buffer with specifice options, return the buffer number, the {opt}
" is a dict with following keys:
"
"     bufname : the buffer name of the new buffer
"
"     mode: how to open the new buffer, default is vertical topleft split
"
"     initfunc: the function which will be call after creating buffer
"
"     cmd: the ex command which will be run after the new buffer is created


let s:self = {}

if exists('*getcmdwintype')
	function! s:self.is_cmdwin() abort
		return getcmdwintype() !=# ''
	endfunction
else
	function! s:self.is_cmdwin() abort
		return bufname('%') ==# '[Command Line]'
	endfunction
endif

" bufnr needs atleast one argv before patch-8.1.1924 has('patch-8.1.1924')
function! s:self.bufnr(...) abort
	if has('patch-8.1.1924')
		return call('bufnr', a:000)
	else
		if a:0 ==# 0
			return bufnr('%')
		else
			return call('bufnr', a:000)
		endif
	endif
endfunction


function! s:self.bufadd(name) abort
	if exists('*bufadd')
		return bufadd(a:name)
	elseif empty(a:name)
		" create an no-named buffer
		noautocmd 1new
		" bufnr needs atleast one argv before patch-8.1.1924 has('patch-8.1.1924')
		let l:nr = s:self.bufnr()
		setl nobuflisted
		noautocmd q
		return l:nr
	elseif bufexists(a:name)
		return bufnr(a:name)
	else
		exe 'noautocmd 1split ' . a:name
		let l:nr = s:self.bufnr()
		setl nobuflisted
		noautocmd q
		return l:nr
	endif
endfunction

function! s:self.open(opts) abort
	let l:buf = get(a:opts, 'bufname', '')
	let l:mode = get(a:opts, 'mode', 'vertical topleft split')
	let l:Initfunc = get(a:opts, 'initfunc', '')
	let l:cmd = get(a:opts, 'cmd', '')
	if empty(l:buf)
		exe l:mode | enew
	else
		exe l:mode l:buf
	endif
	if !empty(l:Initfunc)
		call call(l:Initfunc, [])
	endif

	if !empty(l:cmd)
		exe l:cmd
	endif
	return bufnr('%')
endfunction


func! s:self.resize(size, ...) abort
	let l:cmd = get(a:000, 0, 'vertical')
	exe l:cmd 'resize' a:size
endf

function! s:self.listed_buffers() abort
	return filter(range(1, bufnr('$')), 'buflisted(v:val)')
endfunction


function! s:self.filter_do(expr) abort
	let l:buffers = range(1, bufnr('$'))
	for l:f_expr in a:expr.expr
		let l:buffers = filter(l:buffers, l:f_expr)
	endfor
	for l:b in l:buffers
		exe printf(a:expr.do, l:b)
	endfor
endfunction

if exists('*nvim_buf_line_count')
	function! s:self.line_count(buf) abort
		return nvim_buf_line_count(a:buf)
	endfunction
elseif has('lua')
	function! s:self.line_count(buf) abort
		" lua numbers are floats, so use float2nr
		return float2nr(luaeval('#vim.buffer(vim.eval("a:buf"))'))
	endfunction
else
	function! s:self.line_count(buf) abort
		return len(getbufline(a:buf, 1, '$'))
	endfunction
endif


" just same as nvim_buf_set_lines
function! s:self.buf_set_lines(buffer, start, end, strict_indexing, replacement) abort
	let l:ma = getbufvar(a:buffer, '&ma')
	call setbufvar(a:buffer,'&ma', 1)
	if exists('*nvim_buf_set_lines')
		call nvim_buf_set_lines(a:buffer, a:start, a:end, a:strict_indexing, a:replacement)
	elseif has('python')
		py import vim
		py import string
		if bufexists(a:buffer)
			py bufnr = int(vim.eval("a:buffer"))
			py start_line = int(vim.eval("a:start"))
			py end_line = int(vim.eval("a:end"))
			py lines = vim.eval("a:replacement")
			py vim.buffers[bufnr][start_line:end_line] = lines
		endif
	elseif has('python3')
		py3 import vim
		py3 import string
		if bufexists(a:buffer)
			py3 bufnr = int(vim.eval("a:buffer"))
			py3 start_line = int(vim.eval("a:start"))
			py3 end_line = int(vim.eval("a:end"))
			py3 lines = vim.eval("a:replacement")
			py3 vim.buffers[bufnr][start_line:end_line] = lines
		endif
	elseif has('lua') && 0
		" @todo add lua support
		lua require("darkvim.api.vim.buffer").buf_set_lines(
					\ vim.eval("a:winid"),
					\ vim.eval("a:start"),
					\ vim.eval("a:end"),
					\ vim.eval("a:replacement")
					\ )
	elseif exists('*setbufline') && exists('*bufload') && 0
		" patch-8.1.0039 deletebufline()
		" patch-8.1.0037 appendbufline()
		" patch-8.0.1039 setbufline()
		" patch-8.1.1610 bufadd() bufload()
		let l:lct = s:self.line_count(a:buffer)
		if a:start > l:lct
			return
		elseif a:start >= 0 && a:end > a:start
			" in vim, setbufline will not load buffer automatically
			" but in neovim, nvim_buf_set_lines will do it.
			" @fixme vim issue #5044
			" https://github.com/vim/vim/issues/5044
			let l:endtext = a:end > l:lct ? [] : getbufline(a:buffer, a:end + 1, '$')
			if !buflisted(a:buffer)
				call bufload(a:buffer)
			endif
			" 0 start end $
			if len(a:replacement) == a:end - a:start
				for l:i in range(a:start, len(a:replacement) + a:start - 1)
					call setbufline(a:buffer, l:i + 1, a:replacement[l:i - a:start])
				endfor
			else
				let l:replacement = a:replacement + l:endtext
				for l:i in range(a:start, len(l:replacement) + a:start - 1)
					call setbufline(a:buffer, l:i + 1, l:replacement[l:i - a:start])
				endfor
			endif
		elseif a:start >= 0 && a:end < 0 && l:lct + a:end > a:start
			call s:self.buf_set_lines(a:buffer, a:start, l:lct + a:end + 1, a:strict_indexing, a:replacement)
		elseif a:start <= 0 && a:end > a:start && a:end < 0 && l:lct + a:start >= 0
			call s:self.buf_set_lines(a:buffer, l:lct + a:start + 1, l:lct + a:end + 1, a:strict_indexing, a:replacement)
		endif
	else
		exe 'b' . a:buffer
		let l:lct = line('$')
		if a:start > l:lct
			return
		elseif a:start >= 0 && a:end > a:start
			let l:endtext = a:end > l:lct ? [] : getline(a:end + 1, '$')
			" 0 start end $
			if len(a:replacement) == a:end - a:start
				for l:i in range(a:start, len(a:replacement) + a:start - 1)
					call setline(l:i + 1, a:replacement[l:i - a:start])
				endfor
			else
				let l:replacement = a:replacement + l:endtext
				for l:i in range(a:start, len(l:replacement) + a:start - 1)
					call setline(l:i + 1, l:replacement[l:i - a:start])
				endfor
			endif
		elseif a:start >= 0 && a:end < 0 && l:lct + a:end > a:start
			call s:self.buf_set_lines(a:buffer, a:start, l:lct + a:end + 1, a:strict_indexing, a:replacement)
		elseif a:start <= 0 && a:end > a:start && a:end < 0 && l:lct + a:start >= 0
			call s:self.buf_set_lines(a:buffer, l:lct + a:start + 1, l:lct + a:end + 1, a:strict_indexing, a:replacement)
		endif
	endif
	call setbufvar(a:buffer,'&ma', l:ma)
endfunction


function! s:self.displayArea() abort
	return [
				\ line('w0'), line('w$')
				\ ]
endfunction


fu! darkvim#api#vim#buffer#get() abort
	return deepcopy(s:self)
endf
