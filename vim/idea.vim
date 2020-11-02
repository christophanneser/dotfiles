" include defaults from my actual vim config such as leader etc
source ~/.config/nvim/config.vim

" set bookmarks with Ctrl+Shift+Number and navigate using Ctrl+Number

nmap <leader>ld :action GotoDeclaration<CR>
nmap <leader>lc :action GotoClass<CR>
nmap <leader>cc :action CommentByLineComment<CR>
nmap <leader>rc :action ReformatCode<CR>
nmap <leader>fs :action ToggleFullScreen<CR>

nmap <C-J> :action EditorDownWithSelection<CR>
nmap <C-M> :action EditorUpWithSelection<CR>

nmap <C-+> :action EditorIncreaseFontSize<CR>
nmap <leader>++ :action EditorIncreaseFontSize<CR>


nmap <leader>dd :action Debug<CR>
nmap <leader>B :action ToggleLineBreakpoint<CR>
nmap <leader>bb :action BuildArtifact<CR>
nmap <leader>rr :action Run<CR>
nmap <leader>ot :action ActivateTerminalToolWindow<CR>

" hide the currently focused window
nmap <leader>hw :action HideActiveWindow<CR>
nmap <leader>hh :action Back<CR>
nmap <leader>ll :action Forward<CR>

" tab navigation
map <silent> <F5> :action PreviousTab<CR>
map <silent> <F6> :action NextTab<CR>

" Window navigation (different to actual nvim)
" todo to make this work, all C-H prefix keys must be removed in clion -> export all clion configs?
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-L> <C-W>l
map <C-H> <C-W>h

" Vim settings
set ignorecase             " case insensitive searching
set smartcase              " case-sensitive if expresson contains a capital letter
set title                  " set terminal title
set noswapfile             " disable swap files
set expandtab              " insert spaces rather than tab for <Tab>
set smarttab               " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
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
" set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set list listchars=tab:-\ \,trail:¬∑ "set points after
set guifont=Monaco:h20
"
