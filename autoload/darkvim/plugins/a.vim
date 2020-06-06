" Do not load a.vim if is has already been loaded.
if exists("loaded_alternateFile")
	finish
endif
if (v:progname == "ex")
	finish
endif
let loaded_alternateFile = 1

let g:alternateExtensionsDict = {}
let s:maxDotsInExtension = 1

" Setup default search path, unless the user has specified
" a path in their [._]vimrc.
if (!exists('g:alternateSearchPath'))
	let g:alternateSearchPath = 'sfr:../source,sfr:../src,sfr:../include,sfr:../inc'
endif

" If this variable is true then a.vim will not alternate to a file/buffer which
" does not exist. E.g while editing a.c and the :A will not swtich to a.h
" unless it exists.
if (!exists('g:alternateNoDefaultAlternate'))
	" by default a.vim will alternate to a file which does not exist
	let g:alternateNoDefaultAlternate = 0
endif

" If this variable is true then a.vim will convert the alternate filename to a
" filename relative to the current working directory.
if (!exists('g:alternateRelativeFiles'))
	" by default a.vim will not convert the filename to one relative to the
	" current working directory
	let g:alternateRelativeFiles = 0
endif

function! darkvim#plugins#a#add_ext_map(extension, alternates)
	let g:alternateExtensionsDict[a:extension] = a:alternates
	let dotsNumber = strlen(substitute(a:extension, "[^.]", "", "g"))
	if s:maxDotsInExtension < dotsNumber
		let s:maxDotsInExtension = dotsNumber
	endif
endfunction

function! darkvim#plugins#a#open(splitWindow, ...)
	let extension   = DetermineExtension(expand("%:p"))
	let baseName    = substitute(expand("%:t"), "\." . extension . '$', "", "")
	let currentPath = expand("%:p:h")

	if (a:0 != 0)
		let newFullname = currentPath . "/" .  baseName . "." . a:1
		call <SID>FindOrCreateBuffer(newFullname, a:splitWindow, 0)
	else
		let allfiles = ""
		if (extension != "")
			let allfiles1 = EnumerateFilesByExtension(currentPath, baseName, extension)
			let allfiles2 = EnumerateFilesByExtensionInPath(baseName, extension, g:alternateSearchPath, currentPath)

			if (allfiles1 != "")
				if (allfiles2 != "")
					let allfiles = allfiles1 . ',' . allfiles2
				else
					let allfiles = allfiles1
				endif
			else
				let allfiles = allfiles2
			endif
		endif

		if (allfiles != "")
			let bestFile = ""
			let bestScore = 0
			let score = 0
			let n = 1

			let onefile = <SID>GetNthItemFromList(allfiles, n)
			let bestFile = onefile
			while (onefile != "" && score < 2)
				let score = <SID>BufferOrFileExists(onefile)
				if (score > bestScore)
					let bestScore = score
					let bestFile = onefile
				endif
				let n = n + 1
				let onefile = <SID>GetNthItemFromList(allfiles, n)
			endwhile

			if (bestScore == 0 && g:alternateNoDefaultAlternate == 1)
				echo "No existing alternate available"
			else
				call <SID>FindOrCreateBuffer(bestFile, a:splitWindow, 1)
				let b:AlternateAllFiles = allfiles
			endif
		else
			echo "No alternate file/buffer available"
		endif
	endif
endfunction

function! darkvim#plugins#a#open_uc(splitWindow,...)
	let cursorFile = (a:0 > 0) ? a:1 : expand("<cfile>")
	let currentPath = expand("%:p:h")
	let openCount = 1

	let fileName = <SID>FindFileInSearchPathEx(cursorFile, g:alternateSearchPath, currentPath, openCount)
	if (fileName != "")
		call <SID>FindOrCreateBuffer(fileName, a:splitWindow, 1)
		let b:openCount = openCount
		let b:cursorFile = cursorFile
		let b:currentPath = currentPath
	else
		echo "Can't find file"
	endif
