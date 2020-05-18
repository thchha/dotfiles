
augroup CommonGroup
"    au FileType * setlocal spell spelllang=en_us
augroup end

augroup LispGroup
    au FileType lisp setlocal autoindent
    au FileType lisp inoremap ( (<c-]>
augroup end

augroup CGroup
    au FileType c :call LspMappings()
augroup end

augroup LuaGroup
    au FileType lua setlocal foldmethod=indent
    au FileType lua setlocal tabstop=2
    au FileType lua setlocal softtabstop=2
    au FileType lua :call LspMappings()
    au FileType lua nmap <C-c><C-c> vipJ<Plug>SlimeParagraphSend :undo<CR>
    au FileType lua nmap <C-c><C-c> vipJ<Plug>SlimeRegionSend :undo<CR>
augroup end

augroup KotlinGroup
    au FileType kotlin :call LspMappings()
augroup end
