" Statusline layers for darkvim
scriptencoding utf8

function! darkvim#layers#core#statusline#plugins() abort
	let l:plugins = []

   call add(l:plugins, ['vim-airline/vim-airline', {
				\ 'nolazy' : 1,
				\ }])
	call add(l:plugins, ['vim-airline/vim-airline-themes', {
				\ 'nolazy' : 1,
				\ }])

	return l:plugins
endfunction

function! darkvim#layers#core#statusline#config() abort
	" lightline configuration
	" g:darkvim_colorscheme comes from darkvim.vim
	" let g:lightline = {
	"			\ 'colorscheme': g:darkvim_colorscheme,
	"			\ 'separator' : {
	"			\   'left': '',
	"			\   'right': '',
	"			\ },
	"			\ 'subseparator' : {
	"			\   'left': '',
	"			\   'right': '',
	"			\ },
	"			\ 'tabline_separator' : {
	"			\   'left': '',
	"			\   'right': '',
	"			\ },
	"			\ 'tabline_subseparator' : {
	"			\   'left': '',
	"			\   'right': '',
	"			\ },
	"			\ 'mode_map' : {
	"			\   'n' : 'Normal',
	"			\   'i' : 'Insert',
	"			\   'R' : 'Replace',
	"			\   'v' : 'Visual',
	"			\   'V' : 'V-Line',
	"			\   '\<C-v>' : 'V-Block',
	"			\   'c' : 'Command',
	"			\   's' : 'Select',
	"			\   'S' : 'S-Line',
	"			\   '\<C-s>' : 'S-Block',
	"			\   't' : 'Terminal',
	"			\ },
	"			\ 'active' : {
	"			\   'left' : [
	"			\     ['mode'],
	"			\     ['git_branch', 'git_changes'],
	"			\     ['paste_enabled', 'diff_mode', 'file_name_active', 'tags_status', 'modified',
	"			\      'asyncrun_status', 'read_only'],
	"			\   ],
	"			\   'right' : [
	"			\     ['position'],
	"			\     ['spell'],
	"			\     ['file_format', 'file_type', 'file_encoding'],
	"			\     ['linter_status'],
	"			\   ],
	"			\ },
	"			\ 'inactive' : {
	"			\   'left' : [
	"			\     ['window_number', 'diff_mode', 'file_name_inactive'],
	"			\   ],
	"			\   'right' : [
	"			\     [ 'file_format', 'file_type', 'file_encoding', 'position' ],
	"			\   ],
	"			\ },
	"			\ 'tabline' : {
	"			\   'left': [
	"			\     ['buffers'],
	"			\   ],
	"			\   'right': [
	"			\     ['cwd', 'tabs'],
	"			\   ],
	"			\ },
	"			\ 'tab' : {
	"			\   'active'   : ['tabnum', 'tab_name'],
	"			\   'inactive' : ['tabnum', 'tab_name'],
	"			\ },
	"			\ 'component_expand' : {
	"			\   'cwd'           : 'getcwd',
	"			\   'paste_enabled' : 'darkvim#layers#core#statusline#paste_enabled',
	"			\   'diff_mode'     : 'darkvim#layers#core#statusline#diff_mode',
	"			\   'modified'      : 'darkvim#layers#core#statusline#modified',
	"			\   'read_only'     : 'darkvim#layers#core#statusline#read_only',
	"			\   'linter_status' : 'darkvim#layers#core#statusline#linter_status',
	"			\   'buffers'       : 'lightline#bufferline#buffers',
	"			\  },
	"			\ 'component_function' : {
	"			\   'window_number'         : 'darkvim#layers#core#statusline#window_number',
	"			\   'mode'               : 'darkvim#layers#core#statusline#mode',
	"			\   'git_branch'         : 'darkvim#layers#core#statusline#git_branch',
	"			\   'git_changes'        : 'darkvim#layers#core#statusline#git_changes',
	"			\   'file_name_active'   : 'darkvim#layers#core#statusline#file_name_active',
	"			\   'file_name_inactive' : 'darkvim#layers#core#statusline#file_name_inactive',
	"			\   'tags_status'        : 'darkvim#layers#core#statusline#tags_status',
	"			\   'file_format'        : 'darkvim#layers#core#statusline#file_format',
	"			\   'file_type'          : 'darkvim#layers#core#statusline#file_type',
	"			\   'file_encoding'      : 'darkvim#layers#core#statusline#file_encoding',
	"			\   'spell'              : 'darkvim#layers#core#statusline#spell',
	"			\   'position'           : 'darkvim#layers#core#statusline#position',
	"			\   'asyncrun_status'     : 'darkvim#layers#core#statusline#asyncrun_status',
	"			\ },
	"			\ 'tab_component_function' : {
	"			\  'tab_name' : 'darkvim#layers#core#statusline#tab_name',
	"			\ },
	"			\ 'component_type'   : {
	"			\   'buffers'       : 'tabsel',
	"			\   'paste_enabled' : 'hint',
	"			\   'diff_mode'     : 'hint',
	"			\   'modified'      : 'hint',
	"			\   'read_only'     : 'warning',
	"			\   'linter_status' : 'warning',
	"			\ },
	"			\ 'component_visible_condition' : {
	"			\   'window_number'      : '!empty(darkvim#layers#core#statusline#window_number)',
	"			\   'mode'               : '!empty(darkvim#layers#core#statusline#mode)',
	"			\   'git_branch'         : '!empty(darkvim#layers#core#statusline#git_branch)',
	"			\   'git_changes'        : '!empty(darkvim#layers#core#statusline#git_changes)',
	"			\   'file_name_active'   : '!empty(darkvim#layers#core#statusline#file_name_active)',
	"			\   'file_name_inactive' : '!empty(darkvim#layers#core#statusline#file_name_inactive)',
	"			\   'tags_status'        : '!empty(darkvim#layers#core#statusline#tags_status)',
	"			\   'file_format'        : '!empty(darkvim#layers#core#statusline#file_format)',
	"			\   'file_type'          : '!empty(darkvim#layers#core#statusline#file_type)',
	"			\   'file_encoding'      : '!empty(darkvim#layers#core#statusline#file_encoding)',
	"			\   'spell'              : '!empty(darkvim#layers#core#statusline#spell)',
	"			\   'position'           : '!empty(darkvim#layers#core#statusline#position)',
	"			\   'asyncrun_status'    : '!empty(darkvim#layers#core#statusline#asyncrun_status)',
	"			\ },
	"			\ }
	"
	" " Bufferline configuration
	" let g:lightline#bufferline#modified          = ' '
	" let g:lightline#bufferline#read_only         = ' '
	" let g:lightline#bufferline#unnamed           = 'No Name'
	" let g:lightline#bufferline#show_number       = 2
	" let g:lightline#bufferline#enable_devicons   = 1
	" let g:lightline#bufferline#number_map        = g:darkvim#layers#core#statusline#number_map

	" No need to update lightline aggresively
	" augroup LightlineCustom
	"    au!
	"    autocmd BufWritePost,TextChanged,TextChangedI *
	"             \ if get(g:, 'loaded_lightline', 0) |
	"             \   call lightline#update() |
	"             \ endif
	" augroup END

