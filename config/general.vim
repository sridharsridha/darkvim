scriptencoding utf-8

" Disable unwanted default plugins
let g:loaded_2html_plugin      = 1
let g:loaded_logiPat           = 1
let g:loaded_getscriptPlugin   = 1
let g:loaded_gzip              = 1
let g:loaded_man               = 1
let g:loaded_matchit           = 1
let g:loaded_matchparen        = 1
let g:loaded_netrwFileHandlers = 1
let g:loaded_netrwPlugin       = 1
let g:loaded_netrwSettings     = 1
let g:loaded_rrhelper          = 1
let g:loaded_shada_plugin      = 1
let g:loaded_spellfile_plugin  = 1
let g:loaded_tarPlugin         = 1
let g:loaded_tutor_mode_plugin = 1
let g:loaded_vimballPlugin     = 1
let g:loaded_zipPlugin         = 1

if g:darkvim_enable_guicolors == 1
  set t_Co=256
  if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
  elseif exists('+guicolors')
    set guicolors
  endif
  try
    exec 'set background=dark'
    exec 'colorscheme ' . g:darkvim_colorscheme
  catch
    exec 'colorscheme desert'
  endtry
else
  try
    exec 'set background=dark'
    exec 'colorscheme ' . g:darkvim_colorscheme
  catch
    exec 'colorscheme desert'
  endtry
endif

