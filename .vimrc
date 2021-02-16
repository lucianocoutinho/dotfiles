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
set statusline+=\ [%{&fileformat}\/                         " file format
set statusline+=\%{&fileencoding?&fileencoding:&encoding}\] " file encoding
set statusline+=\ <lin:%l\ col:%c\ %V>                       " line and column number
set statusline+=\ %P                                         " Percentage through file displayed

" visual spaces and tabs (show ALL spaces by default)
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

" set autoindenting always on (kind annoying)
"set autoindent
set smartindent

syntax on
set number
set hlsearch
set incsearch
set wildmenu
"
" search down into subfolders and provides tab-completion for all file related
" tasks
set path+=**

set vb

filetype plugin indent on

" FIXME: force tabs to be 4 spaces
" set tabstop=4

" force 2 or 4 spaces instead of tabs for some file types
if has("autocmd")

  autocmd BufRead,BufNewFile *.txt set textwidth=80
  autocmd BufRead,BufNewFile *.md  set textwidth=80

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


" force save file using sudo when we got permission denied. 
" https://github.com/Gnitset/.bah/blob/master/configs/vimrc#L49
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!


" {{{ folding
" set foldclose=all
" set foldcolumn=1
" set foldlevel=0
" set foldmarker{{{,}}}
" set foldmethod=marker
" set foldtext=foldtext()
" set fillchars=vert:\|,fold:\ 
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
set guifont=Monaco:h12

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

" plugin to focus in the selected paragraph/block
" https://github.com/junegunn/limelight.vim
Plug 'junegunn/limelight.vim'

" needs to run the ./install.py from `~/.vim/plugged/YouCompleteMe`
" broken: Plug 'git@github.com:Valloric/YouCompleteMe.git'

"use pre build, add 'vim-plug' to the filetype list so vim-plug can update this plugin
" see: https://github.com/iamcco/markdown-preview.nvim/issues/50
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

call plug#end()

" BEGIN:  markdown preview-plugin.nvim settings
" reference: https://github.com/iamcco/markdown-preview.nvim
" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 0

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" recognized filetypes
" these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown']

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
" CSS from: https://github.com/sindresorhus/github-markdown-css
let g:mkdp_markdown_css='~/.vim/github-markdown.css'

" END:  markdown preview-plugin.nvim settings

" FIXME: manually start/stop "MarkdownPreview"
command MD :execute 'MarkdownPreview'
command MX :execute 'MarkdownPreviewStop'

" FIXME: manually start/stop "limelight"
command LL :execute 'Limelight'
command LX :execute 'Limelight!'

" prevent ctrlp plugin from use caching
let g:ctrlp_use_caching = 0

" test color
colorscheme gruvbox
set background=dark

" EOF
