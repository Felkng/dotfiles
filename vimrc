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
set incsearch
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

"Add relative lines
set relativenumber

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

call plug#begin()

Plug 'preservim/nerdtree'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'tpope/vim-fugitive'

" Function to get the current Git branch

call plug#end()

if isdirectory(expand($HOME . '/.vim/plugged/vim-airline/'))
    let g:airline#extensions#tabline#enabled = 1
    let g:airline_powerline_fonts = 1
    set laststatus=2
    let g:airline_detect_paste=1
    let g:airline_detect_modified=1


endif


function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute ('LspDocumentFormatSync')
endfunction

augroup lsp_install
    au!
    "call s:on_lsp_buffer_enabled (set the lsp shortcuts) when an lsp server
    "is registered for a buffer
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

function! OnLspBufferEnabled() abort
    setlocal omnifunc=lsp#complete
endfunction

augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call OnLspBufferEnabled()
augroup END

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
