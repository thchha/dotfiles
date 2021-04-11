""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" center window content in the middle of the screen.

function! environment#text_focus()
  if exists("s:text_focus")
    set nu
    set relativenumber
    unlet s:text_focus
  else
    set nonu
    set norelativenumber
    let s:text_focus = 1
  endif
  call environment#focus()
endfunction

function! environment#focus()
  if exists("s:focus_buf_nr")
    execute 'bd ' s:focus_buf_nr
    unlet s:focus_buf_nr
  else
    vert abo new
    setlocal wrap
    setlocal buftype=nofile
    setlocal bufhidden=delete
    setlocal noswapfile
    setlocal norelativenumber
    setlocal nonu
    setlocal statusline=\ 
    setlocal nobuflisted
    setlocal fillchars=fold:\ ,vert:\│,eob:\ ,msgsep:‾
    let s:focus_buf_nr = bufnr()
    wincmd H
    vertical resize 28
    wincmd p
  endif
endfunction

function! environment#lsp_diagnostic()
  setlocal updatetime=200
  au CursorHold <buffer> lua vim.lsp.diagnostic.show_line_diagnostics()
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text Editing

function! environment#text_group_gettings()
  autocmd CompleteChanged <buffer> call environment#thesaurus()
  autocmd CmdlineEnter <buffer> setlocal noignorecase | setlocal noinfercase
  setlocal thesaurus+=~/.config/nvim/spell/openthesaurus.txt
  setlocal ignorecase
  setlocal infercase
  setlocal wrap
  setlocal spell spelllang=en_us,de
endfunction

let g:fallback = -1
function! environment#thesaurus()
  if exists('s:old')
    if &iskeyword == '32-58,60-255,#'
      augroup ThesaurusGroup
        autocmd CompleteDone <buffer> call environment#remove_thesaurus_autocmd() |
              \ autocmd! ThesaurusGroup
      augroup END
    endif
  else
    let l:opts = complete_info(['mode'])
    if has_key(opts, 'mode')
      if l:opts.mode == 'thesaurus'
        let s:old = &iskeyword
        if g:fallback ==  0
          let g:fallback = s:old
        endif
        setlocal iskeyword=32-58,60-255,#
        call feedkeys("\<c-x>\<c-t>")
        return ""
      endif
    endif
  endif
endfunction

function! environment#remove_thesaurus_autocmd()
  if exists('s:old')
    let &iskeyword = s:old
    unlet s:old
  else
    let &iskeyword = g:fallback
  endif
endfunction

" preserves history; neovim specific
function! environment#delete_trailing_whitespaces(mod)
  let l:tmp = winsaveview()
  if a:mod == 'v'
    keeppatterns '<,'>s/\s\+$//e
  elseif a:mod == 'n'
    keeppatterns %s/\s\+$//e
  endif
  call winrestview(l:tmp)
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Navigation

function! environment#lsp_mapping()
  nnoremap <buffer> <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
  nnoremap <buffer> <silent> 1gd   <cmd>lua vim.lsp.buf.type_definition()<CR>
  nnoremap <buffer> <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
  nnoremap <buffer> <silent> <F3>  <cmd>lua vim.lsp.buf.implementation()<CR>
  nnoremap <buffer> <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
  nnoremap <buffer> <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
  nnoremap <buffer> <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
  nnoremap <buffer> <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
  nnoremap <buffer> <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
  nnoremap <buffer> <silent> cr    <cmd>lua vim.lsp.buf.rename()<CR>
	inoremap <buffer> <c-space> <cmd>lua vim.lsp.omnifunc()<CR>
endfunction

" resolve id/class and jump to the source, if declared
function! environment#css_implementation() abort
	let l:id = searchpos("id", "wnb", line('.'))[1]
	let l:class = searchpos("class", "wnb", line('.'))[1]

	if l:class > 0 || l:id > 0
		if l:class < l:id
			execute ":vim '#".expand('<cword>')."' **/*.css"
		elseif l:class > l:id
			execute ":vim '.".expand('<cword>')."' **/*.css"
		endif
	endif
endfunction

function! environment#remove_hidden_buffers()
  for buf in getbufinfo({ 'buflisted':1 })
    if !buf.changed && buf.hidden
      exe 'bd ' . buf.bufnr
    endif
  endfor
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Async

function! environment#async_cmd_completed(job_id, data, event)
  unlet s:channel
  unlet s:cmd_in_progress
  if exists('s:abort') | unlet s:abort | endif
endfunction

function! environment#async_cmd_emmitted(job_id, data, event)
  call setqflist([], 'a', {
        \ 'title' : s:cmd_in_progress . " | dir: ". getcwd(),
        \ 'lines': a:data})
  execute 'copen'
endfunction

function! environment#async_command(command)
  if exists('s:channel') " just run one at a time.
    if exists('s:abort')
      jobstop(s:channel)
      unlet s:abort
      unlet s:channel
      echom "killed command"
    else
      let s:abort = 1
      echom "already a command in progress.."
    endif
  else
    call setqflist([], 'f')
    let s:cmd_in_progress = a:command
    let l:splitted = split(a:command)
    let l:options = {
          \ 'detach': 'v:false',
          \ 'on_exit': 'environment#async_cmd_completed',
          \ 'on_stdout': 'environment#async_cmd_emmitted',
          \ 'stdout_buffered' : 'v:true'}
    let s:channel = jobstart(l:splitted, l:options)
    if s:channel == 0
      echom "invalid call"
    elseif s:channel < 0
      echom "command is not executable"
    endif
  endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" REPL (TODO)

function! environment#toggle_repl_buffer()
  if !exists('s:repl_command')
    let s:repl_command = input("Input REPL-start command: ", "gsi")
  endif
  " set properties
  " toggle terminal buffer
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
