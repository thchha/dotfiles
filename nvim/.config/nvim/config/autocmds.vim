highlight ExtraWhitespace ctermbg=brown guibg=brown

augroup BehaviourGroup
  au!
  autocmd InsertLeave * match ExtraWhitespace /\s\+$/
  autocmd InsertEnter * call clearmatches()

  autocmd VimEnter * nested if filereadable('Session.vim')
        \ && confirm('Session found - Reload? ["Yes"]'. "\n\t" .
        \ strftime("created on: %c", getftime(expand(getcwd() . '/Session.vim'))) . "\n" .
        \ 'Your opened files will still be available.',
        \ "&Yes\n&No", 1) == 1 | source Session.vim | endif

  " we should probably detect via v:dying or v:exiting if anything was changed
  " already (even though I can see it myself)
  autocmd VimLeave * if filereadable('Session.vim')
        \ && confirm('Override existing Session.vim? [path"' . getcwd() . '"]',
        \ "&Yes\n&No") == 1 | execute 'mksession!' | endif

  " restore cursor position
  au! BufReadPost * if line("'\"") > 1
        \ && line("'\"") <= line("$") |
        \ exe "normal! g`\"" |
        \ endif
augr end

augroup TextGroup
  au FileType plaintex,tex,txt,vimwiki,latex,markdown :call environment#text_group_gettings()
  au FileType latex setlocal foldmethod=indent
  au FileType markdown setlocal nowrap
augroup end

