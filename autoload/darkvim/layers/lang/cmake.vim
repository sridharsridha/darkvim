" cmake.vim : cmake file support for darkvim

function! darkvim#layers#lang#cmake#plugins() abort
	let plugins = []

	call add(plugins, ['skywind3000/asyncrun.vim'])
	call add(plugins, ['vhdirk/vim-cmake', {
				\ 'depends' : ['asyncrun.vim'],
				\ 'on_cmd' : darkvim#util#prefix('CMake', ['', 'Clean', 'FindBuildDir']),
				\ }])
	call add(plugins, ['pboettch/vim-cmake-syntax', {
				\ 'on_ft' : ['cmake'],
				\ }])

	return plugins
endfunction

function! darkvim#layers#lang#cmake#config() abort

	let g:cmake_build_dir = "build"
	call darkvim#mapping#space#group(['b'], "Build")
	call darkvim#mapping#space#def('nnoremap', ['b', 'p'],
				\ 'CMake',
				\ 'build-cmake-project', 1)
	call darkvim#mapping#space#def('nnoremap', ['b', 'c'],
				\ 'CMakeClean',
				\ 'clean-cmake-project', 1)
	call darkvim#mapping#space#def('nnoremap', ['b', 'r'],
				\ 'CMakeFindBuildDir',
				\ 'reset-cmake-project', 1)

endfunction

