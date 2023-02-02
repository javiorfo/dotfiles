" Basics
set nocompatible
set number 
set autoindent 
set ignorecase
set mouse=a
set hidden
set timeoutlen=1000 ttimeoutlen=10
filetype plugin on 

" Tabs
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab

" Splits Orientation
set splitright
set splitbelow

" Syntax
syntax on 

if has('termguicolors')
 set termguicolors
endif

" Menus
set path+=.,**
set wildmenu 
set wildoptions=pum

" File Explorer
let netrw_banner = 0
let netrw_browse_split = 4
let netrw_altv = 1
let netrw_liststyle = 3
let netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

" Cursor Line
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" Mappings
map <Space> <Leader>