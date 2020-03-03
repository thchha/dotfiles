""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""         NEOVIM CONFIG
""
"" Thomas Hage """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 
"  AFTER EDITING, APPLY CHANGES WITH :so %
"

" compatible mode deactivated  
" stop fallback to vi-only-features
set nocp

filetype plugin on 									" enable filetype plugins

set fileformat=unix
set hidden											" remember undos after quit
set history=100

"""""""""""""""""""""""""""   COLORING  """""""""""""""""""""""""""""""""""""""

syntax on

set termguicolors
set background=dark

" colorscheme kalisi
colorscheme gruvbox-material



let g:gruvbox_material_background = 'medium' 
let g:lightline = {}
let g:lightline.colorscheme = 'gruvbox_material'


"""""""""""""""""""""""""""""""""   BEHAVIOUR   """""""""""""""""""""""""""""""
" activate linenumbers relative

set nu rnu
set title
set nowrap
set showtabline=2
" zt and zb to align cursor
set scrolloff=3
set ruler
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


""""""""""""""""""""""""""   MULTIPLE CURSORS   """""""""""""""""""""""""""""""
let g:multi_cursor_use_default_mapping=0

" Default mapping
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'


""""""""""""""""   NETRW:Explorer   """"""""""""""""""""""""""""
"" " in nvim-dir sits .netrwhist which holds bookmarks/history
" "
" " make a tree style listing
" let g:netrw_liststyle = 3
" " disable top_banner
" let g:netrw_banner = 0
" " make :Lex adapt to 25% size
" let g:netrw_winsize = 25
" let g:netrw_sizestyle = "h"
" let g:netrw_usetab = 0
" let g:netrw_preview = 1
" let g:netrw_keepdir = 0
" let g:netrw_mousemaps = 0
" " open files in last window (0)
" " open files in last window (4)
" " open files in new tab (3)
" let g:netrw_browse_split = 0


""""""""""""""""""""""""""""""   ABBREVIATIONS  """""""""""""""""""""""""""""""
"
" Abbreviations can be used to replace fill input:
"    :abbr tch thomas christian hage
"
""""""""""""""""""""""""""""""   LUA COMMANDS   """"""""""""""""""""""""""""""""
" create shebang header for lua file.
command! LuaFile :1 :normal i#!/usr/bin/env lua<CR><CR><esc>
command! Parentheses :normal a(<space><space>)<esc>hh<esc>
noremap <silent> <leader>) :Parentheses<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" opens dirvish prompt and places its window far left, full height 
command! -nargs=? -complete=dir VSDir | vertical topleft split | silent Dirvish <args>

" freed keys 
" removed pageUp/Down functionality
map <c-f> <Nop><CR>
map <c-b> <Nop><CR>

" clear highlight on escape
nnoremap <silent> <esc> :noh<CR><esc>

" removed line up/down
map <c-p> <Nop><CR>
map <c-n> <Nop><CR>

map <leader>l :VSDir 
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 3, 1)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 3, 1)z<CR>
noremap <silent> <PageUp> :call smooth_scroll#up(&scroll*2, 2, 1)<CR>
noremap <silent> <PageDown> :call smooth_scroll#down(&scroll*2, 2, 1)<CR>
" nmap <c-q> :q<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 			for colortemplat generation -> identify type of text
"
" function! SynStack()
"     if !exists('*synstack')
"         return
"     endif
"     echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
" endfunction
" nnoremap ? :call SynStack()<CR>
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
