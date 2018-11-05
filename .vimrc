" ------------------------------------------------------------------------
" Fundamental, universe changing option
" ------------------------------------------------------------------------
set nocompatible

" ------------------------------------------------------------------------
" Pathtogen
" ------------------------------------------------------------------------
execute pathogen#infect()

" ------------------------------------------------------------------------
" Syntax highlighting and other syntactic goodies
" ------------------------------------------------------------------------
filetype on
filetype plugin on
filetype indent on
if &t_Co > 2 || has( "gui_running" )
    syntax enable
endif


" ------------------------------------------------------------------------
" Vim options
" ------------------------------------------------------------------------

" Display options
set background=light    " I hate bold fonts, which is what dark uses
"set display=uhex        " Show unprintables as hexadecimal
set noequalalways       " Don't automatically re-arrange my windows for me
set noerrorbells        " Big, red errors don't need beeps
set nohlsearch          " Highlighting search terms is ugly and horrible
set incsearch           " Show the matches as I type - good for debugging
set laststatus=2        " Always show the status line defined below
set listchars=eol:$,tab:>-,trail:~,extends:@,precedes:@
set scrolloff=5         " I hate working at screen edges - show some context
set showcmd             " Show partial commands as they are typed
if v:version < 700
    " Superceded in Vim7 by pi_matchparen
    set showmatch           " Indicate matching bracketing characters
endif
set statusline=%F\ %m%r\ \ %y%=\ L%-5.5l\ C%-3.3v\ %3.3p%%\ \
set wildmode=longest,list

" Editing options
set backspace=indent,eol,start  " Backspace over everything
if has( "unix" )                " Unix has a dictionary file for c-x c-k
    set dictionary=/usr/share/dict/words
end
set nodigraph                   " Digraphs result in a lot of accidents
set hidden                      " Hide orphaned buffers, rather than destroy
"if has( "mouse" )
"    set mouse=a                 " Full mouse use, if supported
"end
set whichwrap=b,s,<,>,[,]       " These keys can wrap over line breaks

