let g:AmsaykMkviewFiletypeBlacklist = [
  \ 'diff',
  \ 'gitcommit',
  \ 'hgcommit',
  \ 'list'
  \ ]

" Loosely based on: http://vim.wikia.com/wiki/Make_views_automatic
function! autocmds#should_mkview() abort
  return
        \ &buftype == '' &&
        \ index(g:AmsaykMkviewFiletypeBlacklist, &filetype) == -1 &&
        \ !exists('$SUDO_USER') " Don't create root-owned files.
endfunction

function! autocmds#mkview() abort
  if exists('*haslocaldir') && haslocaldir()
    " We never want to save an :lcd command, so hack around it...
    cd -
    mkview
    lcd -
  else
    mkview
  endif
endfunction

function! autocmds#escape_pattern(str) abort
  return escape(a:str, '~"\.^$[]*')
endfunction

function! autocmds#get_visual_selection()
  " Why is this not a built-in Vim script function?!
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction


function! autocmds#idleboot() abort
  " Make sure we automatically call autocmds#idleboot() only once.
  augroup Idleboot
    au!
  augroup END

  hi! link LspReferenceText CursorColumn
  hi! link LspReferenceRead CursorColumn
  hi! link LspReferenceWrite CursorColumn

  hi! SignColumn ctermfg=NONE guibg=NONE
  hi! NonText ctermbg=NONE guibg=NONE
  hi! LineNr ctermfg=NONE guibg=NONE
  hi! StatusLine guifg=#16252b guibg=#6699CC
  hi! StatusLineNC guifg=#16252b guibg=#16252b

  hi! VertSplit guifg=#fff
  hi! CursorLineNr gui=bold guifg=NONE guibg=NONE

  hi! Search guifg=#969896 guibg=#f0c674
  hi! IncSearch guifg=#282a2e guibg=#de935f
  hi! PMenuSel guifg=#282a2e guibg=#c5c8c6
  hi! Pmenu guibg='00010a' guifg=white

  " Make sure we run deferred tasks exactly once.
  doautocmd User AmsaykDefer
  au! User AmsaykDefer
endfunction
