
let g:indent_guides_color_change_percent = 0
let g:indent_guides_default_mapping = 0
let g:indent_guides_guide_size = 1

" IndentLine
call darkvim#mapping#space#group(['h'], 'Highlight')
call darkvim#mapping#space#def('nnoremap', ['h', 'i'],
\ 'IndentGuidesToggle',
\ 'toggle-highlight-indentation-levels', 1)

