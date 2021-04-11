""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Jornaling

" mark or unmark a '- [ ]' item.
" Creates also a Timestamp on creation and end.
" has no ability to recognize subtasks.
function! journaling#toggle_todo_item()
  let l:raw = substitute(
        \ getline('.'),
        \ '\(-\s\[\s\]\|-\s\[X\]\)',
        \ '',
        \ "")
  let l:linenr = line('.')
  let l:save_pos = getcurpos()
  call cursor(l:linenr, 1)
  if search('\[\s\]','n', line('.')) > 0
    let cmd_query = systemlist('task "' . l:raw . '" _ids')
    if len(cmd_query) == 0
      echom "ERROR FINISHING THE TASK."
    else
      let i = len(cmd_query) - 1
      echom system('task done ' . cmd_query[i])
      execute 's/\[\s\]/\[X\]'
    endif
  elseif search('\[X\]','n', line('.')) > 0
    let cmd_query_uuid = systemlist('task status:completed "' . l:raw . '" _uuid')
    if len(cmd_query_uuid) == 0
      echom "NO TASK FOUND."
    else
      echom system('task ' . cmd_query_uuid[0] . ' modify status:pending')
    execute 's/\[X\]/\[\ \]'
    endif
  else " creation
    let fname = expand('%:t:r')
    let project = 'project:' . fname . ' '
    if fname == 'todo' ||
          \ fname =~ '\d\{2}_\d\{2}_\d\{4}'
      let project = ''
    endif
    let cmd_out = system('task add ' . project . '"' . l:raw . '"')
    execute ':normal! I- [ ] '
    let l:save_pos[2] += 100
    let l:save_pos[4] += 100
  endif
  nohlsearch
  call setpos('.', l:save_pos)
endfunction

" simply visit a dedicated file and prepare for writing it with markdown.
function! journaling#make_journal_entry()
  let fname = "/home/tomes/documents/journal/" . strftime("%d_%m_%Y.md")
  execute 'edit ' . fname
  if !filereadable(fname)
    execute 'normal I# ' . strftime("%A, the %d of %B %Y")
    write
  endif
  execute 'normal! Go## ' . strftime("%H:%M")
  normal! o
  startinsert
endfunction


" @DEPRECATED
" when one dumped a thought into a buffer,
" it can be transformed and transfered to a dedicated todo list (appended)
" use case: I got an binding which toggles a cleaned and empty buffer to the
" left of my windows, indenting the actual buffer into the middle.
" Nonetheless, it is handy to dump thoughts there, but they are not persisted.
" It would be even handier to use the actual todo file. Therefore, I
" dismiss this function.
function! journaling#dump_as_Todos()
  let or = '\|'
  let pat = '^\('
  let pat .= '\n' . or
  let pat .= '|' . or
  let pat .= '\s*Created:' . or
  let pat .= '\s*Done:' . or
  let pat .= '\s*\-\ \['
  let pat .= '\)\@!'
  execute 'g/' . pat . '/call journaling#toggle_todo_item()'
  normal! gg"cdG
  let fname = input("Which file to dump the todos in?\n",
        \ "/home/tomes/documents/todo/todo.md", "file")
  execute 'edit ' . fname
  normal! Go
  normal! "cp
endfunction
