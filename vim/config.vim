call plug#begin()
Plug 'itchyny/lightline.vim'                " bottom status bar
Plug 'rhysd/vim-clang-format'               " clang format
Plug 'scrooloose/nerdtree'                  " NERDTree
Plug 'Xuyuanp/nerdtree-git-plugin'	    " NERDTree git plugin
Plug 'justmao945/vim-clang'	   	    " nvim clang automation

" Clang-Format
" let g:clang_format#command = '~/.local/bin/clang-format'
" let g:clang_format#detect_style_file = 1
let g:clang_format#auto_format = 1

" NERDTree nmap
nmap <C-n> :NERDTreeToggle<CR>
call plug#end()
