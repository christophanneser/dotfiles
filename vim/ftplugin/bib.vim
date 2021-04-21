" Line Separators
nnoremap <leader>s i%---------------------------------------------------------------------------<ESC>

" open referenced pdfs (yank into register z, which is then subsituted in the open command)
nnoremap <C-P> "zyy:!okular <C-r>=substitute(substitute(@z,'.*pdf[^{]*{\([^}]*\)}.*','\1',''),'\s','\\ ','g')<CR> &<CR><CR>

" Custom comment characters for bibtex
setlocal comments=sO:%\ -,mO:%\ \ ,eO:%%,:%
setlocal commentstring=\%\ %s
