function! TexinfoFoldexpr(...)
    if a:0 > 0
        let l:lineno = a:1
    else
        let l:lineno = v:lnum
    end

    let l:line = getline(l:lineno)

    if l:line =~ '^@node'
        let l:line = getline(l:lineno+1)
    endif

    if strpart(l:line, 0, 1) != '@' || getline(l:lineno-1) =~ '^@node'
        return '='
    elseif l:line =~ '^@\(top\|chapter\|unnumbered\|appendix\s\|bye\)'
        return '>1'
    elseif l:line =~ '^@\(section\|appendixsec\)'
        return '>2'
    elseif l:line =~ '^@\(subsection\|appendixsubsec\)'
        return '>3'
    elseif l:line =~ '^@\(subsubsection\|appendixsubsubsec\)'
        return '>4'
    else
        return '='
    endif
endfunction

function! TexinfoFoldtext()
    let l:preview = getline(v:foldstart)

    if l:preview =~ '^@node'
        let l:preview = getline(v:foldstart+1)
    endif

    if exists('g:texinfo_foldtext_verbose')
        if g:texinfo_foldtext_verbose == 4
            let l:text = substitute(l:preview, '@\w\+\s*', '', '')
            let l:type = substitute(l:preview, '\s.*', '', '')
            let l:textwidth = winwidth(0) - 40

            return printf(
                        \ '+-%-4s% 4d lines: '
                        \ . '%-' . l:textwidth . '.' . l:textwidth . 's %-19s',
                        \ v:folddashes, (v:foldend-v:foldstart), l:text, l:type)
        elseif g:texinfo_foldtext_verbose == 3
            let l:text = substitute(l:preview, '@\w\+\s*', '', '')
            let l:type = substitute(l:preview, '\s.*', '', '')
            let l:textwidth = winwidth(0) - 40

            return printf(
                        \ '+-%s% 4d lines: '
                        \ . '%-' . l:textwidth . '.' . l:textwidth . 's %-19s',
                        \ v:folddashes, (v:foldend-v:foldstart), l:text, l:type)
        elseif g:texinfo_foldtext_verbose == 1
            let l:preview = substitute(l:preview, '@\w\+\s*', '', '')
            return printf(
                        \ '+-%-4s% 4d lines: %s',
                        \ v:folddashes, (v:foldend-v:foldstart), l:preview)
        elseif g:texinfo_foldtext_verbose == 0
            let l:preview = substitute(l:preview, '@\w\+\s*', '', '')
        endif
    endif

    return '+-'
                \ . v:folddashes
                \ . printf('% 4d', v:foldend-v:foldstart)
                \ . ' lines: '
                \ . l:preview
endfunction

setlocal foldmethod=expr
setlocal foldexpr=TexinfoFoldexpr()
setlocal foldtext=TexinfoFoldtext()