let g:airline_theme=g:darkvim_colorscheme

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.readonly = ''
let g:airline_symbols.spell = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.maxlinenr= ''
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.paste = 'ρ'
"
" " Short form mode text
let g:airline_mode_map = {
   \ '__' : '-',
   \ 'n'  : 'N',
   \ 'i'  : 'I',
   \ 'R'  : 'R',
   \ 'c'  : 'C',
   \ 'v'  : 'V',
   \ 'V'  : 'V-L',
   \ '' : 'V-B',
   \ 's'  : 'S',
   \ 'S'  : 'S-L',
   \ '' : 'S-B',
   \ 't'  : 'T',
   \ 'ic' : 'IC',
   \ 'ix' : 'IC',
   \ 'ni' : '(I)',
   \ 'no' : 'O-P',
   \ }

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':.'
let g:airline#extensions#tabline#fnamecollapse = 0
let g:airline_highlighting_cache = 1
let g:airline#extensions#tagbar#enabled = 0
let g:airline#extensions#neomake#enabled = 0
let g:airline#extensions#gina#enabled = 0
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#branch#enabled = 0

endfunction

" let g:darkvim#layers#core#statusline#number_map =
"			\ {
"			\   0: '⓿ ', 1: '❶ ', 2: '❷ ', 3: '❸ ', 4: '❹ ',
"			\   5: '❺ ', 6: '❻ ', 7: '❼ ', 8: '❽ ', 9: '❾ '
"			\ }
"
" " Conditions
"
" " Indicates if the current window is medium width.
" " Used to shrink segments content.
" function! darkvim#layers#core#statusline#medium_window() abort
" 	return winwidth(0) < 150
" endfunction
"
" " Indicates if the current window is very narrow.
" " Used to shrink even more content.
" function! darkvim#layers#core#statusline#small_window() abort
" 	return winwidth(0) < 100
" endfunction
"
" " Indicates if the current window is super slim.
" " Used to disable segments in such case.
" function! darkvim#layers#core#statusline#tiny_window() abort
" 	return winwidth(0) < 50
" endfunction
"
" " Indicates if the current window is a special one.
" " Used to differ the segments in such case.
" function! darkvim#layers#core#statusline#special_window() abort
" 	let l:ft = &filetype
" 	let l:bfname = bufname('%')
" 	return
"				\ l:ft ==# 'tagbar' ||
"				\ l:ft ==# 'nerdtree' ||
"				\ l:ft ==# 'undotree' ||
"				\ l:ft ==# 'twiggy' ||
"				\ l:ft ==# 'help' ||
"				\ l:ft ==# 'gitcommit' ||
"				\ l:ft ==# 'denite' ||
"				\ l:ft ==# 'denite-filter' ||
"				\ l:ft ==# 'fzf' ||
"				\ l:ft ==# 'agit' ||
"				\ l:ft ==# 'startify' ||
"				\ l:ft ==# 'snippets' ||
"				\ l:ft ==# 'far_vim' ||
"				\ l:ft ==# 'qf' ||
"				\ l:ft ==# 'ctrlp' ||
"				\ l:ft ==# 'clap' ||
"				\ l:ft ==# 'defx' ||
"				\ l:bfname ==# '__Scratch__' ||
"				\ s:is_location_window(win_getid()) ||
"				\ s:is_diff_window()
" endfunction
"
" " Indicates if the current window is the preview window.
" " Used to differ the segments in such case.
" function! darkvim#layers#core#statusline#preview_window() abort
" 	return &previewwindow
" endfunction
"
" " Utilities
"
" " Take a text and abbreviate it by replacing its middle with a sign.
" " The length will be truncated to a constant length of the given threshold.
" " Nevertheless the length will be slightly shorter, to avoid that only one
" " single character in the middle the cut out.
" " In case the given text is short enough, the original will be returned.
" "
" " Arguments:
" "   text   - the text which will be abbreviated
" "   length - static length for the abbreviation
" function! darkvim#layers#core#statusline#abbreviate(text, length) abort
" 	if strlen(a:text) <= a:length
" 		return a:text
" 	endif
"
" 	let l:buffer     = 2
" 	let l:length     = a:length / 2
" 	let l:text_start = a:text[:(l:length - l:buffer)]
" 	let l:text_end   = a:text[(strlen(a:text) - l:length + l:buffer):]
" 	return l:text_start . '' . l:text_end
" endfunction
"
" " Build a good looking file path representation.
" " The path until the file name gets shorten.
" " Additionally if the window is small, the file name gets abbreviated if it is
" " too long.
" " Is working on the current window and the displayed buffers file.
" function! darkvim#layers#core#statusline#fancy_file_path() abort
" 	let l:path = pathshorten(expand('%:h') . '/')
" 	let l:file_name = expand('%:t')
" 	let l:length = 30 - strlen(l:path)
"
" 	" Short the file name for small windows if a threshold is exceeded.
" 	if darkvim#layers#core#statusline#medium_window()
" 		let l:file_name = darkvim#layers#core#statusline#abbreviate(l:file_name, l:length)
" 	endif
" 	return l:path . l:file_name
" endfunction
"
" " Segment Implementations
"
" " Indicates the current window number.
" function! darkvim#layers#core#statusline#window_number() abort
" 	let l:window_number = winnr()
" 	if has_key(g:darkvim#layers#core#statusline#number_map, l:window_number)
" 		let l:window_number = g:darkvim#layers#core#statusline#number_map[l:window_number]
" 	endif
" 	return ' ' . l:window_number
" endfunction
"
" " The current mode or the name of a special buffer.
" " In case the window is small, only the first character of the modes name is
" " displayed.
" function! darkvim#layers#core#statusline#mode() abort
" 	let l:submode = ''
" 	if exists('*submode#current')
" 		let l:submode = submode#current()
" 	endi
"
" 	let l:ft = &filetype
" 	let l:bfname = bufname('%')
" 	if darkvim#layers#core#statusline#special_window()
" 		return
"					\ l:ft ==# 'tagbar' ? 'Tagbar' :
"					\ l:ft ==# 'nerdtree' ? 'NERDTree' :
"					\ l:ft ==# 'tabman' ? 'TabMan':
"					\ l:ft ==# 'twiggy' ? 'Twiggy':
"					\ l:ft ==# 'help' ? 'Help' :
"					\ l:ft ==# 'gitcommit' ? 'Git Commit' :
"					\ l:ft ==# 'tagbar' ? 'Tagbar' :
"					\ l:ft ==# 'defx' ? 'Defx' :
"					\ l:ft ==# 'fzf' ? 'FZF' :
"					\ l:ft ==# 'clap' ? 'Clap' :
"					\ l:ft ==# 'agit' ? 'Git Log' :
"					\ l:ft ==# 'startify' ? 'Startify' :
"					\ l:ft ==# 'snippets' ? 'Snippet' :
"					\ l:ft ==# 'far' ? 'Find & Replace' :
"					\ l:ft ==# 'denite' ? 'Denite' :
"					\ l:ft ==# 'denite-filter' ? 'Denite Filter' :
"					\ l:ft ==# 'ctrlp' ? 'CtrlP' :
"					\ l:ft ==# 'qf' ? 'Quickfix List' :
"					\ l:bfname ==# '__Scratch__' ? 'Scratch' :
"					\ s:is_location_window(win_getid()) ? 'Location List' :
"					\ s:is_diff_window() ? s:get_diff_window_name() : ''
" 	elseif darkvim#layers#core#statusline#preview_window()
" 		return 'Preview'
" 	elseif !empty(l:submode)
" 		return l:submode
" 	else
" 		let l:mode = lightline#mode()
" 		if darkvim#layers#core#statusline#small_window()
" 			return l:mode[:0]
" 		else
" 			return l:mode
" 		endif
" 	endif
" endfunction
"
" " The name of the git branch.
" " Empty if not being in a git repository, a too narrow window
" " or a special window.
" " The text gets abbreviated, if the window is small.
" function! darkvim#layers#core#statusline#git_branch() abort
" 	if get(g:, 'loaded_gina', 0)
" 		let l:branch_name = gina#component#repo#branch()
" 		if darkvim#layers#core#statusline#tiny_window() ||
"					\ darkvim#layers#core#statusline#special_window() ||
"					\ darkvim#layers#core#statusline#preview_window() ||
"					\ empty(l:branch_name)
" 			return ''
" 		endif
" 		if darkvim#layers#core#statusline#medium_window()
" 			let l:branch_name =
"						\ darkvim#layers#core#statusline#abbreviate(l:branch_name, 25)
" 		endif
" 		return ' ' . l:branch_name
" 	else
" 		return ''
" 	endif
" endfunction
"
" " Indicates how many lines have been added_count, adjusted and deleted.
" " Empty if not being in a git repository, a too narrow window,
" " a special window or the preview window.
" " The indicator for each stat is displayed only if it has a value above zero.
" " For small windows all stats are added to one number and the icons are mixed
" " up.
" " If nothing has been adjusted at all, a check mark shows the state.
" function! darkvim#layers#core#statusline#git_changes() abort
" 	if exists('g:loaded_gitgutter') || exists('g:loaded_signify')
" 		if darkvim#layers#core#statusline#tiny_window() ||
"					\ darkvim#layers#core#statusline#special_window() ||
"					\ darkvim#layers#core#statusline#preview_window() ||
"					\ empty(gina#component#repo#branch())
" 			return ''
" 		endif
"
" 		let [ l:added_count, l:modified_count, l:deleted_count ] = sy#repo#get_stats()
" 		let [ l:added_icon, l:modified_icon, l:deleted_icon ] = split(',,', ',')
"
" 		if l:added_count + l:modified_count + l:deleted_count > 0
" 			if darkvim#layers#core#statusline#small_window()
" 				let l:icons = ''
" 				let l:count = 0
"
" 				let l:icons .= l:added_count > 0 ? l:added_icon : ''
" 				let l:count += l:added_count
"
" 				let l:icons .= l:modified_count > 0 ? l:modified_icon : ''
" 				let l:count += l:modified_count
"
" 				let l:icons .= l:deleted_count > 0 ? l:deleted_icon : ''
" 				let l:count += l:deleted_count
"
" 				return l:icons . ' ' . l:count
" 			else
" 				return (l:added_count > 0 ? l:added_icon . ' ' . l:added_count : '') .
"							\ (l:added_count > 0 && l:modified_count > 0 ? ' ' : '') .
"							\ (l:modified_count > 0 ? l:modified_icon . ' ' . l:modified_count : '') .
"							\ (l:modified_count > 0 && l:deleted_count > 0 ? ' ' : '') .
"							\ (l:deleted_count > 0 ? l:deleted_icon . ' ' . l:deleted_count : '')
" 			endif
" 		else
" 			return ''
" 		endif
" 	else
" 		return ''
" 	endif
" endfunction
"
" " Indicate if the paste mode is enabled.
" " Empty if window is too narrow, it is a special one,
" " the preview window or the paste mode is disabled.
" function! darkvim#layers#core#statusline#paste_enabled() abort
" 	if darkvim#layers#core#statusline#tiny_window() ||
"				\ darkvim#layers#core#statusline#special_window() ||
"				\ darkvim#layers#core#statusline#preview_window() ||
"				\ !&paste
"
" 		return ''
" 	endif
" 	return ''
" endfunction
"
" " Indicate if the window is in diff-mode.
" " Empty if window is too narrow, it is a special one,
" " the preview window or no diff mode is disabled.
" function! darkvim#layers#core#statusline#diff_mode() abort
" 	if darkvim#layers#core#statusline#tiny_window() ||
"				\ darkvim#layers#core#statusline#special_window() ||
"				\ darkvim#layers#core#statusline#preview_window() ||
"				\ !&diff
" 		return ''
" 	endif
" 	return '繁'
" endfunction
"
" " Name of the file for active windows.
" " Empty if window is too narrow or it is a special one.
" " The text gets abbreviated, if the window is small.
" " Shows diff mode window names.
" function! darkvim#layers#core#statusline#file_name_active() abort
" 	if &filetype ==# 'denite' || &filetype ==# 'denite-filter'
" 		return denite#get_status('sources')
" 	elseif darkvim#layers#core#statusline#special_window()
" 		if s:is_diff_window()
" 			return s:get_diff_window_name()
" 		else
" 			return ''
" 		endif
" 	else
" 		return darkvim#layers#core#statusline#fancy_file_path()
" 	endif
" endfunction
"
" " Name of a special buffer.
" " Empty if it is not a special window.
" function! darkvim#layers#core#statusline#file_name_inactive() abort
" 	if darkvim#layers#core#statusline#special_window()
" 		return darkvim#layers#core#statusline#mode()
" 	elseif darkvim#layers#core#statusline#preview_window()
" 		return 'Preview ' . darkvim#layers#core#statusline#fancy_file_path()
" 	else
" 		let l:path = darkvim#layers#core#statusline#fancy_file_path()
" 		let l:modified = darkvim#layers#core#statusline#modified()
" 		return l:path . (len(l:modified) > 0 ? ' ' : '') . l:modified
" 	endif
" endfunction
"
" " Shows the status of the tag generation.
" " Moreover the tag for the current cursor position is displayed if any.
" " Empty if window is too narrow, it is a special one
" " or the preview window.
" " Reduces to the icon only, if the window is small.
" function! darkvim#layers#core#statusline#tags_status() abort
" 	if get(g:, 'loaded_tagbar', 0)
" 		if darkvim#layers#core#statusline#tiny_window() ||
"					\ darkvim#layers#core#statusline#special_window() ||
"					\ darkvim#layers#core#statusline#preview_window()
" 			return ''
" 		endif
"
" 		let l:condition = !darkvim#layers#core#statusline#medium_window()
" 		let l:text      = tagbar#currenttag(' %s', '')
"       if get(g:, 'loaded_gutentags', 0)
"          let l:icon = ' ' . (!empty(gutentags#statusline('a')) ? '羽' : '')
"       else
"          let l:icon = ''
"       endif
"
" 		" Short the file name for small windows if a threshold is exceeded.
" 		if darkvim#layers#core#statusline#medium_window()
" 			let l:text = darkvim#layers#core#statusline#abbreviate(l:text, 25)
" 		endif
" 		return l:icon . (l:condition ? ' ' . l:text : '')
" 	else
" 		return ''
" 	endif
" endfunction
"
" " Indicate if the buffers file has been modified.
" " Empty if window is too narrow, it is a special one,
" " the preview window or the buffer has not been modified.
" function! darkvim#layers#core#statusline#modified() abort
" 	if darkvim#layers#core#statusline#tiny_window() ||
"				\ darkvim#layers#core#statusline#special_window() ||
"				\ darkvim#layers#core#statusline#preview_window() ||
"				\ !&modified
" 		return ''
" 	endif
" 	return ''
" endfunction
"
" " Indicate if the buffers file is read only.
" " Empty if window is too narrow, it is a special one
" " or the buffer is editable.
" function! darkvim#layers#core#statusline#read_only() abort
" 	if darkvim#layers#core#statusline#tiny_window() ||
"				\ darkvim#layers#core#statusline#special_window() ||
"				\ !&readonly
" 		return ''
" 	endif
" 	return ''
" endfunction
"
" " Summarize the results of the linter checks.
" " Empty if window is too narrow, it is a special oner,
" " the preview window or all checks were positive.
" function! darkvim#layers#core#statusline#linter_status() abort
" 	if get(g:, 'loaded_neomake', 0)
" 		if darkvim#layers#core#statusline#tiny_window() ||
"					\ darkvim#layers#core#statusline#special_window() ||
"					\ darkvim#layers#core#statusline#preview_window()
" 			return ''
" 		endif
" 		let l:numbers = neomake#statusline#LoclistCounts()
" 		let l:errors   = has_key(l:numbers, 'E') ? ' ' . l:numbers['E'] : ''
" 		let l:warnings = has_key(l:numbers, 'W') ? ' ' . l:numbers['W'] : ''
" 		let l:ignore   = has_key(l:numbers, 'x') ? ' ' . l:numbers['x'] : ''
" 		return l:errors . ( l:errors && l:warnings ? '  ' : '' ) . l:warnings .
"					\ ( l:warnings && l:ignore ? '  ' : '' ) . l:ignore
" 	else
" 		return ''
" 	endif
" endfunction
"
" " Indicate the set file format with an additional icon.
" " Empty if window is too narrow or it is a special one.
" " Reduces to the icon only, if the window is small.
" function! darkvim#layers#core#statusline#file_format() abort
" 	if darkvim#layers#core#statusline#tiny_window() ||
"				\ darkvim#layers#core#statusline#special_window()
" 		return ''
" 	endif
"
" 	let l:condition = !darkvim#layers#core#statusline#medium_window()
" 	let l:text      = &fileformat
" 	let l:icon      = WebDevIconsGetFileFormatSymbol()
"
" 	return (l:condition ? l:text . ' ' : '') . l:icon
" endfunction
"
" " Indicate the files type with an additional icon.
" " Empty if window is too narrow or it is a special one.
" " Reduces to the icon only, if the window is small.
" function! darkvim#layers#core#statusline#file_type() abort
" 	if darkvim#layers#core#statusline#tiny_window() ||
"				\ darkvim#layers#core#statusline#special_window()
" 		return ''
" 	endif
"
" 	let l:condition = !darkvim#layers#core#statusline#medium_window()
" 	let l:text      = &filetype
" 	let l:icon      = WebDevIconsGetFileTypeSymbol()
"
" 	return (l:condition ? l:text . ' ' : '') . l:icon
" endfunction
"
" " Indicate the set file encoding.
" " Empty if window is too narrow or it is a special one.
" function! darkvim#layers#core#statusline#file_encoding() abort
" 	if darkvim#layers#core#statusline#tiny_window() ||
"				\ darkvim#layers#core#statusline#special_window()
" 		return ''
" 	endif
" 	let l:condition = !darkvim#layers#core#statusline#medium_window()
" 	return (l:condition ? &fileencoding : '')
" endfunction
"
" " Show the current language and indicate if spell check is enabled.
" " Empty if window is too narrow or it is a special one.
" " Reduces to the icon only, if the window is small.
" function! darkvim#layers#core#statusline#spell() abort
" 	if darkvim#layers#core#statusline#tiny_window() ||
"				\ darkvim#layers#core#statusline#special_window()
" 		return ''
" 	endif
"
" 	let l:condition = !darkvim#layers#core#statusline#medium_window()
" 	let l:text      = &spelllang
" 	let l:icon      = '﬜' . (&spell ? ' ' : ' ')
"
" 	return (l:condition ? l:text . ' ' : '') . l:icon
" endfunction
"
" " Show the current language and indicate if spell check is enabled.
" " Empty if window is too narrow or it is a special one.
" " Help, quickfix and location list buffers are excluded here.
" function! darkvim#layers#core#statusline#position() abort
" 	if darkvim#layers#core#statusline#tiny_window() ||
"				\ (darkvim#layers#core#statusline#special_window() &&
"				\ &filetype !=# 'help' && &filetype !=# 'qf')
" 		return ''
" 	endif
" 	return line('.') . '/' . line('$') .  ' '
" endfunction
"
" " Show the name of the tab page with the given number.
" " Work in combination with named tabs.
" " The text gets abbreviated, if the window is small.
" function! darkvim#layers#core#statusline#tab_name(count) abort
" 	let l:name = s:tabs_get_name(a:count)
" 	let l:name = darkvim#layers#core#statusline#abbreviate(l:name, 20)
" 	return l:name
" endfunction
"
" " Show the status of the AsyncRun plugin.
" " Doesn't show anything if there was never a job.
" function! darkvim#layers#core#statusline#asyncrun_status() abort
" 	let l:async_status = get(g:, 'asyncrun_status', '')
" 	let l:icon = ' '
" 	if l:async_status ==# 'running'
" 		return l:icon . '羽'
" 	elseif l:async_status ==# 'success'
" 		return l:icon . ''
" 	elseif l:async_status ==# 'failure'
" 		return l:icon . ''
" 	else
" 		return ''
" 	endif
" endfunction
"
" " Status lines for other plugins.
"
" " Tagbar window status line.
" function! darkvim#layers#core#statusline#tagbar_status(current, sort, fname, ...) abort
" 	let g:lightline#fname = a:fname
" 	return lightline#statusline(0)
" endfunction
"
" " Internal
"
" " Determine if the window is part of a fugitive diff.
" function! s:is_diff_window() abort
" 	return expand('%') =~? 'gina:.*\/\.git'
" endfunction
"
" " Return name of the window in the diff.
" " Distinct between the LOCAL and REMOTE window.
" function! s:get_diff_window_name() abort
" 	return expand('%') =~? '\/\.git\/\/2' ? 'LOCAL' : 'REMOTE'
" endfunction
"
" " Determine if the window is a location list window
" function! s:is_location_window(winid) abort
" 	let l:dict = getwininfo(a:winid)
" 	if len(l:dict) > 0 && get(l:dict[0], 'quickfix', 0) &&
"				\ get(l:dict[0], 'loclist', 0)
" 		return v:true
" 	else
" 		return v:false
" 	endif
" endfunction
"
" " Get the name of a tab page.
" " Verifies if a given tab page number is valid.
" " If no argument is given, the current tab is used.
" " Arguments:
" "   tab number - number of the tab page to get the name from (optional)
" " Returns:
" "   name - the name of the selected tab page
" function! s:tabs_get_name(...) abort
" 	" Use the current tab per default.
" 	let l:number = tabpagenr()
"
" 	" Use the provided tab page number if given.
" 	if exists(a:0)
" 		if !s:check_tab_page_number(a:0) | return | endif
" 		let l:number = a:0
" 	endif
"
" 	return gettabvar(l:number, 'name', 'Tab')
" endfunction
"
" " Internal
" " Verify if the given tab number is within the range of existing ones.
" " Includes a warning message if not.
" function! s:check_tab_page_number(number) abort
" 	if a:number > 0 && a:number <= tabpagenr('$')
" 		return v:true
" 	else
" 		return v:false
" 	endif
" endfunction
