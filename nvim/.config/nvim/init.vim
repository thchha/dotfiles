""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""  NEOVIM CONFIG.  """"""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""   DEPENDS ON NEOVIM LSP // LUA   """"""""""""""""

filetype plugin on 									" enable filetype plugins

" appears to be not working..:
" set clipboard=unnamedplus						" put always in clipboard

" noinsert: dont get it. Has no functionality for me?
set completeopt=menuone,preview,noselect

set autoread										" update file on external change
set fileformat=unix
set hidden											" remember undos after quit
set history=10000

" wrapping lines at:
set textwidth=80
"set nowrap
"set sidescroll=5 									" only takes effect when nowrap is set here is some text to wrap aroung

let &showbreak = '↪>  '
set linebreak 										" dont cut words
set breakindent

set splitbelow
set splitright

set nu rnu
set numberwidth=4 									" min columns for numbers


set title
set showtabline=2
" zt and zb to align cursor
set scrolloff=3
set ruler
set tabstop=4
" > <   should always go with the tabstop length
set shiftwidth=0

set hlsearch
set incsearch

" activate mouse in visual mode
set mouse=v

" when searching ignore case, unless an capital is given
" set ignorecase smartcase

syntax on

set foldlevel=1
set foldmethod=indent

set termguicolors

" thanks to a neat snippet from https://github.com/nightsense/stellarized.git
if strftime('%H') >= 7 && strftime('%H') < 19
set background=light
else
	set background=dark
endif

"colorscheme cobalt
"colorscheme cobalt2
"colorscheme stellarized
colorscheme gruvbox-material
"colorscheme tomorrow-night-blue

set statusline=%<%f\ \[#%n%M\]\ %h%r%=%o\ %l,%c\ %P

set wildmode=longest:full
"set wildcharm=<c-z> 			" wildmode=longest:full appears to replace this 
 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""   EXTERNAL FILE SOURCING   """"""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" source files from dir:
for f in split(glob('~/.config/nvim/config/*.vim'), '\n')
	exec 'source' f
endfor

packloadall									" workaround for require 'fromplugin'
lua lsp_settings = lsp_settings or require 'lsp_settings' 
