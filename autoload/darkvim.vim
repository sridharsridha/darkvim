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

" Top level begin function for darkvim
function! darkvim#start() abort
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

