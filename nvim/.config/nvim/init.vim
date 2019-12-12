"""""""""""""""""""""""""""""""""""
""         NEOVIM CONFIG
""
"" Thomas Hage """"""""""""""""""""
" 
"  AFTER EDITING, APPLY CHANGES WITH :so %
"

" compatible mode deactivated  
" stop fallback to vi-only-features
set nocp

filetype plugin on 		" enable filetype plugins

set fileformat=unix
set hidden				" remember undos after quit
set history=100


""""""""""   PLUGINS   """"""""""""



"""""""   ABBREVIATIONS   """""""""
"
" Abbreviations can be used to replace fill input:
"    :abbr tch thomas christian hage
"
map ;l :Lex<CR>


"""""""""   COLORING  """""""""""""

syntax on

set termguicolors
set background=dark

" colorscheme kalisi
colorscheme gruvbox-material



let g:gruvbox_material_background = 'hard' 
let g:lightline = {}
let g:lightline.colorscheme = 'gruvbox_material'



"""""""""   BEHAVIOUR   """""""""""
" activate linenumbers relative

set nu rnu
set title
set nowrap
set scrolloff=8
set ruler
set showtabline=1
set tabstop=4
" > <   should always go with the tabstop length
set shiftwidth=0

" set smartindent
" set smarttab

set hlsearch
set incsearch

" activate mouse in visual mode
set mouse=v

" when searching ignore case, unless an capital is given
" set ignorecase smartcase



""""""""   NETRW:Explorer   """""""
" in nvim-dir sits .netrwhist which holds bookmarks/history
"
" make a tree style listing
let g:netrw_liststyle = 3
" disable top_banner
let g:netrw_banner = 0
" make :Lex adapt to 25% size
let g:netrw_winsize = 25
let g:netrw_sizestyle = "h"
let g:netrw_usetab = 0
let g:netrw_preview = 1
let g:netrw_keepdir = 0
let g:netrw_mousemaps = 0
" open files in new tab (3)
" open files in last window (4)
let g:netrw_browse_split = 0
