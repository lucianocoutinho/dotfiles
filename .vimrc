""" local settings
scriptencoding utf-8
set encoding=utf-8
set nocompatible	" Use Vim defaults (much better!)
set bs=indent,eol,start	" allow backspacing over everything in insert mode
set ruler		" show the cursor position all the time

" always shows statusbar
set laststatus=2

" set status bar format
set stl=[%02n]\ %(%M%R%H%)\ %F\ %=%o\ <lin:%l\ col:%c\ %V>\ %P

" visual spaces and tabs
set list
set listchars=tab:»·,trail:·

" force save file using sudo when we got permission denied. 
" https://github.com/Gnitset/.bah/blob/master/configs/vimrc#L49
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!

" set autoindenting always on (kind annoying)
set autoindent

syntax on
set hlsearch
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

" limits text to 79 columns
" set textwidth=79

" {{{ folding
" set foldclose=all
" set foldcolumn=1
" set foldlevel=0
" set foldmarker{{{,}}}
" set foldmethod=marker
" set foldtext=foldtext()
set fillchars=vert:\|,fold:\ 
" }}}

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

