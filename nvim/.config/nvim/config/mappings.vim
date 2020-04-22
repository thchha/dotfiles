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

" delete trailing whitespaces and circumvent history
nnoremap <F5> :call Del_postspace()<CR>
function! Del_postspace()
	let tmp = winsaveview()
	keeppatterns %s/\s\+$//e
	call winrestview(tmp)
endfunction

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

