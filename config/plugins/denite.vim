scriptencoding utf-8

" Don't reload Denite twice (on vimrc reload)
if exists('*denite#start')
  finish
endif

" " Denite general settings
" call denite#custom#option('_', {
"      \ 'prompt': '❯',
"      \ 'auto_resume': 1,
"      \ 'start_filter': 1,
"      \ 'statusline': 1,
"      \ 'smartcase': 1,
"      \ 'vertical_preview': 1,
"      \ 'highlight_matched_char' : 'Keyword',
"      \ 'highlight_matched_range' : 'MoreMsg',
"      \ })
"
" if has('nvim') && exists('*nvim_open_win')
"   call denite#custom#option('_', {
"       \ 'statusline': 0,
"       \ 'split': 'floating',
"       \ 'floating_preview': 1,
"       \ 'filter_split_direction': 'floating',
"       \ })
" endif
"
"
" " Allow customizable window positions: top, bottom, center (default)
" function! s:denite_resize(position)
"   if a:position ==# 'top'
"     call denite#custom#option('_', {
"          \ 'winwidth': (&columns - (&columns / 3)) - 1,
"          \ 'winheight': &lines / 3,
"          \ 'wincol': 0,
"          \ 'winrow': 1,
"          \ })
"   elseif a:position ==# 'bottom'
"     call denite#custom#option('_', {
"          \ 'winwidth': (&columns - (&columns / 3)) - 1,
"          \ 'winheight': &lines / 3,
"          \ 'wincol': 0,
"          \ 'winrow': (&lines - 2) - (&lines / 3),
"          \ })
"   else
"     " Use Denite default, which is centered.
"   endif
" endfunction


" Set Denite's window position
" let g:denite_position = get(g:, 'denite_position', '')
" call s:denite_resize(g:denite_position)

call denite#custom#option('_', {
         \ 'split': 'floating',
         \ 'start_filter': 1,
         \ 'auto_resize': 1,
         \ 'source_names': 'short',
         \ 'direction': 'botright',
         \ 'prompt': 'λ:',
         \ 'statusline': 0,
         \ 'highlight_matched_char': 'WildMenu',
         \ 'highlight_matched_range': 'Visual',
         \ 'highlight_window_background': 'Statusline',
         \ 'highlight_filter_background': 'WildMenu',
         \ 'highlight_prompt': 'StatusLine',
         \ 'winrow': 1,
         \ 'vertical_preview': 1,
         \ })

" MATCHERS
" Default is 'matcher/fuzzy'
call denite#custom#source('tag', 'matchers', ['matcher/substring'])

" SORTERS
" Default is 'sorter/rank'
call denite#custom#source('z', 'sorters', ['sorter_z'])

" CONVERTERS
" Default is none
call denite#custom#source(
      \ 'buffer,file_mru,file_old',
      \ 'converters', ['converter_relative_word'])

" buffer source
call denite#custom#var(
      \ 'buffer',
      \ 'date_format', '%m-%d-%Y %H:%M:%S')

" FIND and GREP COMMANDS
if executable('ag')
  " The Silver Searcher
  call denite#custom#var('file/rec', 'command',
        \ ['ag', '-U', '--hidden', '--follow', '--nocolor', '--nogroup', '-g', ''])

  " Setup ignore patterns in your .agignore file!
  " https://github.com/ggreer/the_silver_searcher/wiki/Advanced-Usage
  call denite#custom#var('grep', 'command', ['ag'])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'pattern_opt', [])
  call denite#custom#var('grep', 'separator', ['--'])
  call denite#custom#var('grep', 'final_opts', [])
  call denite#custom#var('grep', 'default_opts',
        \ [ '--skip-vcs-ignores', '--vimgrep', '--smart-case', '--hidden' ])

elseif executable('rg')
  " Ripgrep
  call denite#custom#var('file/rec', 'command',
        \ ['rg', '--files', '--glob', '!.git'])
  call denite#custom#var('grep', 'command', ['rg', '--threads', '1'])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'final_opts', [])
  call denite#custom#var('grep', 'separator', ['--'])
  call denite#custom#var('grep', 'default_opts',
        \ ['-i', '--vimgrep', '--no-heading'])

elseif executable('ack')
  " Ack command
  call denite#custom#var('grep', 'command', ['ack'])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'pattern_opt', ['--match'])
  call denite#custom#var('grep', 'separator', ['--'])
  call denite#custom#var('grep', 'final_opts', [])
  call denite#custom#var('grep', 'default_opts',
        \ ['--ackrc', $HOME.'/.config/ackrc', '-H',
        \ '--nopager', '--nocolor', '--nogroup', '--column'])
endif

call denite#custom#alias('source', 'file/rec/git', 'file/rec')
call denite#custom#var('file/rec/git', 'command',
      \ ['git', 'ls-files', '-co', '--exclude-standard'])

