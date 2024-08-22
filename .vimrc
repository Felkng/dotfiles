"Vim configuration file"

"Enable mouse support"
set mouse=a

"Enable syntax"
syntax on

"Enable line numbers"
set number

"Highlight current line"
set cursorline
:highlight Cursorline cterm=bold ctermbg=black

"Enable highlight search pattern"
set hlsearch

"Enable smartcase search sensitivity"
set ignorecase
set smartcase

"Identation using spaces"
"tabstop: width of tab character
"softtabstop: fine tunes the amount of whitespaces to be added
"shiftwidth: determines the amount of whitespaces to add in normal mode
"expandtab: when on use space instead of tab
"textwidth: text wrap width
"autoident: autoident in new line
set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=79
set expandtab
set autoindent

"show the matching part of pairs [] {} and ()"
set showmatch

"remove trailing whitespace from Python and Fortran files"
autocmd BufWritePre *.py: %s/\s\+$//e

"enable color themes"
if !has('gui_running')
    set t_Co=256
endif

"enable tru colors support"
set termguicolors

"Vim colorscheme"
colorscheme spaceduck
