""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""  NEOVIM CONFIG.  """"""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""   DEPENDS ON NEOVIM LSP // LUA   """"""""""""""""

if has('nvim')
  set inccommand=split
  set backupdir=~/.local/share/nvim/backup/
  packadd nvim-lsp
  packadd sticky_suggestions-vim
else
  set nocompatible
  set laststatus=2
  set term=xterm
  set encoding=utf-8
  set autoindent
  set autoread
  set backspace=indent,eol,start
  set nofsync
  set belloff=all
  set wildmenu
  set history=10000

  set hlsearch
  set incsearch
  set smarttab
  set ttimeoutlen=50

  set complete-=i

endif

filetype plugin on

set virtualedit=block
set wildmode=longest:full
set completeopt=menuone,noselect

set fileformat=unix
set hidden											" remember undos after quit

set nowrap
set whichwrap+=<,>
let &showbreak = ' L|'
set linebreak 									" dont cut words
set breakindent

set splitbelow
set splitright

set numberwidth=4 							" min columns for numbers

set expandtab
set tabstop=2
set shiftwidth=0                " > <   should always go with the tabstop length

set foldmethod=marker
set foldlevel=0

set backup
set writebackup
set backupcopy=yes

set termguicolors
syntax on
colorscheme ayu

" preserve screen estate
set showtabline=0
set statusline=%<%f\ \[#%n%M\]\%{'\ @\ ['.tabpagenr().']'}\ %h%r%=%o\ %l,%c\ %P

set mouse=v

command! W w

command! Wiki edit /home/tomes/documents/wiki/index.md
command! Todo edit /home/tomes/documents/todo/todo.md

command! BufferDeleteHidden call environment#remove_hidden_buffers()

command! ConfigMap edit /home/tomes/dotfiles/nvim/.config/nvim/config/mappings.vim
command! Config edit /home/tomes/dotfiles/nvim/.config/nvim/init.vim
command! ConfigExternal edit /home/tomes/dotfiles/nvim/.local/share/nvim/site/pack/git-plugins/start/

if has('nvim')
  command! InspectLsp :lua print(vim.inspect(vim.lsp.buf_get_clients()))<CR>
endif

"find . -iname auto* -printf %p:1:1:%f
command! -nargs=+ -complete=shellcmd -bar Async :call environment#async_command(<q-args>)<CR>
command! -nargs=+ -bar Grep :call environment#async_command("grep -n " . <q-args> . " -r .")<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""   EXTERNAL FILE SOURCING   """"""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup TextGroup | au! | augr end
augroup ProgGroup | au! | augr end

let g:tex_flavor="latex"

" source files from dir: TODO: current path
for f in split(glob('~/.config/nvim/config/*.vim'), '\n')
	exec 'source' f
endfor

if has('nvim')
  lua lsp_settings = lsp_settings or require 'lsp_settings'
endif
