"Use jk switch to normal mode
inoremap jk <esc>

if (!has('nvim') || $DISPLAY != '') && has('clipboard')
	xnoremap <silent> y "*y:let [@+,@"]=[@*,@*]<CR>
endif

" Start new line
inoremap <S-Return> <C-o>o

" Improve scroll, credits: https://github.com/Shougo
nnoremap <expr> zz (winline() == (winheight(0)+1) / 2) ?
			\ 'zt' : (winline() == &scrolloff + 1) ? 'zb' : 'zz'

" Select blocks after indenting
xnoremap < <gv
xnoremap > >gv|

" Use tab for indenting in visual mode
nnoremap > >>_
nnoremap < <<_

" smart up and down
nnoremap <silent><Down> gj
nnoremap <silent><Up> gk

" Start an external command with a single bang
nnoremap Y y$

" The plugin rhysd/accelerated-jk moves through display-lines in normal mode,
" these mappings will move through display-lines in visual mode too.
vnoremap j gj
vnoremap k gk

" Start an external command with a single bang
nnoremap !  :!

imap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
imap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
imap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
imap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

" yank and paste
" Remove spaces at the end of lines
call darkvim#mapping#leader#group(['x'], 'Text')
call darkvim#mapping#leader#def('nnoremap', ['x', 'w'],
			\ 'silent! keeppatterns %substitute/\s\+$//e',
			\ 'remove-trailing-whitespace', 1)
" Append modeline after last line in buffer
" See: http://vim.wikia.com/wiki/Modeline_magic
function! s:append_modeline() abort
	let l:modeline = printf(' vim: set ts=%d sw=%d tw=%d %set :',
				\ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
	let l:modeline = substitute(&commentstring, '%s', l:modeline, '')
	call append(line('$'), l:modeline)
endfunction
" Append modeline
call darkvim#mapping#leader#def('nnoremap', ['x', 'm'],
			\ 'call call(' . string(function('s:append_modeline')) . ', [])',
			\ 'append-modeline', 1)

if has('unnamedplus')
	call darkvim#mapping#leader#def('nnoremap', ['p'],
				\ '"+p',
				\ 'paste-after-here', 2, 1)
	call darkvim#mapping#leader#def('nnoremap', ['P'],
				\ '"+P',
				\ 'paste-before-here', 2, 1)
	call darkvim#mapping#leader#def('xnoremap', ['y'],
				\ '"+y',
				\ 'yank-selected-text', 2)
	call darkvim#mapping#leader#def('xnoremap', ['x', 'd'],
				\ '"+d',
				\ 'delete-selected-text', 2)
else
	call darkvim#mapping#leader#def('nnoremap', ['p'],
				\ '"*p',
				\ 'paste-after-here', 2, 1)
	call darkvim#mapping#leader#def('nnoremap', ['P'],
				\ '"*P',
				\ 'paste-before-here', 2, 1)
	call darkvim#mapping#leader#def('xnoremap', ['y'],
				\ '"*y',
				\ 'yank-selected-text', 2)
	call darkvim#mapping#leader#def('xnoremap', ['x', 'd'],
				\ '"*d',
				\ 'delete-selected-text', 2)
endif

" Unimpaired bindings
" Quickly add empty lines
call darkvim#mapping#leader#group(['l'], 'Line')
call darkvim#mapping#leader#def('nnoremap', ['l', 'a'],
			\ 'put! =repeat(nr2char(10), v:count1)',
			\ 'add-empty-line-below', 1)
call darkvim#mapping#leader#def('nnoremap', ['l', 'b'],
			\ 'put =repeat(nr2char(10), v:count1)',
			\ 'add-empty-line-above', 1)

" [b or ]n go to previous or next buffer
call darkvim#mapping#leader#group(['b'], 'Buffer')
call darkvim#mapping#leader#def('nnoremap', ['b', 'p'],
			\ 'bN \| stopinsert',
			\ 'prev-buffer', 1)
call darkvim#mapping#leader#def('nnoremap', ['b', 'n'],
			\ 'bn \| stopinsert',
			\ 'next-buffer', 1)

" [l or ]l go to next and previous error
call darkvim#mapping#leader#group(['e'], 'Error')
call darkvim#mapping#leader#def('nnoremap', ['e', 'p'],
			\ 'lprevious',
			\ 'prev-error', 1)
call darkvim#mapping#leader#def('nnoremap', ['e', 'n'],
			\ 'lnext',
			\ 'next-error', 1)

