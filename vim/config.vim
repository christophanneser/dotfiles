call plug#begin()
Plug 'itchyny/lightline.vim'                " bottom status bar
Plug 'rhysd/vim-clang-format'               " clang format
Plug 'scrooloose/nerdtree'                  " NERDTree
Plug 'Xuyuanp/nerdtree-git-plugin'	    " NERDTree git plugin
Plug 'justmao945/vim-clang'	   	    " nvim clang automation
Plug 'valloric/YouCompleteMe'		    " auto completion

let g:ycm_confirm_extra_conf    = 0
let g:ycm_global_ycm_extra_conf = '/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

" Clang-Format
let g:ycm_global_ycm_extra_conf = '~/Documents/dotfiles/vim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

" let g:clang_format#command = '~/.local/bin/clang-format'
" let g:clang_format#detect_style_file = 1
let g:clang_format#auto_format = 1

let g:ycm_python_binary_path = 'python'

call plug#end()

" NERDTree nmap
nmap <C-n> :NERDTreeToggle<CR>

" Window navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
