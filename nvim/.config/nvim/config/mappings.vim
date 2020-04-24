""""""""""""""""""""""""""""""   MAPPINGS   """"""""""""""""""""""""""""""""""""

let mapleader = ' '

" reselect previous visual block
vmap < <gv
vmap > >gv

command! Git GitGutterLineHighlightsToggle
" abbr for :ex
command! W w

" freed keys
" removed pageUp/Down functionality
map <c-f> <Nop><CR>
map <c-b> <Nop><CR>

" german keyboard workaround(s)
nnoremap + <c-]>
"nnoremap <c-p> <c-]>

" delete trailing whitespaces and circumvent history
nnoremap <F5> :call Del_postspace()<CR>
function! Del_postspace()
	let tmp = winsaveview()
	keeppatterns %s/\s\+$//e
	call winrestview(tmp)
endfunction

" clear highlight on escape
nnoremap <silent> <esc> :noh<CR><esc>

" cleared keys
map <c-p> <NOP><CR>
map <c-n> <NOP><CR>
map <c-f> <NOP><CR>

" window switching
nnoremap <tab> <c-w>w
nnoremap <s-tab> <c-w>W

" buffer switching
nnoremap <c-PageUp> :bn<CR>
nnoremap <c-PageDown> :bp<CR>
nnoremap <c-del> :bdelete<CR>
nnoremap <leader><leader> :ls<CR>:b<Space>

nnoremap <leader>? :GitMessenger<CR>
" FIXME: handle switching buffers, load time lsp server
nnoremap <silent> <leader><esc> :call ToggleVista()<CR>

let s:lastSelectedWindow = 0
function! ToggleVista()
	if s:lastSelectedWindow > 0
		echomsg s:lastSelectedWindow
		execute ":buffer " s:lastSelectedWindow
		let s:lastSelectedWindow = 0
		execute ":Vista!! "
		return
	endif
	let s:lastSelectedWindow = bufnr('$')
	execute ":Vista!! "
	return
endfunction

" grepping
map <F10> :vim <cword> **/*

" eyes appearing to age
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 3, 1)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 3, 1)z<CR>
noremap <silent> <PageUp> :call smooth_scroll#up(&scroll*2, 2, 1)<CR>
noremap <silent> <PageDown> :call smooth_scroll#down(&scroll*2, 2, 1)<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""  LSP SPECIFICS  """""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ask if buffer is attached
nmap <leader>lsp <cmd>lua print(vim.inspect(vim.lsp.buf_get_clients()))<CR>

function! LspMappings()
	setlocal omnifunc=v:lua.vim.lsp.omnifunc
		" add completion({context}) <- provide doc for nvim_lsp
	inoremap <c-space> <cmd>lua vim.lsp.buf.completion()<CR>
	nnoremap gD    <cmd>lua vim.lsp.buf.declaration()<CR>
	nnoremap gd    <cmd>lua vim.lsp.buf.definition()<CR>
	nnoremap K     <cmd>lua vim.lsp.buf.hover()<CR>
	nnoremap <f3>    <cmd>lua vim.lsp.buf.implementation()<CR>
	nnoremap <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
	" TODO: read up
	nnoremap 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
	nnoremap gr    <cmd>lua vim.lsp.buf.references()<CR>
endfunction

