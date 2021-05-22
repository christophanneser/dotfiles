" Custom mappings for LaTex files
" Line Separators
nnoremap <leader>s i%---------------------------------------------------------------------------<ESC>

nnoremap <leader>m :w <bar> silent exec "!make"<CR>
nnoremap <leader>p :w <bar> silent exec "!pdflatex %"<CR>

" 98 -> b, 99 -> c, 100 -> d, 101 -> e, 105 -> i
" find out mappings with :echo char2nr("c")
let g:surround_98 = "\\textbf{\r}"
let g:surround_99 = "\\changes{\r}"
let g:surround_100 = "\\deleted{\r}"
let g:surround_101 = "\\emph{\r}"
let g:surround_105 = "\\textit{\r}"
