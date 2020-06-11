scriptencoding utf-8

" Default leader key mappings
let g:mapleader=','
let g:maplocalleader='\'

let g:darkvim_version = '1.0'
let g:darkvim_custom_folder = '~/.darkvim.d/'
let g:darkvim_plugin_bundle_dir = $HOME. join(['', '.cache', 'darkvim', ''], '/')

let g:darkvim_colorscheme = 'gruvbox'
let g:darkvim_windows_leader = 's'
let g:darkvim_welcome_enable = 1
let g:darkvim_enable_guicolors = 1

let g:darkvim_commandline_prompt = '➭'
let g:darkvim_error_symbol       = '✖'
let g:darkvim_warning_symbol     = '⚠'
let g:darkvim_info_symbol        = 'i'

let g:darkvim_project_rooter_patterns = ['.git/' ]
let g:darkvim_project_rooter_automatically = 0

let g:darkvim_smartcloseignorewin     = ['__Tagbar__']
let g:darkvim_smartcloseignoreft      = [
			\ 'tagbar',
			\ 'defx',
			\ ]

let g:darkvim_libclang_path = '/usr/local/Cellar/llvm/8.0.1/lib/libclang.dylib'
let g:darkvim_clang_path = '/usr/bin/clang'

" return [status, dir]
" status: 0 : no argv
"         1 : dir
"         2 : filename
function! s:parser_argv() abort
	if !argc()
		return [0]
	elseif argv(0) ==# '-'
		return [0]
	elseif argv(0) =~# '/$'
		let l:f = fnamemodify(expand(argv(0)), ':p')
		if isdirectory(l:f)
			return [1, l:f]
		else
			return [1, getcwd()]
		endif
	elseif argv(0) ==# '.'
		return [1, getcwd()]
	elseif isdirectory(expand(argv(0)))
		return [1, fnamemodify(expand(argv(0)), ':p')]
	else
		return [2, argv()]
	endif
endfunction

function! darkvim#welcome() abort
	if !get(g:, 'darkvim_welcome_enable', 1)
		return
	endif

	if get(g:, '_darkvim_session_loaded', 0) == 1
		return
	endif
	exe 'cd' fnameescape(g:_darkvim_enter_dir)
	if exists(':Startify') == 2
		Startify
		if isdirectory(bufname(1))
			bwipeout! 1
		endif
	endif
	if darkvim#layers#core#statusline#medium_window() ||
				\ darkvim#layers#core#statusline#tiny_window() ||
				\ darkvim#layers#core#statusline#small_window()
		return
	endif
	if exists(':Defx') == 2
		Defx -direction='botright'
		wincmd p
	endif
endfunction

" Setup welcome page if status is darkvim is loaded with no argv
" or given a directory name as argument
function! s:setup_welcome() abort
	let l:status = s:parser_argv()

	" If do not start Vim with filename, Define autocmd for opening welcome page
	if l:status[0] == 0
		let g:_darkvim_enter_dir = fnamemodify(getcwd(), ':~')
		let l:setup_welcome_autocmd = 1
	elseif l:status[0] == 1
		let g:_darkvim_enter_dir = fnamemodify(l:status[1], ':~')
		let l:setup_welcome_autocmd = 1
	else
		let l:setup_welcome_autocmd = 0
	endif

	if l:setup_welcome_autocmd == 1
		augroup DVwelcome
			au!
			autocmd VimEnter * call darkvim#welcome()
		augroup END
	endif
endfunction

" Top level begin function for darkvim
function! darkvim#start() abort
	" Before loading darkvim, We need to parser argvs and setup welcome page
	call s:setup_welcome()

	" Loading default configuration
	call darkvim#util#load_config('options.vim')
	call darkvim#util#load_config('layers.vim')
	call darkvim#util#load_config('mappings.vim')
	call darkvim#util#load_config('commands.vim')
endfunction

function! darkvim#end() abort
	call darkvim#mapping#windows#init()
	call darkvim#mapping#g#init()
	call darkvim#mapping#z#init()
	call darkvim#mapping#localleader#init()
	call darkvim#mapping#leader#init()
	call darkvim#mapping#space#init()
	call darkvim#custom#load()

	call darkvim#plugins#load()
	call darkvim#util#load_config('general.vim')
	call darkvim#util#load_config('autocmds.vim')
	call darkvim#util#load_config('neovim.vim')
	call darkvim#util#load_config('commands.vim')

	filetype plugin indent on
	syntax on
endfunction

