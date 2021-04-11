""""""""""""""""""""""""""""""   MAPPINGS   """"""""""""""""""""""""""""""""""""

vmap < <gv
vmap > >gv

nnoremap <silent> <esc> :noh<CR><esc>
nnoremap <space><space> :ls<CR>:b<Space>

augroup ProgGroup
  au FileType xml,java,perl,vim,c,lua,latex,tex,plaintex,kotlin,scheme :call environment#lsp_mapping()
  au FileType xml,java,perl,c,lua,kotlin,scheme setlocal omnifunc=v:lua.vim.lsp.omnifunc
  if has('nvim')
    au FileType xml,java,perl,vim,c,lua,latex,tex,plaintex,kotlin,scheme :call environment#lsp_diagnostic()
  endif
  au FileType latex,tex,plaintex nmap <buffer> <f3> <cmd>lua vim.fn.texlab_forward_search()<cr>
  "au FileType latex,tex,plaintex nmap <buffer> <f10> <cmd>lua vim.fn.texlab_build()<cr>
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

nnoremap g? :GitMessenger<CR>

nnoremap - :Explore<cr>
nnoremap _ :Explore <c-r>=getcwd()<cr><cr>

nnoremap <leader>d :call journaling#make_journal_entry()<cr>
augroup TextGroup
  au FileType markdown nnoremap <leader><leader> :call journaling#toggle_todo_item()<cr>
  au FileType markdown iabbrev \\ <c-r>=journaling#toggle_todo_item()<cr><bs>
  au FileType markdown,tex,latex,plaintex inoremap ,, „
  au FileType markdown,tex,latex,plaintex inoremap '' “
augroup end
