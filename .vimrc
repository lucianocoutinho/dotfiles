""" local settings
scriptencoding utf-8
set encoding=utf-8
set nocompatible	" Use Vim defaults (much better!)
set bs=indent,eol,start	" allow backspacing over everything in insert mode
set ruler		" show the cursor position all the time

" always shows statusbar
set laststatus=2

" set status bar format
" set statusline=[%02n]\ %(%M%R%H%)\ %F\ %y\ %=%o\ <lin:%l\ col:%c\ %V>\ %P
set statusline=
set statusline+=[%02n]                                       " buffer number
set statusline+=\ %(%M%R%H%)                                 " modified/read-only flags
set statusline+=\ %.50F                                      " path to the file
set statusline+=\ %=                                         " move contents to right
set statusline+=\ %o                                         " show byte number
set statusline+=\ %y                                         " filetype
set statusline+=\ [%{&fileformat}\ /                         " file format
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}\] " file encoding
set statusline+=\ <lin:%l\ col:%c\ %V>                       " line and column number
set statusline+=\ %P                                         " Percentage through file displayed

" visual spaces and tabs
set listchars=tab:»·,trail:·,precedes:·,space:·
set list

" FIXME: weird way to enable and disable the display of empty spaces
command SS :execute 'set listchars=tab:»·,trail:·,precedes:·,space:·'
command SQ :execute 'set listchars=tab:»·,trail:·,precedes:·'

" not enforcing: limits text to 80 columns
" set textwidth=80

" FIXME: to format text with a specific width use:
" :!fmt -w <width>

"set a visual mark to know where the column should end
set colorcolumn=80

" force save file using sudo when we got permission denied. 
" https://github.com/Gnitset/.bah/blob/master/configs/vimrc#L49
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!

" set autoindenting always on (kind annoying)
" set autoindent
set smartindent

syntax on
set number
set hlsearch
set incsearch
set wildmenu
set vb

filetype plugin indent on

" FIXME: force tabs to be 4 spaces
" set tabstop=4

" force 2 or 4 spaces instead of tabs for some file types
if has("autocmd")

  autocmd BufRead *.txt set tw=78

  autocmd Filetype css setlocal tabstop=2 shiftwidth=2 expandtab
  autocmd Filetype sh setlocal tabstop=2 shiftwidth=2 expandtab
  autocmd Filetype html setlocal tabstop=2 shiftwidth=2 expandtab
  autocmd Filetype yaml setlocal tabstop=2 shiftwidth=2 expandtab
  autocmd Filetype ruby setlocal tabstop=2 shiftwidth=2 expandtab
  autocmd Filetype eruby setlocal tabstop=2 shiftwidth=2 expandtab
  autocmd Filetype javascript setlocal tabstop=4 shiftwidth=4 expandtab
  autocmd Filetype perl setlocal tabstop=4 shiftwidth=4 expandtab
  autocmd Filetype python setlocal tabstop=4 shiftwidth=4 expandtab

  " a shortcut example
  autocmd BufEnter  *.c,*.h abbr FOR for (i = 0; i < 3; ++i)<CR>{<CR>}<Esc>O
  autocmd BufLeave  *.c,*.h unabbr FOR
endif

" {{{ folding
" set foldclose=all
" set foldcolumn=1
" set foldlevel=0
" set foldmarker{{{,}}}
" set foldmethod=marker
" set foldtext=foldtext()
set fillchars=vert:\|,fold:\ 
" }}}

" navigation in tree mode: https://shapeshed.com/vim-netrw/
let g:netrw_banner = 0
let g:netrw_altv = 1
let g:netrw_liststyle = 3
let g:netrw_winsize = 30
" how files are open
" 1 - open files in a new horizontal split
" 2 - open files in a new vertical split
" 3 - open files in a new tab
" 4 - open in previous window
let g:netrw_browse_split = 4

" fix split position
set splitbelow
set splitright

" useful autocomplete settings
iab _chl <c-r>=strftime("%a %b %d %Y Luciano Coutinho <lucianocoutinho@live.com>")<cr>
iab _tlower abcdefghijklmnopqrstuvwxyz
iab _tupper ABCDEFGHIJKLMNOPQRSTUVWXYZ
iab _tdigit 0123456789
iab _dnome Luciano Coutinho
iab _dfnam Luciano
iab _dlnam Coutinho
iab _dmail lucianocoutinho@live.com
iab _ddata <c-r>=strftime("%Y%m%d")<cr>
iab _dhora <c-r>=strftime("%H:%M")<cr>
iab _me Luciano Coutinho <lucianocoutinho@live.com>

" set GUI font
set guifont=Monaco:h13

" experimenting some plugins from:
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-fugitive'

Plug 'mbbill/undotree'
Plug 'lyuts/vim-rtags'
Plug 'git@github.com:kien/ctrlp.vim.git'

" needs to run the ./install.py from `~/.vim/plugged/YouCompleteMe`
" broken: Plug 'git@github.com:Valloric/YouCompleteMe.git'

call plug#end()

" prevent ctrlp plugin from use caching
let g:ctrlp_use_caching = 0

" test color
colorscheme gruvbox
set background=dark

" EOF
