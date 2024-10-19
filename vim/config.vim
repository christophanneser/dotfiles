"---------------------------------------------------------------------------
" Plugins
"---------------------------------------------------------------------------
if !exists("g:idea_vim") " enable plugins only if this is not ideavim
call plug#begin()
if has('nvim')                              " deoplete
    Plug 'Shougo/deoplete.nvim', {
        \ 'commit': '18788fc822abd1ac1ffc1a8189afbfae15d06cf9',
        \ 'do': ':UpdateRemotePlugins',
        \ }
else
    Plug 'Shougo/deoplete.nvim', {
        \ 'commit': '18788fc822abd1ac1ffc1a8189afbfae15d06cf9',
        \ 'do': ':UpdateRemotePlugins',
        \ }
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'zchee/deoplete-jedi'                  " auto-completion for python
Plug 'lervag/vimtex'                        " auto-completion for vimtex
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }                                     " languageserver
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'enricobacis/vim-airline-clock'
Plug 'bling/vim-bufferline'
Plug 'tpope/vim-surround'                   " For nice surrounding functionality
Plug 'tpope/vim-repeat'                     " Repeat commands (.) also for plugins
Plug 'tpope/vim-abolish'                    " Convert between different cases -> snakecase to camelCase etc.
Plug 'scrooloose/nerdtree'                  " NERDTree
Plug 'Xuyuanp/nerdtree-git-plugin'	        " NERDTree git plugin
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'justmao945/vim-clang'	  , {'for': 'rust'} 	            " nvim clang automation
Plug 'preservim/nerdcommenter'              " easy multiline commenting
Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh \| UpdateRemotePlugins', 'for': 'cpp'}
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'sbdchd/neoformat'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Fuzzy search
Plug 'junegunn/fzf.vim'
Plug 'rust-lang/rust.vim', {'for': 'rust'}  " rustfmt
Plug 'mechatroner/rainbow_csv'
Plug 'rhysd/vim-grammarous'                 " Grammar checker
Plug 'tpope/vim-fugitive'                   " Git integration
" Different color-schemes:
Plug 'sainnhe/edge'
Plug 'sainnhe/sonokai'
Plug 'sainnhe/gruvbox-material'
" Plug 'file://'.expand('~/.vim/vim/plugged/baseconverter')
call plug#end()
endif
"---------------------------------------------------------------------------
" Alternate map leader
let mapleader = ','
let g:mapleader = ','


" Alternate saving with C-s
noremap <silent> <C-S>  :update<CR>
vnoremap <silent> <C-S> <C-C>:update<CR>
inoremap <silent> <C-S> <C-O>:update<CR>
" Faster save and exit with :x (does not write if there were no changes)

" Cursor History
"   - go to previous position: <C-O>
"   - go to next position: <C-I>

" Scrolling
nnoremap <leader>d <C-d>
nnoremap <leader>u <C-u>

" Language server config
" Important: .compile_commands.json must be in root directory
let g:LanguageClient_serverCommands = {
  \ 'c': ['/bin/ccls'],
  \ 'cpp': ['/bin/ccls'],
  \ 'plaintex': ['~/.cargo/bin/texlab'],
  \ 'python': ['~/.local/bin/pyls'],
  \ 'rust': ['rust-analyzer'],
  \ 'sh': ['bash-language-server', 'start'],
  \ 'tex': ['~/.cargo/bin/texlab']
  \ }

" Lanugage client shortcuts
let g:LanguageClient_autoStart = 1
let g:LanguageClient_diagnosticsEnable = 1
set hidden
set formatexpr=LanguageClient_textDocument_rangeFormatting()
nnoremap <leader>ld :call LanguageClient#textDocument_definition()<CR>
nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
nnoremap <leader>la :call LanguageClient_workspace_applyEdit()<CR>
nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>

" reload language server after compiling
nnoremap <leader>lj :LanguageClientStop <CR>
nnoremap <leader>lk :LanguageClientStart <CR>

let g:deoplete#enable_at_startup = 1
" let g:deoplete#custom#source('LanguageClient', 'sorters', [])

" REMAPS: refer to https://stackoverflow.com/a/3776182
"nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" Important!!
if has('termguicolors')
  set termguicolors
endif

" The configuration options should be placed before `colorscheme edge`.
let g:sonokai_style = 'andromeda'
let g:sonokai_better_performance = 1

" colorscheme sonokai
colorscheme gruvbox-material
"
" Clang-Format
" let g:clang_format#auto_format = 1
" let g:clang_format#detect_style_file = 1
" let g:clang_format#auto_format_on_insert_leave = 0
" " vim-clang overrides clang-format command
" let g:clang_enable_format_command = 0
"
" autocmd FileType c,cpp,objc map <buffer><C-f> :ClangFormat<CR>
" autocmd FileType c,cpp,objc imap <buffer><C-f> <ESC>:ClangFormat<CR>i
"
" FZF driven search
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>g :GFiles<CR>
nnoremap <silent> <leader>l :BLines<CR>
nnoremap <silent> <leader>rg :Rg<CR>

