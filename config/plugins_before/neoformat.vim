let g:neoformat_basic_format_align = 1 " Enable alignment
let g:neoformat_basic_format_retab = 1 " Enable tab to spaces conversion
let g:neoformat_basic_format_trim = 1 " Enable trimmming of trailing whitespace
let g:neoformat_only_msg_on_error = 1

let g:neoformat_c_clangformat = {
      \ 'exe': 'clang-format',
      \ 'args': ['-assume-filename='.expand('%:t'), '-style=Google'],
      \ 'stdin': 1,
      \ }

let g:neoformat_cpp_clangformat = {
      \ 'exe': 'clang-format',
      \ 'args': ['-assume-filename='.expand('%:t'), '-style=Google'],
      \ 'stdin': 1,
      \ }

let g:neoformat_python_yapf = {
      \ 'exe': 'yapf',
      \ 'args': ['--style=Google'],
      \ }

let g:neoformat_enabled_python = ['yapf']

function! ToggleAutoFormatCode() abort
  if !exists('#AutoFormatCode#BufWritePre')
    augroup AutoFormatCode
      autocmd!
      autocmd BufWritePre * undojoin | Neoformat
    augroup END
  else
    augroup AutoFormatCode
      autocmd!
    augroup END
  endif
endfunction

call darkvim#mapping#space#group(['b'], 'Buffer')
call darkvim#mapping#space#def('nnoremap', ['b', 'f'], 'Neoformat', 'format-code', 1)

command! ToggleAutoFormatCode :call ToggleAutoFormatCode()
call darkvim#mapping#space#def('nnoremap', ['b', 'F'], 'ToggleAutoFormatcode', 'toggle-auto-format', 1)

