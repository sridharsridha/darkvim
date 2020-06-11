" defx.vim --- defx configuration
scriptencoding utf-8

let g:_darkvim_filetree_show_hidden_files = 1
let g:_darkvim_autoclose_filetree = 1

if get(g:, 'darkvim_filetree_direction', 'left') ==# 'right'
  let s:direction = 'botright'
else
  let s:direction = 'topleft'
endif

let g:defx_icons_column_length = 2
let g:defx_icons_mark_icon = '✓'
let g:defx_icons_parent_icon = ''

call defx#custom#option('_', {
      \ 'columns': 'indent:mark:git:icons:filename',
      \ 'winwidth': get(g:, 'darkvim_sidebar_width', 30),
      \ 'split': 'vertical',
      \ 'direction': s:direction,
      \ 'show_ignored_files': g:_darkvim_filetree_show_hidden_files,
      \ 'root_marker': ' ',
      \ 'ignored_files':
      \     '.mypy_cache,.pytest_cache,.git,.hg,.svn,.stversions'
      \   . ',__pycache__,.sass-cache,*.egg-info,.DS_Store,*.pyc'
      \ })

call defx#custom#column('mark', {
      \ 'readonly_icon': '',
      \ 'selected_icon': '',
      \ })

call defx#custom#column('git', {
      \   'indicators': {
      \     'Modified'  : '•',
      \     'Staged'    : '✚',
      \     'Untracked' : 'ᵁ',
      \     'Renamed'   : '≫',
      \     'Unmerged'  : '≠',
      \     'Ignored'   : 'ⁱ',
      \     'Deleted'   : '✖',
      \     'Unknown'   : '⁇'
      \   }
      \ })
"
call defx#custom#column('filename', {
      \ 'max_width': -90,
      \ })