" Define mappings
augroup darkvim_layer_denite
  autocmd!
  autocmd FileType denite call s:denite_settings()
  autocmd FileType denite-filter call s:denite_filter_settings()
  autocmd User denite-preview call s:denite_preview()

  autocmd VimResized * call s:denite_resize(g:denite_position)

  " Enable Denite special cursor-line highlight
  autocmd WinEnter * if &filetype =~# '^denite'
        \ |   highlight! link CursorLine WildMenu
        \ | endif

  " Disable Denite special cursor-line highlight
  autocmd WinLeave * if &filetype ==# 'denite'
        \ |   highlight! link CursorLine NONE
        \ | endif
augroup END

function! s:denite_settings() abort
  " Window options
  setlocal signcolumn=no cursorline

  " Denite selection window key mappings
  nnoremap <silent><buffer><expr>  i      denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr>  <Tab>  denite#do_map('choose_action')
  nnoremap <silent><buffer><expr>  <CR>   denite#do_map('do_action')

  nnoremap <silent><buffer><expr>  st     denite#do_map('do_action', 'tabopen')
  nnoremap <silent><buffer><expr>  sv     denite#do_map('do_action', 'vsplit')
  nnoremap <silent><buffer><expr>  sg     denite#do_map('do_action', 'split')
  nnoremap <silent><buffer><expr>  <C-t>  denite#do_map('do_action', 'tabopen')
  nnoremap <silent><buffer><expr>  <C-v>  denite#do_map('do_action', 'vsplit')
  nnoremap <silent><buffer><expr>  <C-x>  denite#do_map('do_action', 'split')

  nnoremap <silent><buffer><expr>  p      denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr>  d      denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr>  "      denite#do_map('quick_move')
  nnoremap <silent><buffer><expr>  r      denite#do_map('redraw')
  nnoremap <silent><buffer><expr>  yy     denite#do_map('do_action', 'yank')
  nnoremap <silent><buffer><expr>  <C-u>  denite#do_map('restore_sources')
  nnoremap <silent><buffer><expr>  <C-f>  denite#do_map('do_action', 'defx')

  nnoremap <silent><buffer>       <C-k>   k
  nnoremap <silent><buffer>       <C-j>   j

  nnoremap <silent><buffer><expr>  q      denite#do_map('quit')
  nnoremap <silent><buffer><expr><nowait>  <C-g>  denite#do_map('quit')
  nnoremap <silent><buffer><expr>  <C-c>  denite#do_map('quit')
  nnoremap <silent><buffer><expr>  <Esc>  denite#do_map('quit')

  nnoremap <silent><buffer><expr><nowait> <Space> denite#do_map('toggle_select').'j'
endfunction

" Denite-preview window settings
function! s:denite_preview() abort
  " Window options
  setlocal nocursorline colorcolumn= signcolumn=no nonumber nolist nospell

  if &lines > 35
    resize +8
  endif
  " let l:pos = win_screenpos(win_getid())
  " let l:heighten = &lines - l:pos[0]
  " execute 'resize ' . l:heighten

  " Clear indents
  if exists('*indent_guides#clear_matches')
    call indent_guides#clear_matches()
  endif
endfunction

function! s:denite_filter_settings() abort
  " Window options
  setlocal signcolumn=yes nocursorline nonumber norelativenumber

  " Disable Deoplete auto-completion within Denite filter window
  if exists('*deoplete#custom#buffer_option')
    call deoplete#custom#buffer_option('auto_complete', v:false)
  endif

  " Denite Filter window key mappings
  inoremap <silent><buffer><expr> <C-t>   denite#do_map('do_action', 'tabopen')
  inoremap <silent><buffer><expr> <C-v>   denite#do_map('do_action', 'vsplit')
  inoremap <silent><buffer><expr> <C-g>   denite#do_map('do_action', 'split')

  inoremap <silent><buffer>       <C-k>   <Esc><C-w>p
  inoremap <silent><buffer>       <C-j>   <Esc><C-w>p

  inoremap <silent><buffer>       <Tab>   <Esc><C-w>p:call cursor(line('.')+1,0)<CR><C-w>pA
  inoremap <silent><buffer>       <S-Tab> <Esc><C-w>p:call cursor(line('.')-1,0)<CR><C-w>pA
  inoremap <silent><buffer><expr> <CR>    denite#do_map('do_action')

  nnoremap <silent><buffer><expr> q       denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>   denite#do_map('quit')
  imap     <silent><buffer><nowait>       <C-g>   <Plug>(denite_filter_quit):q<Cr>
  imap     <silent><buffer>       <C-c>   <Plug>(denite_filter_quit):q<Cr>

  inoremap <silent><buffer>       jk      <Esc><C-w>p
  nnoremap <silent><buffer>       jk      <C-w>p
endfunction

