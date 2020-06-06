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