" Switch (window) to the directory of the current opened buffer
call darkvim#mapping#leader#group(['d'], 'Directory')
call darkvim#mapping#leader#def('nnoremap', ['d', 'c'],
			\ 'lcd %:p:h<CR>:pwd',
			\ 'cd-current-buffer-dir', 1)
" Yank buffer's relative/absolute path to clipboard
nnoremap <leader>dY :let @+=expand("%:~:.")<CR>:echo 'Yanked relative path'<CR>
let g:_darkvim_mappings_leader['d']['Y'] = 'yank-relative-path-current-buffer'
nnoremap <leader>dy :let @+=expand("%:p")<CR>:echo 'Yanked absolute path'<CR>
let g:_darkvim_mappings_leader['d']['y'] = 'yank-absolute-path-current-buffer'

" Smart wrap toggle (breakindent and colorcolumn toggle as-well)
call darkvim#mapping#leader#group(['t'], 'Toggles')
" nmap <leader>tw :execute('setlocal wrap! breakindent! colorcolumn=' . (&colorcolumn == '' ? &textwidth : ''))<CR>
call darkvim#mapping#leader#def('nmap', ['t', 'w'],
			\ "execute('setlocal wrap! breakindent! colorcolumn=' . (&colorcolumn == '' ? &textwidth : ''))",
			\ 'toggle-wrap', 1)
" let g:_darkvim_mappings_leader['t']['w'] = 'toggle-wrap'
call darkvim#mapping#leader#def('nnoremap', ['t', 's'],
			\ 'setlocal spell!',
			\ 'toggle-spell', 1)
call darkvim#mapping#leader#def('nnoremap', ['t', 'n'],
			\ 'setlocal nonumber!',
			\ 'toggle-number', 1)
call darkvim#mapping#leader#def('nnoremap', ['t', 'r'],
			\ 'setlocal norelativenumber!',
			\ 'toggle-relativenumber', 1)
call darkvim#mapping#leader#def('nnoremap', ['t', 'c'],
			\ 'setlocal nocursorline!',
			\ 'toggle-cursorline', 1)
call darkvim#mapping#leader#def('nnoremap', ['t', 'l'],
			\ 'setlocal nolist!',
			\ 'toggle-list', 1)
call darkvim#mapping#leader#def('nnoremap', ['t', 'h'],
			\ 'setlocal nohlsearch!',
			\ 'toggle-search-highlight', 1)
" toggles the quickfix window.
command -bang -nargs=? QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
	if exists("g:qfix_win") && a:forced == 0
		cclose
	else
		execute "copen " . get(g:, 'darkvim_quickfix_winheight', 15)
	endif
endfunction
" used to track the quickfix window
augroup QFixToggle
	autocmd!
	autocmd BufWinEnter quickfix let g:qfix_win = bufnr("$")
	autocmd BufWinLeave * if exists("g:qfix_win") && expand("<abuf>") == g:qfix_win |
				\ unlet! g:qfix_win | endif
augroup END
call darkvim#mapping#leader#def('nnoremap', ['t', 'q'],
			\ 'QFix',
			\ 'toggle-quickfix-window', 1)

" Browse config files
function! s:browse_files(local) abort
	let l:directory = '~/.config/nvim/'
	if a:local
		echom "Local Config"
		if finddir(g:darkvim_custom_folder) ==# ''
			silent call mkdir(expand(g:darkvim_custom_folder), 'p', 0700)
			silent exe '!touch ' . g:darkvim_custom_folder . '/init.vim'
		endif
		let l:directory = g:darkvim_custom_folder
	endif
	if darkvim#layers#is_loaded('clap')
		exe 'Clap files '.l:directory
   elseif darkvim#layers#is_loaded('ctrlp')
		exe 'CtrlP '.l:directory
   elseif darkvim#layers#is_loaded('denite')
		exe 'Denite '.l:directory
	else
		exe 'tabnew' l:directory
	endif
endfunction
call darkvim#mapping#leader#group(['f'], 'Files')
call darkvim#mapping#leader#group(['f', 'c'], 'Config')
call darkvim#mapping#leader#def('nnoremap', ['f', 'c', 'g'],
			\ 'call call(' . string(function('s:browse_files')) . ', [0])',
			\ 'open-global-config-dir', 1)
call darkvim#mapping#leader#def('nnoremap', ['f', 'c', 'l'],
			\ 'call call(' . string(function('s:browse_files')) . ', [1])',
			\ 'open-local-config-dir', 1)

" Open the macOS dictionary on current word
call darkvim#mapping#leader#def('nmap', ['?'],
			\ '!open dict://<cword><CR>',
			\ 'open-dictonary-mac', 1)