endfunction

function! darkvim#plugins#a#open_next(bang)
	let cursorFile = ""
	if (exists("b:cursorFile"))
		let cursorFile = b:cursorFile
	endif

	let currentPath = ""
	if (exists("b:currentPath"))
		let currentPath = b:currentPath
	endif

	let openCount = 0
	if (exists("b:openCount"))
		let openCount = b:openCount + 1
	endif

	if (cursorFile != ""  && currentPath != ""  && openCount != 0)
		let fileName = <SID>FindFileInSearchPathEx(cursorFile, g:alternateSearchPath, currentPath, openCount)
		if (fileName != "")
			call <SID>FindOrCreateBuffer(fileName, "n".a:bang, 0)
			let b:openCount = openCount
			let b:cursorFile = cursorFile
			let b:currentPath = currentPath
		else
			let fileName = <SID>FindFileInSearchPathEx(cursorFile, g:alternateSearchPath, currentPath, 1)
			if (fileName != "")
				call <SID>FindOrCreateBuffer(fileName, "n".a:bang, 0)
				let b:openCount = 1
				let b:cursorFile = cursorFile
				let b:currentPath = currentPath
			else
				echo "Can't find next file"
			endif
		endif
	endif
endfunction

function! darkvim#plugins#a#next(bang)
	if (exists('b:AlternateAllFiles'))
		let currentFile = expand("%")
		let n = 1
		let onefile = <SID>GetNthItemFromList(b:AlternateAllFiles, n)
		while (onefile != "" && !<SID>EqualFilePaths(fnamemodify(onefile,":p"), fnamemodify(currentFile,":p")))
			let n = n + 1
			let onefile = <SID>GetNthItemFromList(b:AlternateAllFiles, n)
		endwhile

		if (onefile != "")
			let stop = n
			let n = n + 1
			let foundAlternate = 0
			let nextAlternate = ""
			while (n != stop)
				let nextAlternate = <SID>GetNthItemFromList(b:AlternateAllFiles, n)
				if (nextAlternate == "")
					let n = 1
					continue
				endif
				let n = n + 1
				if (<SID>EqualFilePaths(fnamemodify(nextAlternate, ":p"), fnamemodify(currentFile, ":p")))
					continue
				endif
				if (filereadable(nextAlternate))
					" on cygwin filereadable("foo.H") returns true if "foo.h" exists
					if (has("unix") && $WINDIR != "" && fnamemodify(nextAlternate, ":p") ==? fnamemodify(currentFile, ":p"))
						continue
					endif
					let foundAlternate = 1
					break
				endif
			endwhile
			if (foundAlternate == 1)
				let s:AlternateAllFiles = b:AlternateAllFiles
				"silent! execute ":e".a:bang." " . nextAlternate
				call <SID>FindOrCreateBuffer(nextAlternate, "n".a:bang, 0)
				let b:AlternateAllFiles = s:AlternateAllFiles
			else
				echo "Only this alternate file exists"
			endif
		else
			echo "Could not find current file in alternates list"
		endif
	else
		echo "No other alternate files exist"
	endif
endfunction

function! <SID>BufferOrFileExists(fileName)
	let result = 0

	let lastBuffer = bufnr("$")
	let i = 1
	while i <= lastBuffer
		if <SID>EqualFilePaths(expand("#".i.":p"), a:fileName)
			let result = 2
			break
		endif
		let i = i + 1
	endwhile

	if (!result)
		let bufName = fnamemodify(a:fileName,":t")
		let memBufName = bufname(bufName)
		if (memBufName != "")
			let memBufBasename = fnamemodify(memBufName, ":t")
			if (bufName == memBufBasename)
				let result = 2
			endif
		endif

		if (!result)
			let result  = bufexists(bufName) || bufexists(a:fileName) || filereadable(a:fileName)
		endif
	endif

	if (!result)
		let result = filereadable(a:fileName)
	endif
	return result
endfunction


