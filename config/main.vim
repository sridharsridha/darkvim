"=============================================================================
" main.vim --- Main file for darkvim
" Author: Sridhar Nagarajan ( sridha.in@gmail.com )
" Date: 2019:11:28
" License: None
"=============================================================================
" try to set encoding to utf-8
set termencoding=utf-8
set fileencoding=utf-8
scriptencoding utf-8

" Remove unwanted provider support for neovim
let g:python_host_skip_check = 1
let g:python3_host_skip_check = 1
let g:loaded_python_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_node_provider = 0

if has('vim_starting')
  exe 'set encoding=utf-8'
  scriptencoding utf-8
  " python host
  " if !empty($PYTHON_HOST_PROG)
  "   let g:python_host_prog  = $PYTHON_HOST_PROG
  " endif
  " if !empty($PYTHON3_HOST_PROG)
  "   let g:python3_host_prog = $PYTHON3_HOST_PROG
  " endif
endif

" Detect root directory of darkvim
function! s:resolve(path) abort
  return resolve(a:path)
endfunction

let g:_darkvim_root_dir = escape(fnamemodify(s:resolve(fnamemodify(expand('<sfile>'),
      \ ':p:h:h:gs?\\?'.'/?')), ':p:gs?[\\/]?/?'), ' ')
lockvar g:_darkvim_root_dir
let &runtimepath = g:_darkvim_root_dir . ',' . $VIMRUNTIME

call darkvim#start()
call darkvim#end()
