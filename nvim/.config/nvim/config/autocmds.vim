
augroup CommonGroup
    au FileType * setlocal spell spelllang=en_us
augroup end

augroup CGroup
    au FileType c :call LspMappings()
augroup end

augroup LuaGroup
    au FileType lua setlocal foldmethod=indent
    au FileType lua setlocal tabstop=2
    au FileType lua setlocal softtabstop=2
    au FileType lua:call LspMappings()
augroup end

augroup KotlinGroup
    au FileType kotlin setlocal filetype=kotlin
    au FileType kotlin :call LspMappings()
augroup end