function! <SID>GetNthItemFromList(list, n)
	let itemStart = 0
	let itemEnd = -1
	let pos = 0
	let item = ""
	let i = 0
	while (i != a:n)
		let itemStart = itemEnd + 1
		let itemEnd = match(a:list, ",", itemStart)
		let i = i + 1
		if (itemEnd == -1)
			if (i == a:n)
				let itemEnd = strlen(a:list)
			endif
			break
		endif
	endwhile
	if (itemEnd != -1)
		let item = strpart(a:list, itemStart, itemEnd - itemStart)
	endif
	return item
endfunction

function! <SID>ExpandAlternatePath(pathSpec, sfPath)
	let prfx = strpart(a:pathSpec, 0, 4)
	if (prfx == "wdr:" || prfx == "abs:")
		let path = strpart(a:pathSpec, 4)
	elseif (prfx == "reg:")
		let re = strpart(a:pathSpec, 4)
		let sep = strpart(re, 0, 1)
		let patend = match(re, sep, 1)
		let pat = strpart(re, 1, patend - 1)
		let subend = match(re, sep, patend + 1)
		let sub = strpart(re, patend+1, subend - patend - 1)
		let flag = strpart(re, strlen(re) - 2)
		if (flag == sep)
			let flag = ''
		endif
		let path = substitute(a:sfPath, pat, sub, flag)
		"call confirm('PAT: [' . pat . '] SUB: [' . sub . ']')
		"call confirm(a:sfPath . ' => ' . path)
	else
		let path = a:pathSpec
		if (prfx == "sfr:")
			let path = strpart(path, 4)
		endif
		let path = a:sfPath . "/" . path
	endif
	return path
endfunction

function! <SID>FindFileInSearchPath(fileName, pathList, relPathBase)
	let filepath = ""
	let m = 1
	let pathListLen = strlen(a:pathList)
	if (pathListLen > 0)
		while (1)
			let pathSpec = <SID>GetNthItemFromList(a:pathList, m)
			if (pathSpec != "")
				let path = <SID>ExpandAlternatePath(pathSpec, a:relPathBase)
				let fullname = path . "/" . a:fileName
				let foundMatch = <SID>BufferOrFileExists(fullname)
				if (foundMatch)
					let filepath = fullname
					break
				endif
			else
				break
			endif
			let m = m + 1
		endwhile
	endif
	return filepath
endfunction

function! <SID>FindFileInSearchPathEx(fileName, pathList, relPathBase, count)
	let filepath = ""
	let m = 1
	let spath = ""
	let pathListLen = strlen(a:pathList)
	if (pathListLen > 0)
		while (1)
			let pathSpec = <SID>GetNthItemFromList(a:pathList, m)
			if (pathSpec != "")
				let path = <SID>ExpandAlternatePath(pathSpec, a:relPathBase)
				if (spath != "")
					let spath = spath . ','
				endif
				let spath = spath . path
			else
				break
			endif
			let m = m + 1
		endwhile
	endif

	if (&path != "")
		if (spath != "")
			let spath = spath . ','
		endif
		let spath = spath . &path
	endif

	let filepath = findfile(a:fileName, spath, a:count)
	return filepath
endfunction

function! EnumerateFilesByExtension(path, baseName, extension)
	let enumeration = ""
	let extSpec = ""
	let v:errmsg = ""
	silent! echo g:alternateExtensions_{a:extension}
	if (v:errmsg == "")
		let extSpec = g:alternateExtensions_{a:extension}
	endif
	if (extSpec == "")
		if (has_key(g:alternateExtensionsDict, a:extension))
			let extSpec = g:alternateExtensionsDict[a:extension]
		endif
	endif
	if (extSpec != "")
		let n = 1
		let done = 0
		while (!done)
			let ext = <SID>GetNthItemFromList(extSpec, n)
			if (ext != "")
				if (a:path != "")
					let newFilename = a:path . "/" . a:baseName . "." . ext
				else
					let newFilename =  a:baseName . "." . ext
				endif
				if (enumeration == "")
					let enumeration = newFilename
				else
					let enumeration = enumeration . "," . newFilename
				endif
			else
				let done = 1
			endif
			let n = n + 1
		endwhile
	endif
	return enumeration