augroup defx_init
  au!
  " Init defx mappings
  autocmd FileType defx call s:defx_init()

  " auto close last defx windows
  autocmd BufEnter * nested if
        \ (!has('vim_starting') && winnr('$') == 1  && g:_darkvim_autoclose_filetree
        \ && &filetype ==# 'defx') |
        \ call s:close_last_vimfiler_windows() | endif

  " Move focus to the next window if current buffer is defx
  autocmd TabLeave * if &filetype == 'defx' | wincmd w | endif
augroup END

" in this function, we should check if shell terminal still exists,
" then close the terminal job before close vimfiler
function! s:close_last_vimfiler_windows() abort
	if darkvim#layers#is_loaded('shell')
		call darkvim#layers#shell#close_terminal()
	endif
  q
endfunction

function! s:defx_init()
  setl nonumber signcolumn=no expandtab norelativenumber
  setl listchars= nofoldenable foldmethod=manual

  " disable this mappings
  nnoremap <silent><buffer> <3-LeftMouse> <Nop>
  nnoremap <silent><buffer> <4-LeftMouse> <Nop>
  nnoremap <silent><buffer> <LeftMouse> <LeftMouse><Home>
  silent! nunmap <buffer> <Space>
  silent! nunmap <buffer> <C-l>
  silent! nunmap <buffer> <C-j>
  silent! nunmap <buffer> E
  silent! nunmap <buffer> gr
  silent! nunmap <buffer> gf
  silent! nunmap <buffer> -
  silent! nunmap <buffer> s

  nnoremap <silent><buffer><expr> <CR>
        \ defx#is_directory() ?
        \ defx#do_action('open_directory') : defx#do_action('drop')
  nnoremap <silent><buffer><expr> <2-LeftMouse>
        \ defx#is_directory() ?
        \     (
        \     defx#is_opened_tree() ?
        \     defx#do_action('close_tree') :
        \     defx#do_action('open_tree')
        \     )
        \ : defx#do_action('drop')

  nnoremap <silent><buffer><expr> t  defx#do_action('open_tree_recursive')
  nnoremap <silent><buffer><expr> st defx#do_action('multi', [['drop', 'tabnew'], 'quit'])
  nnoremap <silent><buffer><expr> sv defx#do_action('multi', [['drop', 'vsplit'], 'quit'])
  nnoremap <silent><buffer><expr> sg defx#do_action('multi', [['drop', 'split'], 'quit'])
  nnoremap <silent><buffer><expr> p  defx#do_action('open', 'pedit')

  nnoremap <silent><buffer><expr> y  defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> x  defx#do_action('execute_system')
  nnoremap <silent><buffer><expr> gx defx#do_action('execute_system')
  nnoremap <silent><buffer><expr> .  defx#do_action('toggle_ignored_files')

  " Navigation:
  nnoremap <silent><buffer> <Home> :call cursor(2, 1)<cr>
  nnoremap <silent><buffer> <End> :call cursor(line('$'), 1)<cr>
  nnoremap <silent><buffer><expr> j line('.') == line('$') ? 'gg' : 'j'
  nnoremap <silent><buffer><expr> k line('.') == 1 ? 'G' : 'k'

  nnoremap <silent><buffer><expr> h defx#do_action('call', 'DefxSmartH')
  nnoremap <silent><buffer><expr> <Left> defx#do_action('call', 'DefxSmartH')
  nnoremap <silent><buffer><expr> l defx#do_action('call', 'DefxSmartL')
  nnoremap <silent><buffer><expr> <Right> defx#do_action('call', 'DefxSmartL')
  nnoremap <silent><buffer><expr> o defx#do_action('call', 'DefxSmartL')
  nnoremap <silent><buffer><expr> <Tab> winnr('$') != 1 ?
        \ ':<C-u>wincmd w<CR>' :
        \ ':<C-u>Defx -buffer-name=temp -split=vertical<CR>'

  " Defx's buffer management
  nnoremap <silent><buffer><expr> q      defx#do_action('quit')
  nnoremap <silent><buffer><expr> se     defx#do_action('save_session')
  nnoremap <silent><buffer><expr> <C-r>  defx#do_action('redraw')
  nnoremap <silent><buffer><expr> <C-g>  defx#do_action('print')

  " File/dir management
  nnoremap <silent><buffer><expr><nowait> c  defx#do_action('copy')
  nnoremap <silent><buffer><expr><nowait> m  defx#do_action('move')
  nnoremap <silent><buffer><expr><nowait> p  defx#do_action('paste')
  nnoremap <silent><buffer><expr><nowait> r  defx#do_action('rename')
  nnoremap <silent><buffer><expr> D defx#do_action('remove')
  nnoremap <silent><buffer><expr> dd defx#do_action('remove_trash')
  nnoremap <silent><buffer><expr> K  defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> N  defx#do_action('new_multiple_files')

  " Jump
  nnoremap <silent><buffer>  [g :<C-u>call <SID>jump_dirty(-1)<CR>
  nnoremap <silent><buffer>  ]g :<C-u>call <SID>jump_dirty(1)<CR>

  " Change directory
  nnoremap <silent><buffer><expr><nowait> \ defx#do_action('change_vim_cwd')
  nnoremap <silent><buffer><expr><nowait> &  defx#do_action('cd', getcwd())
  nnoremap <silent><buffer><expr> <BS>  defx#async_action('cd', ['..'])
  nnoremap <silent><buffer><expr> ~     defx#async_action('cd')
  nnoremap <silent><buffer><expr> u   defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> 2u  defx#do_action('cd', ['../..'])
  nnoremap <silent><buffer><expr> 3u  defx#do_action('cd', ['../../..'])
  nnoremap <silent><buffer><expr> 4u  defx#do_action('cd', ['../../../..'])

  " Selection
  nnoremap <silent><buffer><expr> *  defx#do_action('toggle_select_all')
  nnoremap <silent><buffer><expr><nowait> <Space>
        \ defx#do_action('toggle_select') . 'j'

  nnoremap <silent><buffer><expr> S  defx#do_action('toggle_sort', 'Time')
  nnoremap <silent><buffer><expr> C
        \ defx#do_action('toggle_columns', 'indent:mark:filename:type:size:time')

  " Resize
  nnoremap <silent><buffer><expr> >
        \ defx#do_action('resize', defx#get_context().winwidth + 5)
  nnoremap <silent><buffer><expr> <
        \ defx#do_action('resize', defx#get_context().winwidth - 5)

  " Tools
  nnoremap <silent><buffer><expr> gd
        \ defx#async_action('multi', ['drop', ['call', '<SID>git_diff']])
  if exists('$TMUX')
    nnoremap <silent><buffer><expr> gl  defx#async_action('call', '<SID>explorer')
  endif
  nnoremap <silent><buffer><expr> gr defx#do_action('call', '<SID>grep')
  nnoremap <silent><buffer><expr> gf defx#do_action('call', '<SID>find_files')
  nnoremap <silent><buffer><expr> w defx#async_action('call', '<SID>toggle_width')
endf

" in this function we should vim-choosewin if possible
function! DefxSmartL(_)
  if defx#is_directory()
    call defx#call_action('open_tree')
    normal! j
  else
    let l:filepath = defx#get_candidate()['action__path']
    if tabpagewinnr(tabpagenr(), '$') >= 3    " if there are more than 2 normal windows
      if exists(':ChooseWin') == 2
        ChooseWin
      else
        let l:input = input('ChooseWin No./Cancel(n): ')
        if l:input ==# 'n' | return | endif
        if l:input == winnr() | return | endif
        exec l:input . 'wincmd w'
      endif
      exec 'e' l:filepath
    else
      exec 'wincmd w'
      exec 'e' l:filepath
    endif
  endif
endfunction

function! DefxSmartH(_)
  " if cursor line is first line, or in empty dir
  if line('.') ==# 1 || line('$') ==# 1
    return defx#call_action('cd', ['..'])
  endif

  " candidate is opend tree?
  if defx#is_opened_tree()
    return defx#call_action('close_tree')
  endif

  " parent is root?
  let s:candidate = defx#get_candidate()
  let s:parent = fnamemodify(s:candidate['action__path'], s:candidate['is_directory'] ? ':p:h:h' : ':p:h')
  let l:sep = '/'
  if s:trim_right(s:parent, l:sep) == s:trim_right(b:defx.paths[0], l:sep)
    return defx#call_action('cd', ['..'])
  endif

  " move to parent.
  call defx#call_action('search', s:parent)

  " if you want close_tree immediately, enable below line.
  call defx#call_action('close_tree')
endfunction

function! s:git_diff(context) abort
  execute 'vert Gdiffsplit'
endfunction

function! s:find_files(context) abort
  " Find files in parent directory with Denite
  let l:target = a:context['targets'][0]
  let l:parent = fnamemodify(l:target, ':h')
  silent execute 'wincmd w'
  silent execute 'Denite file/rec:'.l:parent
endfunction

function! s:grep(context) abort
  " Grep in parent directory with Denite
  let l:target = a:context['targets'][0]
  let l:parent = fnamemodify(l:target, ':h')
  silent execute 'wincmd w'
  silent execute 'Denite grep:'.l:parent
endfunction

function! s:toggle_width(context) abort
  " Toggle between defx window width and longest line
  let l:max = 0
  let l:original = a:context['winwidth']
  for l:line in range(1, line('$'))
    let l:len = len(getline(l:line))
    if l:len > l:max
      let l:max = l:len
    endif
  endfor
  execute 'vertical resize ' . (l:max == winwidth('.') ? l:original : l:max)
endfunction

function! s:trim_right(str, trim)
  return substitute(a:str, printf('%s$', a:trim), '', 'g')
endfunction

function! s:explorer(context) abort
  " Open file-explorer split with tmux
  let l:explorer = s:find_file_explorer()
  if empty('$TMUX') || empty(l:explorer)
    return
  endif
  let l:target = a:context['targets'][0]
  let l:parent = fnamemodify(l:target, ':h')
  let l:cmd = 'split-window -p 30 -c ' . l:parent . ' ' . l:explorer
  silent execute '!tmux ' . l:cmd
endfunction

function! s:find_file_explorer() abort
  " Detect terminal file-explorer
  let s:file_explorer = get(g:, 'terminal_file_explorer', '')
  if empty(s:file_explorer)
    for l:explorer in ['lf', 'hunter', 'ranger', 'vifm']
      if executable(l:explorer)
        let s:file_explorer = l:explorer
        break
      endif
    endfor
  endif
  return s:file_explorer
endfunction
