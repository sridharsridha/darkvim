" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.  Only define it when not
" defined already.
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
      \ | wincmd p | diffthis

command! -nargs=? -bang A call darkvim#plugins#a#open("n<bang>", <f-args>)
command! -nargs=? -bang AS call darkvim#plugins#a#open("h<bang>", <f-args>)
command! -nargs=? -bang AV call darkvim#plugins#a#open("v<bang>", <f-args>)
command! -nargs=? -bang AN call darkvim#plugins#a#next("<bang>")
