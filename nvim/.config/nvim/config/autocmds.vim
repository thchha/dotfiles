au FileType c,lua,kotlin :call LspMappings()
augroup LuaGroup
	au FileType lua setlocal foldmethod=indent
	au FileType lua setlocal tabstop=2
augroup end

augroup KotlinGroup
	au FileType kotlin setlocal filetype=kotlin
augroup end
