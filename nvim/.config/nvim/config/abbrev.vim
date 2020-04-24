""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""   ABBREVIATIONS   """"""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" common
iabb ( ()<left>
iabb { {}<left>
iabb [ []<left>
iabb ret return

augroup LuaGroup
	au FileType lua iabbr luafile #!/usr/bin/env lua
	au FileType lua iabbr func function
	au FileType lua iabbr fun function
	au FileType lua iabbr if if then
	au FileType lua iabbr eif elseif
	au FileType lua iabbr e end
	au FileType lua iabbr fori for i,v in ipairs() do<left><left><left><left>
	au FileType lua iabbr forp for k,v in pairs() do<left><left><left><left>
augroup end

