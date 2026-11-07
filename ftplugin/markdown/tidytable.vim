" File: tidytable.vim
" Maintainer: Eugene F. Barker <http://madman.com/about.html>
" Description: A Vim plugin for tidying markdown pipe tables.
" Version: 0.1

if exists('g:loaded_tidytable')
  finish
endif
let g:loaded_tidytable = 1

function! TidyMarkdownPipeTable()
    if !(s:VerifyHasAlignmentFunction() && s:VerifyInsideMarkdownTable()) 
        return 0
    endif
    let has_outer_pipes = s:HasOuterPipes()
    if has_outer_pipes
        call s:StripOuterPipes()
    endif
    call s:MinimizeSeperatorLine()
    call s:AlignMarkdownTableColumns()
    call s:TidyMarkdownTableHeader()
    if has_outer_pipes
        call s:AddOuterPipes()
    endif
endfunc

function! s:VerifyHasAlignmentFunction()
    if exists(':Tabularize')
        return 1
    endif
    echo 'error: missing required plugin godlygeek/tabular'
    return 0
endfunc

function! s:VerifyInsideMarkdownTable()
    let p = '^.*|'
    if getline('.') =~# p && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
        return 1
    endif
    echo 'error: must be inside a markdown table'
    return 0
endfunc

function! s:HasOuterPipes()
    return getline(s:GetStartLineNoOfTable()) =~# '^\s*|.*|\s*$'
endfunc

function! s:StripOuterPipes()
    for line_no in range(s:GetStartLineNoOfTable(), s:GetEndLineNoOfTable())
        let line = substitute(getline(line_no), '^\s*|\s*', '', '')
        call setline(line_no, substitute(line, '\s*|\s*$', '', ''))
    endfor
endfunc

function! s:AddOuterPipes()
    let start_line_no = s:GetStartLineNoOfTable()
    let end_line_no = s:GetEndLineNoOfTable()
    let width = max(map(getline(start_line_no, end_line_no), 'strdisplaywidth(v:val)'))
    for line_no in range(start_line_no, end_line_no)
        let line = getline(line_no)
        let line .= repeat(' ', width - strdisplaywidth(line))
        call setline(line_no, '| ' . line . ' |')
    endfor
endfunc

function! s:MinimizeSeperatorLine()
    let start_line_no = s:GetStartLineNoOfTable()
    let end_line_no = s:GetEndLineNoOfTable()
    let seperator_line = getline(start_line_no + 1)
    if seperator_line !~ '^.*-\{3\}'
        " not a seperator for a markdown table
        return
    endif
    let minimized_line = substitute(seperator_line, '-\{4,\}', '---', 'g')
    call setline(start_line_no + 1, minimized_line)
endfunc

function! s:GetStartLineNoOfTable()
    let lineNo = line('.')
    while getline(lineNo - 1) =~# '^.*|'
        let lineNo -= 1
    endwhile
    return lineNo
endfunc

function! s:GetEndLineNoOfTable()
    let lineNo = line('.')
    while getline(lineNo + 1) =~# '^.*|'
        let lineNo += 1
    endwhile
    return lineNo
endfunc

function! s:AlignMarkdownTableColumns()
    Tabularize /|/l1
endfunc

function! s:TidyMarkdownTableHeader()
    let start_line_no = s:GetStartLineNoOfTable()
    let end_line_no = s:GetEndLineNoOfTable()
    let seperator_line = getline(start_line_no + 1)
    if seperator_line !~ '^.*-\{3\}'
        echo 'info: no markdown table header to tidy'
        return
    endif
    " widest line, separator included so its 3-dash minimum survives
    let max_line_length = max(map(getline(start_line_no, end_line_no), 'strdisplaywidth(v:val)'))
    " replace undashed spaces with dashes
    let tidy_seperator = substitute(seperator_line, ' ', '-', 'g')
    " pad pipes with a space
    let tidy_seperator = substitute(tidy_seperator, '-|-', ' | ', 'g')
    " truncate to max line length
    let tidy_seperator = strpart(tidy_seperator, 0, max_line_length)
    " pad to max line length
    while strlen(tidy_seperator) < max_line_length
        let tidy_seperator .= '-' 
    endwhile
    call setline(start_line_no + 1, tidy_seperator)
endfunc

command! TidyMarkdownTable call TidyMarkdownPipeTable()
