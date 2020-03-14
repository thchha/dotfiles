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
let &showbreak = '↪>  ' 
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

syntax on

set termguicolors

" thanks to a neat snippet from https://github.com/nightsense/stellarized.git
if strftime('%H') >= 7 && strftime('%H') < 19
	set background=light
else
	set background=dark
endif

set background=dark
"colorscheme cobalt
"colorscheme cobalt2
colorscheme stellarized
"colorscheme gruvbox-material

set statusline=%<%f\ \[#%n%M\]\ %h%r%=%o\ %l,%c\ %P

set wildcharm=<c-z>

let g:gruvbox_material_background = 'medium' 

""""""""""""""""""""""""""""""  VISTA  """"""""""""""""""""""""""""""""""""""""
let g:vista_default_executive = "nvim_lsp"

""""""""""""""""""""""""""""""  VIMWIKI   """""""""""""""""""""""""""""""""""""
let g:vimwiki_list = [{'path': '~/workspace/wiki/raw'}]
let g:vimwiki_global_ext = 0

""""""""""""""""""""""""""""""  GITGUTTER  """"""""""""""""""""""""""""""""""""
let g:gitgutter_highlight_linenrs = 1
let g:gitgutter_preview_win_floating = 1
let g:gitgutter_map_keys = 0

""""""""""""""""""""""""""""""   ABBREVIATIONS  """""""""""""""""""""""""""""""
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

command! Git GitGutterLineHighlightsToggle
" delegate save 
command! W w

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
" remove page up/down:
map <c-f> <NOP><CR>

nnoremap <c-p> <c-]>

" windows:
nnoremap <tab> <c-w>w
nnoremap <s-tab> <c-w>W
nnoremap <leader>h <c-w>H
nnoremap <leader>k <c-w>K

" buffer switching
nnoremap <c-PageUp> :bn<CR>
nnoremap <c-PageDown> :bp<CR>
nnoremap <c-del> :bdelete<CR>
nnoremap <leader><leader> :ls<CR>:b<Space>
nnoremap <leader><e> :buffer <c-z>


nnoremap <leader>? :GitMessenger<CR>
" FIXME: handle switching buffers, load time lsp server
nnoremap <silent> <leader><esc> :call ToggleVista()<CR>

let g:lastSelectedWindow = 0
function! ToggleVista()
	if g:lastSelectedWindow > 0
		echomsg g:lastSelectedWindow
		execute ":buffer " g:lastSelectedWindow
		let g:lastSelectedWindow = 0
		execute ":Vista!! "
		return
	endif
	let g:lastSelectedWindow = bufnr('$')
	execute ":Vista!! "
	return
endfunction

noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 3, 1)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 3, 1)z<CR>
noremap <silent> <PageUp> :call smooth_scroll#up(&scroll*2, 2, 1)<CR>
noremap <silent> <PageDown> :call smooth_scroll#down(&scroll*2, 2, 1)<CR>

" ask if buffer is attached
nmap <leader>lsp <cmd>lua print(vim.inspect(vim.lsp.buf_get_clients()))<CR>

""""""""""""""""""""""""""""""   LUA COMMANDS   """"""""""""""""""""""""""""""""
" create shebang header for lua file.
command! LuaFile :1 :normal i#!/usr/bin/env lua<CR><CR><esc>
command! Parentheses :normal a(<space><space>)<esc>hh<esc>
noremap <silent> <leader>) :Parentheses<CR>

""""""""""""""""""""""""   Language Server Configs   """"""""""""""""""""""""""

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
	cmd = { home .. dir .. "/bin/Linux/lua-language-server", "-E", home .. dir .. "/main.lua" };
	settings = {
		Lua = {
			runtime = {
				version = "Lua 5.3"
			};
			workspace = {
				ignoreSubmodules = "false";
				ignoreDir = { ".git", "build" }
			}
		}
	};
}
EOF

	""Lua.runtime.version" = { "Lua 5.1" },
	"Lua.workspace.ignoreDir = { ".git", "build" },
function! LspMappings()
	setlocal omnifunc=v:lua.vim.lsp.omnifunc
		" add completion({context}) <- provide doc for nvim_lsp
	inoremap <c-space> <cmd>lua vim.lsp.buf.completion()<CR>
	nnoremap gD    <cmd>lua vim.lsp.buf.declaration()<CR>
	nnoremap gd    <cmd>lua vim.lsp.buf.definition()<CR>
	nnoremap K     <cmd>lua vim.lsp.buf.hover()<CR>
	nnoremap <leader>d    <cmd>lua vim.lsp.buf.implementation()<CR>
	nnoremap <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
	nnoremap 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
	nnoremap gr    <cmd>lua vim.lsp.buf.references()<CR>
endfunction

au FileType c,lua :call LspMappings()
