"
" Configuracao padrao para o vi e gvim
"
" Sun Feb 03 2008 Luciano Coutinho <lucianocoutinho@live.com>
"

" configuracao para identificar os espacos e tabs
set list
set listchars=tab:»·,trail:·

" FIXME: mostra tabs com 4 espacos
"set tabstop=4

if has("autocmd") 
	" >> http://bit.ly/5L8YD
	" ativa plugin filetype para permitir customizacao do vim baseado no
	" tipo de arquivo (configuracoes em .vim/ftplugin/*.vim)
	filetype plugin indent on

	" define indentacao de acordo com o tipo de arquivo
	autocmd FileType html setlocal tabstop=2 shiftwidth=2 expandtab
	autocmd FileType yaml setlocal tabstop=2 shiftwidth=2 expandtab
	autocmd FileType ruby setlocal tabstop=2 shiftwidth=2 expandtab
	autocmd FileType eruby setlocal tabstop=2 shiftwidth=2 expandtab
	autocmd FileType javascript setlocal tabstop=4 shiftwidth=4 expandtab
	autocmd FileType python setlocal tabstop=4 shiftwidth=4 expandtab
endif

" identacao automatica
set autoindent
"set smarttab autoindent
"set smartindent backspace

" correcao de backspace
set bs=indent,eol,start

" opcao de configuracao para GUI
" default: set go=aegimrLtT
set go=aegimrLt

" opcao de fonte para interface grafica
"set guifont=Andale_Mono:h13
"set guifont=Monaco:h12

" opcao para ocultar o ponteiro do mouse durante a escrita
set mousehide

" opcao para shift-insert funcionar
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" highlight
syn on

" opcao para destacar buscas
set hlsearch

" opcao para usar as teclas de atalho do menu (????)
set winaltkeys=yes

" opcao para apresentar um menu de opcoes
set wildmenu

" limita o texto a 79 colunas
" set textwidth=125
" set textwidth=79

" sempre mostra barra de status
set laststatus=2


" define o formato da barra de status
"set stl=%1*%{Version()}\ [%02n]\ ()\ %(%M%R%H%)\ %F\ %=%o\ <%l,%c:%V>\ %P
set stl=[%02n]\ %(%M%R%H%)\ %F\ %=%o\ <lin:%l\ col:%c\ %V>\ %P

" visual bell
set vb

" {{{ Folding
" fecha todos os blocos automaticamente
" set foldclose=all

" " reserva uma coluna para os blocos
" set foldcolumn=1
" 
" set foldlevel=0
" 
" set foldlevelstart=-1
" 
" " define o marcador
" set foldmarker={{{,}}}
" 
" " define o metodo de folding
" set foldmethod=marker
" 
" set foldtext=foldtext()

set fillchars=vert:\|,fold:\ 

" }}} 

" {{{ abreviacoes
iab _chl <c-r>=strftime("%a %b %d %Y Luciano Coutinho <lucianocoutinho@live.com>")<cr>
iab _dnome Luciano Coutinho
iab _dfnam Luciano
iab _dlnam Coutinho
iab _dmail lucianocoutinho@live.com
iab _ddata <c-r>=strftime("%Y%m%d")<cr>
iab _dhora <c-r>=strftime("%H:%M")<cr>
iab _me Luciano Coutinho <lucianocoutinho@live.com>

iab _tlower abcdefghijklmnopqrstuvwxyz
iab _tupper ABCDEFGHIJKLMNOPQRSTUVWXYZ
iab _tdigit 0123456789

" }}}

"""use pathogen plugin manager
call pathogen#infect()

""ctrlp - http://kien.github.com/ctrlp.vim/
set runtimepath^=~/.vim/bundle/ctrlp.vim