endfunction

function! EnumerateFilesByExtensionInPath(baseName, extension, pathList, relPathBase)
	let enumeration = ""
	let filepath = ""
	let m = 1
	let pathListLen = strlen(a:pathList)
	if (pathListLen > 0)
		while (1)
			let pathSpec = <SID>GetNthItemFromList(a:pathList, m)
			if (pathSpec != "")
				let path = <SID>ExpandAlternatePath(pathSpec, a:relPathBase)
				let pe = EnumerateFilesByExtension(path, a:baseName, a:extension)
				if (enumeration == "")
					let enumeration = pe
				else
					let enumeration = enumeration . "," . pe
				endif
			else
				break
			endif
			let m = m + 1
		endwhile
	endif
	return enumeration
endfunction

function! DetermineExtension(path)
	let mods = ":t"
	let i = 0
	while i <= s:maxDotsInExtension
		let mods = mods . ":e"
		let extension = fnamemodify(a:path, mods)
		if (has_key(g:alternateExtensionsDict, extension))
			return extension
		endif
		let v:errmsg = ""
		silent! echo g:alternateExtensions_{extension}
		if (v:errmsg == "")
			return extension
		endif
		let i = i + 1
	endwhile
	return ""
endfunction

function! <SID>FindOrCreateBuffer(fileName, doSplit, findSimilar)
	" Check to see if the buffer is already open before re-opening it.
	let FILENAME = escape(a:fileName, ' ')
	let bufNr = -1
	let lastBuffer = bufnr("$")
	let i = 1
	if (a:findSimilar)
		while i <= lastBuffer
			if <SID>EqualFilePaths(expand("#".i.":p"), a:fileName)
				let bufNr = i
				break
			endif
			let i = i + 1
		endwhile

		if (bufNr == -1)
			let bufName = bufname(a:fileName)
			let bufFilename = fnamemodify(a:fileName,":t")

			if (bufName == "")
				let bufName = bufname(bufFilename)
			endif

			if (bufName != "")
				let tail = fnamemodify(bufName, ":t")
				if (tail != bufFilename)
					let bufName = ""
				endif
			endif
			if (bufName != "")
				let bufNr = bufnr(bufName)
				let FILENAME = bufName
			endif
		endif
	endif

	if (g:alternateRelativeFiles == 1)
		let FILENAME = fnamemodify(FILENAME, ":p:.")
	endif

	let splitType = a:doSplit[0]
	let bang = a:doSplit[1]
	if (bufNr == -1)
		" Buffer did not exist....create it
		let v:errmsg=""
		if (splitType == "h")
			silent! execute ":split".bang." " . FILENAME
		elseif (splitType == "v")
			silent! execute ":vsplit".bang." " . FILENAME
		elseif (splitType == "t")
			silent! execute ":tab split".bang." " . FILENAME
		else
			silent! execute ":e".bang." " . FILENAME
		endif
		if (v:errmsg != "")
			echo v:errmsg
		endif
	else

		" Find the correct tab corresponding to the existing buffer
		let tabNr = -1
		" iterate tab pages
		for i in range(tabpagenr('$'))
			" get the list of buffers in the tab
			let tabList =  tabpagebuflist(i + 1)
			let idx = 0
			" iterate each buffer in the list
			while idx < len(tabList)
				" if it matches the buffer we are looking for...
				if (tabList[idx] == bufNr)
					" ... save the number
					let tabNr = i + 1
					break
				endif
				let idx = idx + 1
			endwhile
			if (tabNr != -1)
				break
			endif
		endfor
		" switch the the tab containing the buffer
		if (tabNr != -1)
			execute "tabn ".tabNr
		endif

		" Buffer was already open......check to see if it is in a window
		let bufWindow = bufwinnr(bufNr)
		if (bufWindow == -1)
			" Buffer was not in a window so open one
			let v:errmsg=""
			if (splitType == "h")
				silent! execute ":sbuffer".bang." " . FILENAME
			elseif (splitType == "v")
				silent! execute ":vert sbuffer " . FILENAME
			elseif (splitType == "t")
				silent! execute ":tab sbuffer " . FILENAME
			else
				silent! execute ":buffer".bang." " . FILENAME
			endif
			if (v:errmsg != "")
				echo v:errmsg
			endif
		else
			" Buffer is already in a window so switch to the window
			execute bufWindow."wincmd w"
			if (bufWindow != winnr())
				" something wierd happened...open the buffer
				let v:errmsg=""
				if (splitType == "h")
					silent! execute ":split".bang." " . FILENAME
				elseif (splitType == "v")
					silent! execute ":vsplit".bang." " . FILENAME
				elseif (splitType == "t")
					silent! execute ":tab split".bang." " . FILENAME
				else
					silent! execute ":e".bang." " . FILENAME
				endif
				if (v:errmsg != "")
					echo v:errmsg
				endif
			endif
		endif
	endif
