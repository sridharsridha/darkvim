" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.  Only define it when not
" defined already.
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
      \ | wincmd p | diffthis

command! -nargs=? -bang IH call darkvim#plugins#a#open_uc("n<bang>", <f-args>)
command! -nargs=? -bang IHS call darkvim#plugins#a#open_uc("h<bang>", <f-args>)
command! -nargs=? -bang IHV call darkvim#plugins#a#open_uc("v<bang>", <f-args>)
command! -nargs=? -bang IHT call darkvim#plugins#a#open_uc("t<bang>", <f-args>)
command! -nargs=? -bang IHN call darkvim#plugins#a#open_next("<bang>")

command! -nargs=? -bang A call darkvim#plugins#a#open("n<bang>", <f-args>)
command! -nargs=? -bang AS call darkvim#plugins#a#open("h<bang>", <f-args>)
command! -nargs=? -bang AV call darkvim#plugins#a#open("v<bang>", <f-args>)
command! -nargs=? -bang AT call darkvim#plugins#a#open("t<bang>", <f-args>)
command! -nargs=? -bang AN call darkvim#plugins#a#next("<bang>")
