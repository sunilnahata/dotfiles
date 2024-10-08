" This file was obtained from: https://missing.csail.mit.edu/2020/files/vimrc
" Modified by: Sunil Nahata
" Comments in Vimscript start with a `"`.
set encoding=utf8               " Set utf8 as standard encoding and
set langmenu=en_US.UTF-8        " en_US as the standard language.
set fileencoding=utf-8
set termencoding=utf-8

" Plugin setup
" Set up vim-plug (if not present)
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source ~/.vimrc
endif

call plug#begin('~/.vim/plugged')

Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'
Plug 'christoomey/vim-tmux-navigator'
Plug 'jalvesaq/Nvim-R'
Plug 'gaalcaras/ncm-R'
Plug 'preservim/nerdtree'
Plug 'Raimondi/delimitMate'
Plug 'itchyny/lightline.vim'
Plug 'lervag/vimtex'
Plug 'dense-analysis/ale'
Plug 'nvie/vim-flake8'
Plug 'tpope/vim-fugitive'
Plug 'patstockwell/vim-monokai-tasty'

" All of your Plugins must be added before the following line
call plug#end()              " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
packadd comment
" Put your non-Plugin stuff after this line
let g:lightline = {
            \ 'active': {
            \ 'left': [ [ 'mode', 'paste' ],
            \           [ 'gitbranch', 'readonly', 'filename', 'modified'] ]
            \ },
            \ 'component_function': {
            \   'gitbranch': 'FugitiveHead'
            \ },
            \ }

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
endfunction

augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END


" General NVIM/VIM Settings
" If you open this file in Vim, it'll be syntax highlighted for you.

" Vim is based on Vi. Setting `nocompatible` switches from the default
" Vi-compatibility mode and enables useful Vim functionality. This
" configuration option turns out not to be necessary for the file named
" '~/.vimrc', because Vim automatically enters nocompatible mode if that file
" is present. But we're including it here just in case this config file is
" loaded some other way (e.g. saved as `foo`, and then Vim started with
" `vim -u foo`).
set nocompatible

" Turn on syntax highlighting.
syntax on

" Disable the default Vim startup message.
set shortmess+=I

" Show line numbers.
set number

" This enables relative line numbering mode. With both number and
" relativenumber enabled, the current line shows the true line number, while
" all other lines (above and below) are numbered relative to the current line.
" This is useful because you can tell, at a glance, what count is needed to
" jump up or down to a particular line, by {count}k to go up or {count}j to go
" down.
set relativenumber

" Always show the status line at the bottom, even if you only have one window open.
set laststatus=2

" The backspace key has slightly unintuitive behavior by default. For example,
" by default, you can't backspace before the insertion point set with 'i'.
" This configuration makes backspace behave more reasonably, in that you can
" backspace over anything.
set backspace=indent,eol,start

" By default, Vim doesn't let you hide a buffer (i.e. have a buffer that isn't
" shown in any window) that has unsaved changes. This is to prevent you from "
" forgetting about unsaved changes and then quitting e.g. via `:qa!`. We find
" hidden buffers helpful enough to disable this protection. See `:help hidden`
" for more information on this.
set hidden

" This setting makes search case-insensitive when all characters in the string
" being searched are lowercase. However, the search becomes case-sensitive if
" it contains any capital letters. This makes searching more convenient.
set ignorecase
set smartcase

" Enable searching as you type, rather than waiting till you press enter.
set incsearch
set hlsearch                    " To highlight search results.
set magic                       " For regular expressions turn magic on.

" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

" Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=

" Enable mouse support. You should avoid relying on this too much, but it can
" sometimes be convenient.
set mouse+=a

" Enable clipboard
set clipboard=unnamedplus

setlocal colorcolumn=80

" Try to prevent bad habits like using the arrow keys for movement. This is
" not the only possible bad habit. For example, holding down the h/j/k/l keys
" for movement, rather than using more efficient movement commands, is also a
" bad habit. The former is enforceable through a .vimrc, while we don't know
" how to prevent the latter.
" Do this in normal mode...
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
" ...and in insert mode
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>

nmap g<C-O> o<ESC>k             " gO to create a new line below the cursor in normal mode
nmap gO O<ESC>j                 " g<Ctrl+o> to create a new line above the cursor in normal mode

" Remove trailing whitespace
autocmd BufWritePre *.c,*.cpp,*.cc,*.h,*.hpp,*.py,*.r,*.sh :%s/\s\+$//e

set cursorline                  " Highlight current line
:highlight Cursorline ctermbg=black

" Tabs & Navigation
map <leader>nt :tabnew<cr>      " To create a new tab.
map <leader>to :tabonly<cr>     " To close all other tabs (show only the current tab).
map <leader>tc :tabclose<cr>    " To close the current tab.
map <leader>tm :tabmove<cr>     " To move the current tab to next position.
map <leader>tn :tabn<cr>        " To switch to next tab.
map <leader>tp :tabp<cr>        " To switch to previous tab.

set path+=**
set wildmenu

" Line Numbers & Indentation
set ma                          " To set mark a at current cursor location.
set expandtab                   " To enter spaces when tab is pressed.
set smarttab                    " To use smart tabs.
set autoindent                  " To copy indentation from current line
                                " when starting a new line.
set si                          " To switch on smart indentation.
set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=79                " Text-wrap
set fileformat=unix
set showcmd

" Brackets
set showmatch                   " To show matching brackets when text indicator
                                " is over them.
set mat=2                       " How many tenths of a second to blink
                                " when matching brackets.


set nobackup                    " Turn off backup.
set nowb                        " Don't backup before overwriting a file.
set noswapfile                  " Don't create a swap file.
set ffs=unix,dos,mac            " Use Unix as the standard file type.

if !has('gui running')
    set t_Co=256                " Set colours
endif

set termguicolors
set background=dark
set noshowmode
colorscheme vim-monokai-tasty

set foldmethod=indent
set foldlevel=99

nnoremap <space> za
let g:netrw_banner=0            " Disable banner
let g:netrw_browse_split=4      " Open window in a vertical split
let g:netrw_altv=1              " Open splits to the right
let g:netrw_liststyle=3         " Tree view

let g:ale_linters = {
    \   'python': ['flake8','pylint','ruff','black', 'mypy'],
    \   'sh': ['shellcheck'],
    \   'r': ['lintr', 'languageserver'],
    \}
" let g:ale_fixers = {
"     \'python':['black'],
"     \'*':['remove_trailing_lines', 'trim_whitespace'],
"     \'r':['styler'],
"     \}
"let g:ale_completion_enabled = 1
let g:ale_sign_column_always = 1
let g:ale_fix_on_save = 1
"set omnifunc=ale#completion#OmniFunc

" Enable specific R linters
"let g:ale_r_lintr_lintcache = 1

" Shorthand notation
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
let g:python3_host_prog = '/usr/bin/python3'
