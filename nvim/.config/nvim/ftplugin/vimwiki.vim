nmap <buffer> <c-]> <Plug>VimwikiFollowLink
"nmap <c-o> <Plug>VimwikiGoBackLink

nmap <buffer> <Plug>NoVimwikiGoBackLink <Plug>VimwikiGoBackLink
nmap <buffer> <leader>] <Plug>VimwikiNextLink
nmap <buffer> <leader>[ <Plug>VimwikiPrevLink
nmap <buffer> <leader>- <Plug>VimwikiRemoveHeaderLevel


imap <buffer> <Plug>NoVimwikiReturn *@<Esc>:VimwikiReturn 1 5<CR>
"imap <CR> * CheckForCRBehaviour()

