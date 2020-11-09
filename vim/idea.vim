" include defaults from my actual vim config such as leader etc
source ~/.config/nvim/config.vim

" set bookmarks with Ctrl+Shift+Number and navigate using Ctrl+Number

nmap <leader>ld :action GotoDeclaration<CR>
nmap <leader>lc :action GotoClass<CR>
nmap <leader>cc :action CommentByLineComment<CR>
nmap <leader>lf :action ReformatCode<CR>
nmap <leader>fs :action ToggleFullScreen<CR>

" go through completion options

nmap <C-+> :action EditorIncreaseFontSize<CR>
nmap <leader>++ :action EditorIncreaseFontSize<CR>
nmap <leader>-- :action EditorDecreaseFontSize<CR>

nmap <leader>dd :action Debug<CR>
nmap <leader>B :action ToggleLineBreakpoint<CR>
nmap <leader>bb :action BuildArtifact<CR>
nmap <leader>rr :action Run<CR>
nmap <leader>ot :action ActivateTerminalToolWindow<CR>

" hide the currently focused window
nmap <leader>hw :action HideActiveWindow<CR>
nmap <leader>hh :action Back<CR>
nmap <leader>ll :action Forward<CR>

" open run config window
nmap <leader>er :action editRunConfigurations<CR>

" tab navigation
map <silent> <F5> :action PreviousTab<CR>
map <silent> <F6> :action NextTab<CR>

" Window navigation (different to actual nvim)
" todo to make this work, all C-H prefix keys must be removed in clion -> export all clion configs?
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap <C-H> <C-W>h
nnoremap <A-L> <CR>

nnoremap <leader>w <C-W>
nnoremap <leader>ws  :split<CR>
nnoremap <leader>w+ :action IncrementWindowHeight<CR>
nnoremap <leader>w- :action DecrementWindowHeight<CR>
nnoremap <leader>wv  :vsplit<CR>
nnoremap <leader>w< :action IncrementWindowWidth<CR>
nnoremap <leader>w> :action DecrementWindowWidth<CR>

" Vim settings
set ignorecase             " case insensitive searching
set smartcase              " case-sensitive if expresson contains a capital letter
set title                  " set terminal title
set noswapfile             " disable swap files
set expandtab              " insert spaces rather than tab for <Tab>
set smarttab               " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
set showmode               " show current vim mode in status bar
set tabstop=4              " the visible width of tabs
set softtabstop=4          " edit as if the tabs are 4 characters wide
set shiftwidth=4           " number of spaces to use for indent and unindent
set shiftround             " round indent to a multiple of 'shiftwidth'
set number                 " show line numbers
set nocompatible           " not compatible with vi
set colorcolumn=121        " column delimiter
set foldlevel=99           " opens all folds up to the given level when opening file
set foldmethod=syntax      " use for cpp and c files, python uses indent
set list!                   " show all characters
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
" set list listchars=tab:-\ \,trail:¬∑ "set points after
set guifont=Monaco:h20
"
