" Quickhl
call darkvim#mapping#space#group(['h'], 'Highlight')
call darkvim#mapping#space#def('nmap', ['h', 'h'],
			\ '<Plug>(quickhl-manual-this)',
			\ 'highlight-cword', 0, 1)
call darkvim#mapping#space#def('nmap', ['h', 'r'],
			\ '<Plug>(quickhl-manual-reset)',
			\ 'highlight-reset', 0, 1)
call darkvim#mapping#space#def('nmap', ['h', 'c'],
			\ '<Plug>(quickhl-manual-clear)',
			\ 'highlight-clear', 0, 1)
call darkvim#mapping#space#def('nmap', ['h', 't'],
			\ '<Plug>(quickhl-cword-toggle)',
			\ 'highlight-cword-toggle', 0, 1)

