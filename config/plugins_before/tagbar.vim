
" Tagbar
call darkvim#mapping#space#group(['c'], 'Tags')
call darkvim#mapping#space#def('nnoremap', ['c', 'S'],
			\ 'TagbarToggle',
			\ 'open-tagbar-window', 1)
