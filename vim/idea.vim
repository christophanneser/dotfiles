" include defaults from my actual vim config such as leader etc
source ~/.config/nvim/config.vim

nmap <leader>ld :action GotoDeclaration<CR>
nmap <leader>lc :action GotoClass<CR>
nmap <leader>cc :action CommentByLineComment<CR>
nmap <leader>rc :action ReformatCode<CR>

nmap <leader>dd :action Debug<CR>
nmap <leader>bb :action ToggleLineBreakpoint<CR>
nmap <leader>rr :action Run<CR>


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
