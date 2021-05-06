nnoremap <silent> <leader>u :UndotreeToggle<CR>

let g:undotree_HighlightChangedText=0
let g:undotree_SetFocusWhenToggle=1
let g:undotree_WindowLayout=2
let g:undotree_DiffCommand='diff -u'

" Mappings to emulate Gundo behavior.
function! g:Undotree_CustomMap()
  " Normally j, k just move and J, K actually revert; lets make j, k revert too.
  nnoremap <buffer> j <Plug>UndotreeGoPreviousState
  nnoremap <buffer> k <Plug>UndotreeGoNextState

  " Equivalent to `g:gundo_close_on_revert=1`:
  nnoremap <buffer> <Return> <Plug>UndotreeClose
endfunction

let g:undotree_WindowLayout = 4

