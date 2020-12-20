" denite.vim fuzzyfinder layer for darkvim

function! darkvim#layers#denite#plugins() abort
   let l:plugins = []

   call add(l:plugins, ['Shougo/denite.nvim', {
	    \  'on_cmd':['Denite','DeniteBufferDir','DeniteCursorWord',
	    \            'DeniteProjectDir'],
	    \  'loadconf':1}])

   call add(l:plugins, ['chemzqm/denite-extra', { 'on_source':['denite.nvim']}])
   call add(l:plugins, ['raghur/fruzzy',        { 'on_source':['denite.nvim']}])
   call add(l:plugins, ['neoclide/denite-git',  { 'on_source':['denite.nvim']}])
   call add(l:plugins, ['Shougo/unite-outline', { 'on_source':['denite.nvim']}])
   call add(l:plugins, ['Shougo/neomru.vim',    { 'on_source':['denite.nvim']}])
   call add(l:plugins, ['Shougo/neoyank.vim',   { 'on_source':['denite.nvim']}])
   call add(l:plugins, ['notomo/denite-keymap', { 'on_source':['denite.nvim']}])
   call add(l:plugins, ['rafi/vim-denite-z',    { 'on_source':['denite.nvim']}])
   call add(l:plugins, ['kmnk/denite-dirmark',  { 'on_source':['denite.nvim']}])

   return l:plugins
endfunction

