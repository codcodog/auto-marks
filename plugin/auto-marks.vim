if exists('g:loaded_auto_marks')
  finish
endif
let g:loaded_auto_marks = 1

let s:cpo_save = &cpo
set cpo&vim

" commands
command! AutoMarks call mark#SetMark()
command! Debug call mark#Hello()

let &cpo = s:cpo_save
unlet s:cpo_save

