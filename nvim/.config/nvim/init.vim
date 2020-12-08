""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""  NEOVIM CONFIG.  """"""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""   DEPENDS ON NEOVIM LSP // LUA   """"""""""""""""

filetype plugin on

set virtualedit=block
set wildmode=longest:full
set completeopt=menuone,noselect

set fileformat=unix
set hidden											" remember undos after quit
set history=10000

set nowrap
set whichwrap+=<,>
let &showbreak = '↪>'
set linebreak 									" dont cut words
set breakindent

set splitbelow
set splitright

set nu rnu
set numberwidth=4 							" min columns for numbers

set expandtab
set tabstop=2
set shiftwidth=0                " > <   should always go with the tabstop length

set hlsearch
set incsearch

set foldmethod=indent
set foldnestmax=2

set backup
set backupdir=~/.local/share/nvim/backup/
set writebackup
set backupcopy=yes

set termguicolors
syntax on
colorscheme ayu

set statusline=%<%f\ \[#%n%M\]\ %h%r%=%o\ %l,%c\ %P

set mouse=v

command! W w

command! ConfigMap edit /home/tomes/dotfiles/nvim/.config/nvim/config/mappings.vim
command! Config edit /home/tomes/dotfiles/nvim/.config/nvim/init.vim
command! ConfigExternal Dirvish /home/tomes/dotfiles/nvim/.local/share/nvim/site/pack/git-plugins/start/

command! InspectLsp :lua print(vim.inspect(vim.lsp.buf_get_clients()))<CR>

"find . -iname auto* -printf %p:1:1:%f
command! -nargs=+ -complete=shellcmd -bar Async :call environment#async_command(<q-args>)<CR>
command! -nargs=+ -bar Grep :call environment#async_command("grep -n " . <q-args> . " -r .")<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""   EXTERNAL FILE SOURCING   """"""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup TextGroup | au! | augr end
augroup ProgGroup | au! | augr end

" source files from dir:
for f in split(glob('~/.config/nvim/config/*.vim'), '\n')
	exec 'source' f
endfor

lua lsp_settings = lsp_settings or require 'lsp_settings'
