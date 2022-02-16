let s:cpo_save = &cpo
set cpo&vim

function! mark#Hello()
    echo 'hello, auto marks'
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save

