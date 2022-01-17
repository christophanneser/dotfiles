" Line Separators
nnoremap <leader>s i//---------------------------------------------------------------------------<ESC>

"nvim-gdb
nmap <M-b> :GdbBreakpointToggle<CR>
autocmd VimEnter * nnoremap <leader>dd :GdbStart gdb<CR> <bar> i"test"