function! darkvim#layers#denite#config() abort
   let g:neoyank#file = g:darkvim_plugin_bundle_dir . 'neoyank'

   call darkvim#mapping#space#group(['f'], 'File')
   call darkvim#mapping#space#group(['b'], 'Buffer')
   call darkvim#mapping#space#group(['d'], 'Directory')
   call darkvim#mapping#space#group(['y'], 'Yank')
   call darkvim#mapping#space#group(['j'], 'Jump')
   call darkvim#mapping#space#group(['q'], 'Quickfix')
   call darkvim#mapping#space#group(['s'], 'Search')
   call darkvim#mapping#space#group(['s'], 'Search')

   " Quick access files
   call darkvim#mapping#def('nnoremap <silent><nowait>', '<C-p>', ':DeniteProjectDir file/rec<cr>', 'files-in-current-working-dir')
   call darkvim#mapping#space#def('nnoremap', ['f', '<space>'], 'Denite -resume', 'resume-fuzzy-finder', 1)

   " Files listing
   call darkvim#mapping#space#def('nnoremap', ['f', 'r'], 'Denite fast_file_mru', 'open-recent-list', 1)
   call darkvim#mapping#space#def('nnoremap', ['f', 'f'], 'Denite file/rec', 'file-list', 1)
   call darkvim#mapping#space#def('nnoremap', ['f', 'F'], 'Denite file/rec/noignore', 'file-list-noignore', 1)
   call darkvim#mapping#space#def('nnoremap', ['f', 'l'], 'Denite line', 'lines', 1)
   call darkvim#mapping#space#def('nnoremap', ['f', 'L'], 'DeniteCursorWord line', 'lines', 1)
   call darkvim#mapping#space#def('nnoremap', ['f', 'o'], 'Denite outline', 'outline', 1)
   call darkvim#mapping#space#def('nnoremap', ['f', 'm'], 'Denite mark', 'marks', 1)
   call darkvim#mapping#space#def('nnoremap', ['f', '?'], 'call call('.string(function('s:denite_tasklist')).', [])', 'file-tasklist', 1)

   " Buffers
   call darkvim#mapping#space#def('nnoremap', ['b', 'b'], 'Denite buffer', 'buffer-list', 1)
   call darkvim#mapping#space#def('nnoremap', ['b', 'f'], 'DeniteBufferDir file/rec', 'files-curbuf-dir', 1)
   call darkvim#mapping#space#def('nnoremap', ['b', 'F'], 'DeniteBufferDir file/rec/noignore', 'files-curbuf-dir-noignore', 1)
   call darkvim#mapping#space#def('nnoremap', ['b', 'p'], 'execute "Denite file/rec:" . expand("%:p:h:h")', 'files-parent-dir', 1)
   call darkvim#mapping#space#def('nnoremap', ['b', 'p'], 'execute "Denite file/rec/noignore:" . expand("%:p:h:h")', 'files-parent-dir-noignore', 1)

   " Directory
   call darkvim#mapping#space#def('nnoremap', ['d', 'f'], 'DeniteBufferDir directory_rec', 'subdirs-in-curbuf-dir', 1)
   call darkvim#mapping#space#def('nnoremap', ['d', 'F'], 'DeniteBufferDir directory_rec/noignore', 'subdirs-in-curbuf-dir', 1)
   call darkvim#mapping#space#def('nnoremap', ['d', 'p'], 'DeniteBufferDir --no-start-filter parent_dirs', 'subdirs-in-curbuf-dir', 1)
   call darkvim#mapping#space#def('nnoremap', ['d', 'z'], 'Denite z', 'subdirs-in-curbuf-dir', 1)
   call darkvim#mapping#space#def('nnoremap', ['d', 'm'], 'Denite dirmark', 'list-dirmarks', 1)
   call darkvim#mapping#space#def('nnoremap', ['d', 'i'], 'call call('. string(function('s:denite_scan_dir')) .', [])', 'scan-dir', 1)
   call darkvim#mapping#space#def('nnoremap', ['d', 'I'], 'call call('. string(function('s:denite_scan_dir')) .', [0])', 'scan-dir-noignore', 1)
   call darkvim#mapping#space#def('nnoremap', ['d', '?'], 'call call('.string(function('s:denite_tasklist')).', ["."])', 'dir-tasklist', 1)

   " Yank
   call darkvim#mapping#space#def('nnoremap', ['y', 'r'], 'Denite register', 'register', 1)
   call darkvim#mapping#space#def('nnoremap', ['y', 'f'], 'Denite neoyank', 'yank-history', 1)

   " Lists
   call darkvim#mapping#space#def('nnoremap', ['q', 'l'], 'Denite location_list', 'loc-list', 1)
   call darkvim#mapping#space#def('nnoremap', ['q', 'f'], 'Denite -post-action=suspend quickfix', 'quickfix', 1)

   " Jumps
   call darkvim#mapping#space#def('nnoremap', ['j', 'f'], 'Denite jump', 'jumplist', 1)
   call darkvim#mapping#space#def('nnoremap', ['j', 'c'], 'Denite change', 'changelist', 1)

   " Search
   call darkvim#mapping#space#def('nnoremap', ['s', 'f'], 'call call('. string(function('s:denite_grep')) .', [1])', 'search-project', 1)
   call darkvim#mapping#space#def('nnoremap', ['s', 'F'], 'call call('. string(function('s:denite_grep')) .', [0])', 'search-project-noignore', 1)
   call darkvim#mapping#space#def('nnoremap', ['s', 'i'], 'call call('. string(function('s:denite_grep')) .', [1, 1])', 'search-project-interactive', 1)
   call darkvim#mapping#space#def('nnoremap', ['s', 'I'], 'call call('. string(function('s:denite_grep')) .', [0, 1])', 'search-project-interactive-noignore', 1)
   call darkvim#mapping#space#def('nnoremap', ['s', 'G'], 'Denite -no-start-filter -no-empty grep', 'search-input', 1)
   call darkvim#mapping#space#def('nnoremap', ['s', 'g'], 'DeniteCursorWord -no-start-filter -no-empty grep', 'search-cursor-word', 1)
   call darkvim#mapping#space#def('nnoremap', ['s', 'w'], 'DeniteCursorWord line:forward', 'search-word-in-file', 1)
   call darkvim#mapping#space#def('vnoremap', ['s', 'w'], 'call call('.string(function('s:denite_visual_search')).', ["forward"])', 'search-word-vs', 1)

   call darkvim#mapping#space#group(['c'], 'Tags')
   call darkvim#mapping#space#def('nnoremap', ['c', 'l'], 'Denite tag', 'tags', 1)

   " Colorscheme
   call darkvim#mapping#space#group(['C'], 'Colorscheme')
   call darkvim#mapping#space#def('nnoremap', ['C', 'f'], 'Denite colorscheme', 'colorschemes', 1)

   call darkvim#mapping#space#group(['k'], 'Vim')
   call darkvim#mapping#space#def('nnoremap', ['k', 'C'], 'Denite command', 'commands', 1)
   call darkvim#mapping#space#def('nnoremap', ['k', '?'], 'Denite help', 'help-tags', 1)
   call darkvim#mapping#space#def('nnoremap', ['k', 'k'], 'Denite keymap', 'keymappings', 1)
   call darkvim#mapping#space#def('nnoremap', ['k', 's'], 'Denite history:search', 'search-history', 1)
   call darkvim#mapping#space#def('nnoremap', ['k', 'c'], 'Denite command_history', 'command-history', 1)
   call darkvim#mapping#space#def('nnoremap', ['k', 'f'], 'Denite output:function', 'functions', 1)
   call darkvim#mapping#space#def('nnoremap', ['k', 'm'], 'Denite output:messages', 'messages', 1)

   " Note: we need to pass the parent dir of the candidate we want to bookmark
   command -nargs=1 -complete=file DeniteBookmarkAdd
	    \ call darkvim#layers#denite#bookmark_add(<q-args>)
