" cmake.vim : cmake file support for darkvim

function! darkvim#layers#lang#cmake#plugins() abort
	let plugins = []

	call add(plugins, ['cdelledonne/vim-cmake', {
				\ 'on_cmd' : darkvim#util#prefix('Cmake',
				\            ['Generate', 'Clean', 'Build', 'Open', 'Close']),
				\ 'on_map' : {'n' : '<Plug>(CMake'},
				\ }])
	call add(plugins, ['pboettch/vim-cmake-syntax', {
				\ 'on_ft' : ['cmake'],
				\ }])

	return plugins
endfunction

function! darkvim#layers#lang#cmake#config() abort

	let g:cmake_default_build_dir = "cmake-build-debug"
	let g:cmake_console_size = 10
	let g:cmake_link_compile_commands = 1
	call darkvim#mapping#space#group(['b'], "Build")
	call darkvim#mapping#space#def('nmap', ['b', 'g'],
				\ 'CMakeGenerate',
				\ 'generate-cmake-build-files', 1)
	call darkvim#mapping#space#def('nnoremap', ['b', 'c'],
				\ 'CMakeClean',
				\ 'clean-cmake-project', 1)
	call darkvim#mapping#space#def('nnoremap', ['b', 'b'],
				\ 'CMakeBuild --parallel 7',
				\ 'build-cmake-project', 1)
	call darkvim#mapping#space#def('nmap', ['b', 't'],
				\ '<Plug>(CMakeBuildTarget)',
				\ 'build-cmake-target')
	call darkvim#mapping#space#def('nmap', ['b', 'i'],
				\ 'CMakeInstall',
				\ 'install-cmake-project', 2)

	call darkvim#mapping#space#def('nnoremap', ['b', 'o'], 'call call('
				\ . string(function('s:toggle_cmake_console')) . ', [])',
				\ 'toggle-cmake-console', 1)
	call darkvim#mapping#space#def('nnoremap', ['b', 'a'], 'call call('
				\ . string(function('s:cmake_auto_reload')) . ', [1])',
				\ 'enable-cmake-auto-reload', 1)
	call darkvim#mapping#space#def('nnoremap', ['b', 'A'], 'call call('
				\ . string(function('s:cmake_auto_reload')) . ', [0])',
				\ 'disable-cmake-auto-reload', 1)
	call s:cmake_auto_reload(1)
endfunction

function! s:toggle_cmake_console() abort
	let l:cmake_console_windows = filter(range(1, winnr('$')), 'getwinvar(v:val, "&ft") == "vimcmake"')
	if len(l:cmake_console_windows) == 0
		execute "CMakeOpen"
	else
		execute "CMakeClose"
	endif
endfunction

function! s:cmake_auto_reload(enabled) abort
	augroup cmake_custom
		au!
		if a:enabled
			au BufWritePost CMakeLists.txt execute "CMakeGenerate"
		endif
	augroup END
endfunction

