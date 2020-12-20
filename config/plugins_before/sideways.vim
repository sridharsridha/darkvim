" Sideways
call darkvim#mapping#space#group(['x'], 'Text')
call darkvim#mapping#space#group(['x', 'l'], 'ListItem')
call darkvim#mapping#space#def('nnoremap', ['x', 'l', 'h'],
			\ 'SidewaysLeft',
			\ 'shift-list-item-left', 1)
call darkvim#mapping#space#def('nnoremap', ['x', 'l', 'l'],
			\ 'SidewaysRight',
			\ 'shift-list-item-right', 1)
