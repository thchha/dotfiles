""""""""""""""""""""""""""""""   MAPPINGS   """"""""""""""""""""""""""""""""""""

let mapleader = ' '

vmap < <gv
vmap > >gv

noremap <leader>y "+y
noremap <leader>p "+p

inoremap jk <esc>
inoremap kj <esc>

nnoremap <silent> <esc> :noh<CR><esc>

nnoremap <leader><leader> :ls<space>t<CR>:b<Space>
nnoremap <leader><CR> :b<Space>#<CR>

" useful if muscle memory opens file with c-f
map <c-f> <Nop>
" for completeness.. (and tmux-prefix)
map <c-b> <Nop>

augroup ProgGroup
  au FileType perl,vim,c,lua,latex,tex,plaintex,kotlin,scheme :call environment#lsp_mapping()
  au FileType perl,c,lua,kotlin,scheme setlocal omnifunc=v:lua.vim.lsp.omnifunc
  au FileType perl,vim,c,lua,latex,tex,plaintex,kotlin,scheme :call environment#lsp_diagnostic()
  au FileType latex,tex,plaintex nmap <buffer> <f3> <cmd>lua vim.fn.texlab_forward_search()<cr>
	au FileType html nnoremap <buffer> <f3> <cmd>call environment#css_implementation()<cr>
augroup end

vnoremap <F5> :call environment#delete_trailing_whitespaces('v')<CR>
nnoremap <F5> :call environment#delete_trailing_whitespaces('n')<CR>

noremap <silent> <F13> :call environment#text_focus()<CR>
noremap <silent> <F1> :call environment#focus()<CR>

noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 3, 1)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 3, 1)z<CR>
noremap <silent> <PageUp> :call smooth_scroll#up(&scroll*2, 2, 1)<CR>
noremap <silent> <PageDown> :call smooth_scroll#down(&scroll*2, 2, 1)<CR>

nnoremap <leader>gg :GitGutterToggle<CR>
nnoremap <leader>ggl :GitGutterLineHighlightsToggle<CR>
nnoremap <leader>gK :GitGutterPreviewHunk<CR>
nnoremap <leader>g? :GitMessenger<CR>
