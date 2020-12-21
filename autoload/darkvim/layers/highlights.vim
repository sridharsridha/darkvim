function! darkvim#layers#highlights#plugins() abort
  let l:plugins = []

  call add(l:plugins, ['t9md/vim-quickhl' , {
	\ 'on_map' : {'nx' : '<Plug>(quickhl'},
	\ 'loadconf_before' : 1,
	\ }])

  call add(l:plugins, ['MattesGroeger/vim-bookmarks', {
	\ 'loadconf' : 1,
	\ }])

  " Show indent line highlight
  call add(l:plugins, ['nathanaelkane/vim-indent-guides', {
	\ 'on_cmd' : darkvim#util#prefix('IndentGuides', ['Enable', 'Toggle']),
	\ 'loadconf_before' : 1,
	\ }])

  return l:plugins
endfunction

function! darkvim#layers#highlights#config() abort

endfunction
