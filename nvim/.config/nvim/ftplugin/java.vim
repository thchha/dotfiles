packadd nvim-jdtls

lua require('jdtls').start_or_attach({cmd = {'java-lsp.sh'}, root_dir = vim.loop.cwd() })

nnoremap <leader><space> <Cmd>lua require('jdtls').code_action()<CR>
vnoremap <leader><space> <Esc><Cmd>lua require('jdtls').code_action(true)<CR>
nnoremap <leader>r <Cmd>lua require('jdtls').code_action(false, 'refactor')<CR>

nnoremap <leader>o <Cmd>lua require'jdtls'.organize_imports()<CR>
nnoremap crv <Cmd>lua require('jdtls').extract_variable()<CR>
vnoremap crv <Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>
vnoremap crm <Esc><Cmd>lua require('jdtls').extract_method(true)<CR>

