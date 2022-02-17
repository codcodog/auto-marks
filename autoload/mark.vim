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
    let uppersName = s:generateUpperMarkName()
    let upperNameList = []
    for markName in uppersName
        if !s:inList(markName, markedList)
            call add(upperNameList, markName)
        endif
    endfor
    return upperNameList
endfunction

" generate all upper name, A-Z
function! s:generateUpperMarkName()
    let upperNameList = []
    for n in range(char2nr('A'), char2nr('Z'))
        let markName = nr2char(n)
        call add(upperNameList, markName)
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

" echo warning message
function! s:warn(msg)
    echohl WarningMsg
    echom a:msg
    echohl None
endfunction

" auto set a mark
function! mark#SetMark()
    let markName = s:getMarkName()
    silent! execute 'mark '.markName
    let msg = "Auto Mark ".markName
    call s:info(msg)
endfunction

" marks A-Z
function! mark#Marks()
    let nameList = s:generateUpperMarkName()
    let arg = join(nameList, '')
    try
        execute 'marks '.arg
    catch
        call s:warn("No Marks")
    endtry
endfunction

" delete marks A-Z
function! mark#DelMarks()
    let nameList = s:generateUpperMarkName()
    let arg = join(nameList, '')
    try
        silent! execute 'delmarks '.arg
    finally
        call s:info("Marks Deleted")
    endtry
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save

