" todo: add cword to index
"       create file
"       make link of cword to file
"function! Add_entry_in_current_wiki()
"    if g:wiki_nr != nil
"        let fn = expand('<cWORD>')
"        let link = g:wiki_path . fn . ".wiki"
"        call vimwiki#base#open_link('edit', link, fn)
"    end
"endfunction
"
"" TODO: Search getcwd for /wiki and add if available
au FileType <buffer> :call Add_wiki_if_absent()

function! Add_wiki_if_absent()
  let name = expand('%:t')
  if !exists('s:wiki_nr')
    if name == "index.wiki"
      let rt_path = expand('%:p:h')
      let settings = {'path': expand('%') }
      let s:wiki_nr = call vimwiki#vars#add_temporary_wiki(settings)
    end
  end
endfunction

let g:vimwiki_list = [{'path': '~/documents/wiki/raw'}]
let g:vimwiki_folding='list'