endfunction

function! <SID>EqualFilePaths(path1, path2)
	if has("win16") || has("win32") || has("win64") || has("win95")
		return substitute(a:path1, "\/", "\\", "g") ==? substitute(a:path2, "\/", "\\", "g")
	else
		return a:path1 == a:path2
	endif
endfunction

" Add all the default extensions
" Mappings for C and C++
call darkvim#plugins#a#add_ext_map('h',"c,cpp,cxx,cc,CC")
call darkvim#plugins#a#add_ext_map('H',"C,CPP,CXX,CC")
call darkvim#plugins#a#add_ext_map('hpp',"cpp,c")
call darkvim#plugins#a#add_ext_map('HPP',"CPP,C")
call darkvim#plugins#a#add_ext_map('c',"h")
call darkvim#plugins#a#add_ext_map('C',"H")
call darkvim#plugins#a#add_ext_map('cpp',"h,hpp")
call darkvim#plugins#a#add_ext_map('CPP',"H,HPP")
call darkvim#plugins#a#add_ext_map('cc',"h")
call darkvim#plugins#a#add_ext_map('CC',"H,h")
call darkvim#plugins#a#add_ext_map('cxx',"h")
call darkvim#plugins#a#add_ext_map('CXX',"H")
call darkvim#plugins#a#add_ext_map('tac',"tin,itin")
call darkvim#plugins#a#add_ext_map('tin',"tac")
call darkvim#plugins#a#add_ext_map('itin',"tac")

" Mappings for PSL7
call darkvim#plugins#a#add_ext_map('psl',"ph")
call darkvim#plugins#a#add_ext_map('ph',"psl")

" Mappings for ADA
call darkvim#plugins#a#add_ext_map('adb',"ads")
call darkvim#plugins#a#add_ext_map('ads',"adb")

" Mappings for lex and yacc files
call darkvim#plugins#a#add_ext_map('l',"y,yacc,ypp")
call darkvim#plugins#a#add_ext_map('lex',"yacc,y,ypp")
call darkvim#plugins#a#add_ext_map('lpp',"ypp,y,yacc")
call darkvim#plugins#a#add_ext_map('y',"l,lex,lpp")
call darkvim#plugins#a#add_ext_map('yacc',"lex,l,lpp")
call darkvim#plugins#a#add_ext_map('ypp',"lpp,l,lex")

" Mappings for OCaml
call darkvim#plugins#a#add_ext_map('ml',"mli")
call darkvim#plugins#a#add_ext_map('mli',"ml")

" ASP stuff
call darkvim#plugins#a#add_ext_map('aspx.cs', 'aspx')
call darkvim#plugins#a#add_ext_map('aspx.vb', 'aspx')
call darkvim#plugins#a#add_ext_map('aspx', 'aspx.cs,aspx.vb')

