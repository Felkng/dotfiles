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

"Add relative lines
set relativenumber

"Add statusline
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

" Function to format Git branch for the status line
function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0 ? '   '.l:branchname.' ' : ''
endfunction

" Function to convert Vim's internal mode to full names
function! FullMode()
  let l:mode = mode()
  if l:mode ==# 'n'
    return 'NORMAL'
  elseif l:mode ==# 'i'
    return 'INSERT'
  elseif l:mode ==# 'v'
    return 'VISUAL'
  elseif l:mode ==# 'V'
    return 'V-LINE'
  elseif l:mode ==# '␖'  " This is the visual block mode symbol
    return 'V-BLOCK'
  elseif l:mode ==# 'c'
    return 'COMMAND'
  elseif l:mode ==# 'R'
    return 'REPLACE'
  elseif l:mode ==# 's'
    return 'SELECT'
  elseif l:mode ==# 't'
    return 'TERMINAL'
  else
    return 'UNKNOWN'
  endif
endfunction

" Custom status line setup
set statusline=
set statusline+=%f\              " File path
set statusline+=%{FullMode()}    " Current mode
set statusline+=%{StatuslineGit()} " Git branch
set statusline+=\ %y             " File type
set statusline+=\ %m             " Modified flag
set statusline+=%r               " Read-only flag
set statusline+=%=%c,%l/%L       " Cursor position (column and line/total lines)

" Always show the status line
set laststatus=2

function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

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

call plug#end()


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
