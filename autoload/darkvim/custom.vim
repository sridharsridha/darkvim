"=============================================================================
" custom.vim --- Load the custom darkvim configuration folder to runtime
" Author: Sridhar Nagarajan ( sridha.in@gmail.com )
" Date: 2019:11:28
" License: None
"=============================================================================

let s:FILE = darkvim#api#import('file')
let s:CMP = darkvim#api#import('vim#compatible')

function! darkvim#custom#load() abort
	if filereadable('.darkvim.d/init.vim')
		let g:_darkvim_config_path = fnamemodify('.darkvim.d/init.vim', ':p')
		let &rtp =  s:FILE.unify_path(s:CMP.resolve(fnamemodify('.darkvim.d', ':p:h'))) . ',' . &rtp
		let local_conf = g:_darkvim_config_path
		exe 'source .darkvim.d/init.vim'
	else
		call s:load_glob_conf()
	endif
endfunction

function! s:load_glob_conf() abort
	let global_dir = empty($DARKVIMDIR) ? s:FILE.unify_path(s:CMP.resolve(expand('~/.darkvim.d/'))) : $DARKVIMDIR
	if filereadable(global_dir . 'init.vim')
		let g:_darkvim_global_config_path = global_dir . 'init.vim'
		let custom_glob_conf = global_dir . 'init.vim'
		let &rtp = global_dir . ',' . &rtp
		exe 'source ' . custom_glob_conf
	endif
endfunction
