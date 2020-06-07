scriptencoding utf-8

" debug hook: holds all added plugins from all added layers
let s:_darkvim_plugins = []

function! darkvim#plugins#get() abort
	return deepcopy(s:_darkvim_plugins)
endfunction

function! darkvim#plugins#load() abort
	call s:install_dein()
	if dein#load_state(g:darkvim_plugin_bundle_dir)
		call dein#begin(g:darkvim_plugin_bundle_dir)
		call dein#add('Shougo/dein.vim')
		call s:load_plugins()
		call dein#end()
		call dein#save_state()
		if !has('vim_starting') && dein#check_install()
			" Installation check.
			call dein#install()
		endif
	else
		for layer in darkvim#layers#get()
			call darkvim#layers#{layer}#config()
		endfor
	endif
	if !has('vim_starting')
		call dein#call_hook('source')
		call dein#call_hook('post_source')
	endif
endfunction

function! s:get_layer_plugins(layer) abort
	let p = []
	try
		let p = darkvim#layers#{a:layer}#plugins()
	catch /^Vim\%((\a\+)\)\=:E117/
	endtry
	return p
endfunction

function! s:plugin_add(repo,...) abort
	if len(a:000) > 0
		call dein#add(a:repo, a:000[0])
	else
		call dein#add(a:repo)
	endif
	call add(s:_darkvim_plugins, g:dein#name)
endfunction

function! s:load_plugins() abort
	for layer in darkvim#layers#get()
		for plugin in s:get_layer_plugins(layer)
			" Process each plugins and perform dein#add
			let name = plugin[0]
			let sname = split(plugin[0], '/')[-1]
			if len(plugin) == 2
				let options = plugin[1]
				if !get(options, 'nolazy', 0)
					let options.lazy = 1
				endif
				call s:plugin_add(name, options)
				" Setup dein config for hook_source
				if dein#tap(sname) && get(options, 'loadconf', 0)
					call dein#config(g:dein#name, {
								\ 'hook_source' : "call darkvim#util#load_config('plugins/" .
								\ split(g:dein#name,'\.')[0] . ".vim')"
								\ })
				endif
				" Load plugins configuration equal to hook_add
				if dein#tap(sname) && get(options, 'loadconf_before', 0)
					call dein#config(g:dein#name, {
								\ 'hook_add' : "call darkvim#util#load_config('plugins_before/" .
								\ split(g:dein#name,'\.')[0] . ".vim')"
								\ })
					call s:setup_before_plugin_config(sname)
				endif
			else
				let options = {'lazy' : 1}
				call s:plugin_add(name, options)
			endif
		endfor
		call darkvim#layers#{layer}#config()
	endfor
endfunction

function! s:install_dein() abort
	" Fsep && Psep
	let s:Psep = ':'
	let s:Fsep = '/'
	"auto install dein
	if filereadable(expand(g:darkvim_plugin_bundle_dir)
				\ . join(['repos', 'github.com',
				\ 'Shougo', 'dein.vim', 'README.md'],
				\ s:Fsep))
	else
		if executable('git')
			exec '!git clone https://github.com/Shougo/dein.vim "'
						\ . expand(g:darkvim_plugin_bundle_dir)
						\ . join(['repos', 'github.com',
						\ 'Shougo', 'dein.vim"'], s:Fsep)
		else
			echohl WarningMsg
			echom 'You need install git!'
			echohl None
		endif
	endif
	exec 'set runtimepath+='. fnameescape(g:darkvim_plugin_bundle_dir)
				\ . join(['repos', 'github.com', 'Shougo',
				\ 'dein.vim'], s:Fsep)
endf

