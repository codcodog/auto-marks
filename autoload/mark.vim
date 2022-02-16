let s:cpo_save = &cpo
set cpo&vim

function! mark#Hello()
    echo 'hello, auto marks'
endfunction

" get a mark name
function! s:getMarkName()
    let nameList = s:getMarkNameList()
    if len(nameList) == 0
        return 'A'
    endif
    return nameList[0]
endfunction

" generate all upper mark names that are not used.
function! s:getMarkNameList()
    let markedList = s:getMarkedList()
    let upperNameList = []
    for n in range(char2nr('A'), char2nr('Z'))
        let markName = nr2char(n)
        if !s:inList(markName, markedList)
            call add(upperNameList, nr2char(n))
        endif
    endfor
    return upperNameList
endfunction

" check if an element in list
function! s:inList(element, list)
    if len(a:list) == 0
        return 0
    endif
    for value in a:list
        if value == a:element
            return 1
        endif
    endfor
    return 0
endfunction

" get marked name list
function! s:getMarkedList()
    let marks = getmarklist()
    let markList = []
    for mark in marks
        call add(markList, mark['mark'][1:])
    endfor
    return markList
endfunction

" echo info message
function! s:info(msg)
    echohl Identifier
    echom a:msg
    echohl None
endfunction

" auto set mark
function! mark#SetMark()
    let markName = s:getMarkName()
    silent! execute 'mark '.markName
    let msg = "Auto Marks ".markName
    call s:info(msg)
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save