endfunction

function! darkvim#layers#denite#bookmark_add(path) abort
   execute 'Denite dirmark/add -default-action=add -immediately-1 -path=' .
	    \ expand(a:path)
endfunction

function! s:denite_visual_search(direction) abort
   let temp = @s
   norm! gv"sy
   let visual_selection = @s
   let visual_selection = escape(visual_selection, '$+%\.{*|@^')
   let @s = temp
   call denite#start([{'name': 'line', 'args': [a:direction]}],
	    \ {'input': visual_selection})
endfunction

function! s:denite_scan_dir(...) abort
   let narrow_dir = input('Input narrowing directory: ', '', 'file')
   if narrow_dir ==# ''
      return
   endif
   let git_ignore = get(a:, 1, 1)
   let source = git_ignore == 1 ? 'file/rec' : 'file/rec/noignore'
   call denite#start([{'name': source, 'args': [narrow_dir]}])
endfunction

function! s:denite_grep(...) abort
   if !executable('rg')
      echoerr 'ripgrep is not installed or not in  your path.'
      return
   endif
   let l:save_pwd = getcwd()
   lcd %:p:h
   let narrow_dir = input('Target: ', '.', 'file')
   if narrow_dir ==# ''
      return
   endif
   " Don't search gitignored files by default
   let extra_args = ''
   let git_ignore = get(a:, 1, 1)
   if git_ignore == 0
      let extra_args = '--no-ignore-vcs '
   endif
   let filetype = input('Filetype: ', '')
   if filetype ==# ''
      let ft_filter = ''
   else
      let ft_filter = '--type ' . filetype
   endif
   " Allow to run in interactive mode (or require an input pattern)
   let grep_args = [narrow_dir, extra_args . ft_filter]
   let interactive = get(a:, 2, 0)
   if interactive == 1
      call add (grep_args, '!')
   endif
   execute 'lcd ' . l:save_pwd
   call denite#start([{'name': 'grep', 'args': grep_args}],
	    \ {'start_filter': interactive})
endfunction

function! s:denite_tasklist(...) abort
   if a:0 >=1 && a:1 ==# '.'
      let target = a:1
   else
      let target = expand('%')
   endif
   call denite#start([{'name': 'grep',
	    \ 'args': [target, '','TODO:\s|FIXME:\s']}])
endfunction
