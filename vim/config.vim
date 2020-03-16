call plug#begin()

Plug 'autozimu/LanguageClient-neovim', {
    \ 'commit': 'ec4af74',
    \ 'do': 'bash install.sh',
    \ }                                     " languageserver
Plug 'itchyny/lightline.vim'                " bottom status bar
Plug 'rhysd/vim-clang-format'               " clang format
Plug 'scrooloose/nerdtree'                  " NERDTree
Plug 'Xuyuanp/nerdtree-git-plugin'	    " NERDTree git plugin
Plug 'justmao945/vim-clang'	   	    " nvim clang automation
Plug 'xavierd/clang_complete'		    " clang complete for cpp

" Language server config follows todo!
let g:LanguageClient_serverCommands = {
  \ 'cpp': ['clangd'],
  \ 'python': ['/home/christoph/.local/bin/pyls', 'v'],
  \ }

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" Clang-Format
let g:clang_format#auto_format = 1

call plug#end()

" NERDTree nmap
nmap <C-n> :NERDTreeToggle<CR>

" Window navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
