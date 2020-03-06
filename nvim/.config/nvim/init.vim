""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""         NEOVIM CONFIG
""""""
""""
""

" compatible mode deactivated  
" stop fallback to vi-only-features
set nocp

filetype plugin on 									" enable filetype plugins

set clipboard=unnamedplus

set completeopt=menuone,preview,noinsert,noselect

set autoread										" update file on external change
set fileformat=unix
set hidden											" remember undos after quit
set history=1000

" wrapping lines at:
set textwidth=80
"set nowrap
set linebreak 										" dont cut words
set breakindent
" wrapped lines are prepended with:
let &showbreak = '\+++    '
set sidescroll=5 									" only takes effect when nowrap is set here is some text to wrap aroung

set splitbelow
set splitright

" activate linenumbers relative
set nu rnu
set numberwidth=5 									" min columns for numbers


set title
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


"""""""""""""""""""""""""""   COLORING  """""""""""""""""""""""""""""""""""""""

syntax on

set termguicolors
set background=dark

" colorscheme kalisi
colorscheme gruvbox-material

let g:gruvbox_material_background = 'medium' 

let g:lightline = {}
"			\ 'component_function': {
"			\ 'filename': 'ShowFullPath'
"			\ }
"			\ }
"			use <c-g> to get the path
"function! ShowFullPath()
"	return expand('%')
"endfunction

let g:lightline.colorscheme = 'gruvbox_material'
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

""""""""""""""""""""""""""""""  VISTA  """"""""""""""""""""""""""""""""""""""""
let g:vista_default_executive = "nvim_lsp"

""""""""""""""""""""""""""""""  VIMWIKI   """""""""""""""""""""""""""""""""""""
let g:vimwiki_list = [{'path': '~/workspace/wiki/raw', 'ext': '.md'}]
let g:vimwiki_global_ext = 0

""""""""""""""""""""""""""""""   ABBREVIATIONS  """""""""""""""""""""""""""""""
"
" Abbreviations can be used to replace fill input:
"    :abbr tch thomas christian hage
"
""""""""""""""""""""""""""""""   MAPPINGS   """"""""""""""""""""""""""""""""""""

let mapleader = ' '

" opens dirvish prompt and places its window far left, full height 
command! -nargs=? -complete=dir VSDir | vertical topleft split | silent Dirvish <args>

" reselect previous visual block
vmap < <gv
vmap > >gv

" freed keys 
" removed pageUp/Down functionality
map <c-f> <Nop><CR>
map <c-b> <Nop><CR>
nnoremap + <c-]>

" clear highlight on escape
nnoremap <silent> <esc> :noh<CR><esc>

" removed line up/down
map <c-p> <NOP><CR>
map <c-n> <NOP><CR>
nmap <c-p> <c-]>
"nnoremap <c-o> <c-]> 

" buffer switching
nmap <leader><leader> :bn<CR>
nmap <leader><esc> :bp<CR>

map <leader>l :VSDir 
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 3, 1)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 3, 1)z<CR>
noremap <silent> <PageUp> :call smooth_scroll#up(&scroll*2, 2, 1)<CR>
noremap <silent> <PageDown> :call smooth_scroll#down(&scroll*2, 2, 1)<CR>
" nmap <c-q> :q<CR>

" hint: verbose map <key> to show bindings 

""""""""""""""""""""""""""""""   LUA COMMANDS   """"""""""""""""""""""""""""""""
" create shebang header for lua file.
command! LuaFile :1 :normal i#!/usr/bin/env lua<CR><CR><esc>
command! Parentheses :normal a(<space><space>)<esc>hh<esc>
noremap <silent> <leader>) :Parentheses<CR>

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

""""""""""""""""""""""""   Language Server Configs   """"""""""""""""""""""""""

"autocmd Filetype c setlocal omnifunc=v:lua.vim.lsp.omnifunc

:lua << EOF
vim.cmd("packadd nvim-lsp")
local nvim_lsp = require 'nvim_lsp'
local nvim_util = require 'nvim_lsp/util'
nvim_lsp.ccls.setup{
	cmd = { "ccls", "-log-file=/tmp/ccls.log -v=1" };
	root_dir = nvim_util.root_pattern("compile_commands.json");
}
local home = vim.loop.os_homedir()
local dir = "/programs/lua-language-server"
nvim_lsp.sumneko_lua.setup{
	cmd = { home .. dir .. "/bin/Linux/lua-language-server", "-E", home .. dir .. "/main.lua"}
}
EOF

" ask if buffer is attached
nmap <leader>? <cmd>lua print(vim.inspect(vim.lsp.buf_get_clients()))<CR>


function! LspMappings()
	setlocal omnifunc=v:lua.vim.lsp.omnifunc
	" add completion({context}) <- provide doc for nvim_lsp
	exec :Vista
	nnoremap gd    <cmd>lua vim.lsp.buf.declaration()<CR>
	nnoremap <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
	nnoremap K     <cmd>lua vim.lsp.buf.hover()<CR>
	nnoremap gD    <cmd>lua vim.lsp.buf.implementation()<CR>
	nnoremap <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
	nnoremap 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
	nnoremap gr    <cmd>lua vim.lsp.buf.references()<CR>
endfunction

au FileType c,lua :call LspMappings()

