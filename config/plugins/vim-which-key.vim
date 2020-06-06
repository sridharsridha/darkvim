" Which-Key
let g:which_key_exit = ["\<C-g>", "\<Esc>"]
call which_key#register('<space>', "g:_darkvim_mappings_space")
call which_key#register(g:darkvim_windows_leader, "g:_darkvim_mappings_windows")
call which_key#register('g', "g:_darkvim_mappings_g")
call which_key#register('z', "g:_darkvim_mappings_z")
call which_key#register(',', "g:_darkvim_mappings_leader")
call which_key#register('\', "g:_darkvim_mappings_localleader")
