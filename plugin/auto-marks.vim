if exists('g:loaded_auto_marks')
  finish
endif
let g:loaded_auto_marks = 1

let s:cpo_save = &cpo
set cpo&vim

" commands
command! -bang AutoMark call mark#SetMark()
command! -bang Marks call mark#Marks()
command! -bang DelMarks call mark#DelMarks()

let &cpo = s:cpo_save
unlet s:cpo_save