" File options
set nobackup                    " CVS is for backups
set fileformats=unix,dos,mac    " Just recognize it, don't be fussy
set path=.,./**,,**
set sessionoptions+=resize      " Save full windows sizes in session data
set tags=./.ctags.local;,./tags;,./TAGS;     " Find tags files in or above the file dir

" Formatting options
set autoindent                  " autoindent works quite well if set right
set cinoptions=j1,(0,U1,W1s     " Sensible formatting
set expandtab                   " *NO* hard tabs, thank you.
set formatoptions=tcorqn2       " Complicated automatic formatting
set shiftround                  " Round tabbing to a multiple of shiftwidth
set shiftwidth=4                " Shift things by four spaces with < >
set softtabstop=4               " SOFT tab stops at 4 characters
set textwidth=78                " Not 80, many terminals can't handle that
if exists( "&formatlistpat" )   " Vim7 goodness for fixing formatoption+=n
    set formatlistpat=^\\s\\+\\d\\+[\\]:.)}\\t]\s\\+
endif

" GUI options
set guioptions=acigr            " Text-only GUI with scrollbars and icons
set guicursor=a:block-blinkwait0-Cursor/lCursor " Xterm-style block cursor

" Show line numbers
set number

match error /\s\+$/

" Language options
if has( "spell" )
    "set spell                   " Vim7 introduces flyspelling
    set spelllang=en_gb         " Vim7 introduces flyspelling
endif

" ------------------------------------------------------------------------
" Keyboard Mappings
" ------------------------------------------------------------------------
" Change <Leader> to something LaTeX safe for insert mode
" As of 20050530 ctrl-_ is only used in command mode for Hebrew
let mapleader="\x1f"

" Paste mode quick toggle key
set pastetoggle=<Leader>p

" Standards fix - make Y more like C and D and less like S
nmap Y y$

" Quick buffer changes - no finger contortions
nmap gb <c-^>

" Quick spelling fixing
map <Leader>f <Plug>SpellkeyFixAndReturn
imap <Leader>f <Plug>SpellkeyFixAndReturn

" Quick append )
map <Leader>) ])$hi) <esc>
imap <Leader>) <esc>])$hi)

" Find cursor
if exists( "&cursorline" )
    map <silent> gc :let &cursorline = !&cursorline<cr>:let &cursorcolumn = !&cursorcolumn<cr>
    imap <silent> <Leader>gc <c-o>:let &cursorline = !&cursorline<cr><c-o>:let &cursorcolumn = !&cursorcolumn<cr>
endif


" ------------------------------------------------------------------------
" Highlighting - syntax colours and effects
" ------------------------------------------------------------------------

" Console colour settings
highlight Cursor            ctermfg=red        ctermbg=red     cterm=NONE
highlight DiffAdd           ctermfg=black      ctermbg=cyan    cterm=NONE
highlight DiffChange        ctermfg=black      ctermbg=blue    cterm=NONE
highlight DiffDelete        ctermfg=black      ctermbg=yellow  cterm=NONE
highlight DiffText          ctermfg=black      ctermbg=red     cterm=NONE
highlight Error             ctermfg=white      ctermbg=darkred cterm=bold
highlight ErrorMsg          ctermfg=white      ctermbg=darkred cterm=bold
highlight FoldColumn        ctermfg=black      ctermbg=grey    cterm=NONE
highlight Folded            ctermfg=green      ctermbg=NONE    cterm=NONE
highlight Pmenu             ctermfg=NONE       ctermbg=NONE    cterm=reverse
highlight PmenuSbar         ctermfg=NONE       ctermbg=NONE    cterm=reverse
highlight PmenuSel          ctermfg=black      ctermbg=yellow  cterm=NONE
highlight PmenuThumb        ctermfg=red        ctermbg=red     cterm=NONE
highlight Search            ctermfg=black      ctermbg=yellow  cterm=NONE
highlight SpellBad          ctermfg=darkred    ctermbg=NONE    cterm=underline
highlight SpellCap          ctermfg=NONE       ctermbg=NONE    cterm=underline
highlight SpellLocal        ctermfg=darkyellow ctermbg=NONE    cterm=underline
highlight SpellRare         ctermfg=darkyellow ctermbg=NONE    cterm=underline
highlight TabLine           ctermfg=NONE       ctermbg=NONE    cterm=NONE
highlight TabLineFill       ctermfg=NONE       ctermbg=NONE    cterm=NONE
highlight TabLineSel        ctermfg=NONE       ctermbg=NONE    cterm=reverse
highlight Visual            ctermfg=NONE       ctermbg=NONE    cterm=reverse
" Plugin highlighting
highlight MatchParen        ctermfg=NONE       ctermbg=NONE    cterm=underline
highlight MBENormal         ctermfg=NONE       ctermbg=NONE    cterm=NONE
highlight MBEChanged        ctermfg=NONE       ctermbg=NONE    cterm=NONE
highlight MBEVisibleNormal  ctermfg=NONE       ctermbg=NONE    cterm=reverse
highlight MBEVisibleChanged ctermfg=NONE       ctermbg=NONE    cterm=reverse

" GUI colour settings
" highlight Normal            guifg=#a8a8a8      guibg=#202020   gui=NONE
" highlight Cursor            guifg=NONE         guibg=#ff0000   gui=NONE
" highlight DiffAdd           guifg=#000000      guibg=#72d5d5   gui=NONE
" highlight DiffChange        guifg=#000000      guibg=#7e9dfc   gui=NONE
" highlight DiffDelete        guifg=#000000      guibg=#c6c68b   gui=NONE
" highlight DiffText          guifg=#000000      guibg=#e68282   gui=NONE
" highlight Error             guifg=#000000      guibg=#e68282   gui=bold
" highlight FoldColumn        guifg=#000000      guibg=#aaaaaa   gui=NONE
" highlight Folded            guifg=#7e9dfc      guibg=NONE      gui=NONE
" highlight Pmenu             guifg=NONE         guibg=NONE      gui=reverse
" highlight PmenuSbar         guifg=NONE         guibg=NONE      gui=reverse
" highlight PmenuSel          guifg=#000000      guibg=#c6c68b   gui=NONE
" highlight PmenuThumb        guifg=#e68282      guibg=#e68282   gui=NONE
" highlight Search            guifg=#000000      guibg=#c6c68b   gui=NONE
" highlight SpellBad          guifg=#e68282      guibg=NONE      gui=underline
" highlight SpellCap          guifg=NONE         guibg=NONE      gui=underline
" highlight SpellLocal        guifg=#c6c68b      guibg=NONE      gui=underline
" highlight SpellRare         guifg=#c6c68b      guibg=NONE      gui=underline
" highlight TabLine           guifg=NONE         guibg=NONE      gui=reverse
" highlight TabLineFill       guifg=NONE         guibg=NONE      gui=reverse
" highlight TabLineSel        guifg=NONE         guibg=NONE      gui=bold
" highlight Visual            guifg=NONE         guibg=NONE      gui=reverse
" " Plugin highlighting
" highlight MatchParen        guifg=NONE         guibg=NONE      gui=reverse
" highlight MBENormal         guifg=NONE         guibg=NONE      gui=NONE
" highlight MBEChanged        guifg=NONE         guibg=NONE      gui=NONE
" highlight MBEVisibleNormal  guifg=NONE         guibg=NONE      gui=reverse
" highlight MBEVisibleChanged guifg=NONE         guibg=NONE      gui=reverse


" ------------------------------------------------------------------------
" Syntax highlighting / display variables
" ------------------------------------------------------------------------
let g:java_highlight_java_lang_ids  = 1 " Global class names
let g:java_highlight_debug          = 1 " Highlight nasty print statements
let g:java_allow_cpp_keywords       = 1 " I'm not an idiot, ta

let g:perl_fold                     = 1 " Syntax folding
let g:perl_extended_vars            = 1 " Parse complicated expressions
let g:perl_no_scope_in_variables    = 1 " No strange qualified name highlight
let g:perl_include_pod              = 1 " Unknown

let g:tex_fold_enabled              = 1 " Syntax folding

let g:xml_syntax_folding            = 1 " Syntax folding


" ------------------------------------------------------------------------
" Plugins
" ------------------------------------------------------------------------

" MiniBufExplorer
let g:miniBufExplTabWrap               = 1      " Tabs all on one line
let g:miniBufExplorerMoreThanOne       = 2      " Open at X buffers
let g:did_minibufexplorer_syntax_inits = 1      " I've set the colours, ta

" Texinfo
let g:texinfo_foldtext_verbose         = 3


" ------------------------------------------------------------------------
" Autocommands
" ------------------------------------------------------------------------

" Universal autocommands
augroup universal
    if has("autocmd") && exists("+omnifunc")
        autocmd Filetype *
                    \	if &omnifunc == "" |
                    \		setlocal omnifunc=syntaxcomplete#Complete |
                    \	endif
    endif
augroup END

" Universal structured text file autocommands
augroup structured_text
    " Clear all commands for this group to enable reload safety
    autocmd!

    " Formatting options
    autocmd FileType html,jsp,latex,tex,txt,xml,xsd setl shiftwidth=2
    autocmd FileType html,jsp,latex,tex,txt,xml,xsd setl softtabstop=2
    autocmd FileType html,jsp,latex,tex,txt         setl textwidth=74

    " Language options
    if has( "spell" )
        " Enforce spelling settings for certain files regardless of the global
        " setting, but do make sure that help files are not checked if the
        " global setting enforces checking.
        autocmd FileType html,jsp,latex,tex,txt    setl spell
        autocmd FileType help                      setl nospell
    endif

    " Search options
    autocmd FileType html,jsp,latex,tex,txt setl ignorecase
    autocmd FileType html,jsp,latex,tex,txt setl smartcase
augroup END

" JSP autocommands
augroup jsp
    autocmd FileType jsp set indentexpr=HtmlIndentGet(v:lnum)
augroup END

" (La)Tex file autocommands
augroup tex_files
    " Clear all commands for this group to enable reload safety
    autocmd!

    " UTF-8 is nice, shame TeX doesn't support it, in general
    autocmd FileType tex setl fileencoding=latin3
augroup END

" Ant file autocommands
augroup ant
    autocmd!

    " Use Ant 1.6.x with xmlcomplete
    autocmd FileType ant XMLns ant16x
augroup END

" Universal code file autocommands
augroup code
    " Clear all commands for this group to enable reload safety
    autocmd!

    " If the filetype plugin doesn't provide a sensible indentexpr setting then
    " at least have a go with C-style indentation
    autocmd FileType c,c++,java,perl    setlocal cindent
    autocmd FileType c,c++,java,perl    setlocal foldmethod=syntax

    " Set up project paths for :find use
    autocmd FileType c,c++,java,perl    call <SID>munge_path_option()
augroup END

" ------------------------------------------------------------------------
" Scripting
" ------------------------------------------------------------------------

" Mac OS X is a pain for not starting in ~
" There is little reason to ever start in / legitmately when running the GUI
" on OS X, so script it back to home
if getcwd() == "/" && has("gui_mac") && has("gui_running")
    cd ~
endif

" XXX this function should text the %:p:h against the current path and append
" any completely new paths and cope with parents.
function! s:munge_path_option()
    setlocal path=
"    if &g:path == ''
"        let &g:path=expand('%:p:h') . "/**"
"    endif
endfunction

function! s:fix_and_append()
    let mode = mode()
    if l:mode != "i"
        normal! as$
    else
        normal! isA
    endif
endfunction
map  <silent> <Plug>SpellkeyFixAndReturn :call <SID>fix_and_append()<cr>
imap <silent> <Plug>SpellkeyFixAndReturn <c-o>:call <SID>fix_and_append()<cr>

" HTML Typprograhy function, mostly for Ahpag
function! HTMLTypography()
    %s/``/\&#8220;/ge
    %s/''/\&#8221;/ge
    %s/'/\&#8217;/ge
    %s/`/\&#8216;/ge
    %s/-\{3\}/\&#8212;/ge
    %s/-\{2\}/\&#8211;/ge
    %s/\.\{3\}/\&#8230;/ge
endfunction
command! HTMLTypography :call HTMLTypography()


" ------------------------------------------------------------------------
" Resources -- Vim related, but external
" ------------------------------------------------------------------------

" .Xdefaults -- settings for XTerm et al
" --------------------------------------
" ! Colours:  1 Red    2 Green  3 Yellow  4 Blue  5 Magenta  6 Cyan
" !           7 LGrey  8 DGrey
" XTerm*background:         #1e1e1e
" XTerm*foreground:         #d3d3d3
" XTerm*cursorColor:        red
" XTerm*color0:             black
" XTerm*color1:             #e68282
" XTerm*color2:             #8cd78c
" XTerm*color3:             #c6c68b
" XTerm*color4:             #7e9dfc
" XTerm*color5:             #bd96f8
" XTerm*color6:             #72d5d5
" XTerm*color7:             #aaaaaa
" XTerm*color8:             #909090
" XTerm*color9:             #ff7878
" XTerm*color10:            #72d5bf
" XTerm*color11:            #c6c68b
" XTerm*color12:            #579afc
" XTerm*color13:            #bd96f8
" XTerm*color14:            #72d5d5
" XTerm*utf8:               1
" XTerm*locale:             no
" XTerm*termName:           xterm-color
" XTerm*scrollTtyOutput:    false

" Tagfile rebuilder:
" * moodle/tags will not be rebuilt;
" * other tags files in moodle/ will be rebuilt in the background and
"   atomically installed; and
" * everything else gets the normal treatment.
let g:Rebuild_Tagfiles_Commands =
    \ [
        \ [ '/TAGS', 'true' ],
        \ [ '/tags', 'true' ],
        \ [ 'moodle/', '(cd `dirname "{file}"` && ctags -R -o "{file}.tmp" ; mv "{file}.tmp" "{file}") &' ],
        \ [ '', 'cd `dirname "{file}"` && ctags -R -o "{file}"' ]
    \ ]

if v:version >= 700
    function! s:path_from_tagfiles()
        let l:path = join(
            \           map(tagfiles(),
            \               'fnamemodify(v:val, ":p:h") . "/**"'),
            \           ',')

        if stridx(&l:path, l:path) == -1
            let &l:path = l:path . ',' . &l:path
        endif
    endfunction

    function! Rebuild_Tagfiles()
        for l:tagfile in tagfiles()
            " Calling isdirectory() may look a bit silly here, but tagfiles()
            " does return directories in some versions of Vim.
            if filewritable(l:tagfile) && ! isdirectory(l:tagfile)
                let l:tagfile = fnamemodify(l:tagfile, ':p')
                for l:cmd in g:Rebuild_Tagfiles_Commands
                    if match(l:tagfile, l:cmd[0]) != -1
                        let l:syscmd = substitute(l:cmd[1], '{file}',
                                                    \ l:tagfile, 'g')
                        let l:output = system(l:syscmd)
                        if v:shell_error != 0
                            echoerr "Command '" . l:syscmd . "' exited "
                                        \ . v:shell_error . ': ' . l:output
                        endif

                        break
                    endif
                endfor
            endif
        endfor
    endfunction
    if ! exists('g:Rebuild_Tagfiles_Commands')
        let g:Rebuild_Tagfiles_Commands =
            \ [
                \ [ '^use this if your ctags takes too long and/or you need an atomic ctags file installation', '(cd `dirname "{file}"` && ctags -R -o "{file}.tmp" ; mv "{file}.tmp" "{file}") &' ],
                \ [ '', 'cd `dirname "{file}"` && ctags -R -o "{file}"' ]
            \ ]
    endif
endif

augroup universal-priority
    autocmd!

    " Set up project paths for things like :find and ins-completion using
    " whole-tree glob expansion.
    "
    " This is done in two different ways.  The first one is the correct way,
    " the second is a hack around ftplugins which replace the path setting
    " wholesale on the assumption that they know best.  (I have nothing
    " against type-specific paths, but the local project should really have
    " priority.)
    if v:version >= 700
        autocmd BufNewFile,BufReadPre * call <sid>path_from_tagfiles()
        autocmd FileType *              call <sid>path_from_tagfiles()
        autocmd BufWritePost,FileWritePost,FileAppendPost *
                                    \   call Rebuild_Tagfiles()
    endif
augroup END