" NVIM Internal Spell Checker
:setlocal spell spelllang=en_us

" neoformat
let g:neoformat_enabled_python = ['autopep8']

" vimtex
let g:vimtex_complete_enabled = 1

" NERDTree nmap
let g:NERDTreeShowHidden = 1
let g:NERDTreeWinSize = 40 
nmap <C-n> :NERDTreeToggle<CR>

" Vim Surroundings
nmap <silent> dsa ds}dF\

" Window navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"Window splits
nnoremap <leader>w <C-W>
nnoremap <leader>ws  :split<CR>
nnoremap <leader>w+ :exe "resize " . (winheight(0) * 12/10)<CR>
nnoremap <leader>w- :exe "resize " . (winheight(0) * 8/10)<CR>
nnoremap <leader>wv  :vsplit<CR>
nnoremap <leader>w< :exe "vertical resize " . (winwidth(0) * 12/10)<CR>
nnoremap <leader>w> :exe "vertical resize " . (winwidth(0) * 8/10)<CR>


map <silent> <F4> :!cd ~/bao-paper && ./compile.sh<CR>

"Buffer navigation
map <silent> <F5> :bp!<CR>
map <silent> <F6> :bn!<CR>

" Yanking to clipboard
noremap <Leader>Y "+yy
noremap <Leader>P "+p

" Show suggestions
inoremap <C-Space> <C-N>

" Use always latex filetype ( rather than plaintex, or ConTeXt)
let g:tex_flavor='latex'

" Deoplete suggestion navigation
inoremap <expr><C-j> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr><C-l> pumvisible() ? "\<C-y>" : "\<C-l>"

" Code folding (https://vim.fandom.com/wiki/Folding)
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

" New fast compilation commands
" :com -nargs=1 Deb :!mkdir -p debug & cd debug; cmake -DCMAKE_BUILD_TYPE=DEBUG ..; make <args>
" :com -nargs=1 Rel :!mkdir -p release & cd release; cmake -DCMAKE_BUILD_TYPE=RELEASE ..; make <args>

" Trigger build using cmake
nmap <leader>cd :Deb<Space>
nmap <leader>cr :Rel<Space>
" Default separators
" nnoremap <leader>s i//---------------------------------------------------------------------------<ESC>

autocmd FileType vim nnoremap<buffer> <leader>s i"---------------------------------------------------------------------------<ESC>

" Commenting Plugin
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 2

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Markdown Plugin
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0

" Airline buffers at top
" let g:airline#extensions#bufferline#enabled = 1
let g:airline_extensions = ['tabline', 'bufferline', 'branch', 'clock']
" Enable arrows and special fonts used by airline
let g:airline_powerline_fonts = 1

com! FormatJSON %!python -m json.tool

" Create symlink to compile_commands
"nmap <leader>ln :!ln -s debug/compile_commands.json compile_commands.json

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
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set guifont=Monaco:h20
set spell spelllang=en_us   " enable spell checker and set default language to english
"
set cursorline
" hi Search ctermfg=white

" Remember folds when closing files
augroup remember_folds
  autocmd!
  autocmd BufWinLeave,BufLeave,BufWritePost,BufHidden,QuitPre ?* nested silent! mkview!
  autocmd BufWinEnter ?* silent! loadview
augroup END

" highlight todos
augroup HiglightTodo
    autocmd!
    autocmd WinEnter,VimEnter * :silent! call matchadd('GruvboxRedBold', '\(TODO\|todo\|ToDo\|Todo\|toDo\|[todo\).*', 'todo' -1)
    autocmd WinEnter,VimEnter * :silent! call matchadd('GruvboxBlueBold', '\(\~\~\).*', 'todo' -1)
    autocmd WinEnter,VimEnter * :silent! call matchadd('airline_error_bold', '\(FIXME\|fixme\).*', 'fixme' -1)
    autocmd WinEnter,VimEnter * :silent! call matchadd('GruvboxGreenBold', '\(DONE\|done\|[done\).*', 'done' -1)
    autocmd WinEnter,VimEnter * :silent! call matchadd('GruvboxOrangeBold', '\(in progress\|[in progress\).*', 'in progress' -1)
augroup END

filetype on
filetype plugin on

lua << EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
-- Custom highlight settings
vim.api.nvim_set_hl(0, "@keyword", { fg = "#fabd2f", bold = true })
vim.api.nvim_set_hl(0, "@function", { fg = "#b8bb26", italic = true })
vim.api.nvim_set_hl(0, "@comment", { fg = "#928374", italic = true })
EOF
