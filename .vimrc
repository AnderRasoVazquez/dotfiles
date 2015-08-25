" runtime! debian.vim

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}

" MIS PLUGINS
" Navegador de archivos
Plugin 'python.vim'
Plugin 'klen/python-mode'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
" let g:nerdtree_tabs_open_on_console_startup = 1
" Plugin 'tpope/vim-flagship'
" set laststatus=2
" set showtabline=2
" set guioptions-=e
Plugin 'bling/vim-airline' " lean & mean status/tabline for vim that's light as air
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
set laststatus=2
Plugin 'edkolev/tmuxline.vim' " set airline colors to tmux
" Plugin 'Lokaltog/powerline'
" set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
" set noshowmode  " Hide the default mode text (e.g. -- INSERT -- below the statusline)
Plugin 'airblade/vim-gitgutter'
highlight clear SignColumn
" Buscador de archivos
Plugin 'kien/ctrlp.vim'
" Rainbow parenthesis
Plugin 'rainbow_parentheses.vim'
au VimEnter * RainbowParenthesesToggle
au VimEnter * RainbowParenthesesLoadSquare   " []
au VimEnter * RainbowParenthesesLoadBraces   " {}
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" Color schemes
Plugin 'altercation/vim-colors-solarized'
Plugin 'sickill/vim-monokai'
Plugin 'baskerville/bubblegum'
Plugin '29decibel/codeschool-vim-theme'

Plugin 'tomasr/molokai'
" let g:molokai_original = 1
" let g:rehash256 = 1

Plugin 'lilydjwg/colorizer'
Plugin 'suan/vim-instant-markdown' " markdown preview [sudo] npm -g install instant-markdown-d
let g:instant_markdown_autostart = 0 " dont start preview
Plugin 'nelstrom/vim-markdown-folding' " collapse titles
Plugin 'vim-scripts/TaskList.vim' " muestra todos los todo
Plugin 'tpope/vim-commentary'     " hace comentarios
Plugin 'scrooloose/syntastic'     " muestra errores de syntaxis
Plugin 'tpope/vim-fugitive'       " git plugin
Plugin 'mattn/emmet-vim'          " emmet solo para esos lenguajes
let g:user_emmet_install_global = 0
autocmd FileType html,php,css EmmetInstall
"para que funcionen los snippets
Plugin 'marcweber/vim-addon-mw-utils' " necesario para que funcione el otro
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'

Plugin 'beloglazov/vim-online-thesaurus' " synonyms
Plugin 'terryma/vim-multiple-cursors' " multiple cursors
Plugin 'tpope/vim-surround'           " S para surround rodear algo con comillas
Plugin 'Lokaltog/vim-easymotion'      " moverse facil por el documento
Plugin 'KabbAmine/vCoolor.vim'        " gui color picker
Plugin 'gorodinskiy/vim-coloresque'   " color highlight
Plugin 'majutsushi/tagbar'            " tags plugin
Plugin 'Shougo/neocomplcache.vim'     " autocompletado
" let g:neocomplcache_enable_at_startup = 1
" <TAB>: completion.
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
Plugin 'Yggdroot/indentLine'  " show indentation guides
" let g:indentLine_leadingSpaceEnabled = 1
Plugin 'vim-scripts/CSApprox' " gvim-only colorschemes work in terminal
Plugin 'godlygeek/tabular'    " alinear verticalmente como una tabla
Plugin 'sk1418/Join'          " Better join
Plugin 'freitass/todo.txt-vim' " Organizar los todotxt
Plugin 'zefei/vim-colortuner' " colorscheme tuner

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
" runtimeeeeeee

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" Si hemos abierto Vim en modo GUI
if has("gui_running")
    colorscheme solarized
    set background=dark
    let g:airline_theme = "solarized"
    " colorscheme bubblegum-256-dark
    " let g:airline_theme = "bubblegum"
    set guifont=Droid\ Sans\ Mono\ for\ Powerline\ 10
else
    colorscheme bubblegum-256-dark
    let g:airline_theme = "bubblegum"
    set guifont=Terminess\ Powerline\ 11
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
" set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matchiny
set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
set hidden		" Hide buffers when they are abandoned
set mouse=a		" Enable mouse usage (all modes)
set smartindent " auto tab

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

set shell=/bin/bash
set number          " show line numbers
" set tabstop=4      " number of visual spaces per TAB
" indentation
set expandtab
set shiftwidth=4
set softtabstop=4

set relativenumber

set hlsearch        " resaltar resultados de busqueda
set nrformats=      " tratar a todos los numeros como decimales
" set cursorline    " highlight current line

" let mapleader="\<Space>"
let mapleader=","

" repetir comando
map g. @:

" guardar como sudo
cmap sudow w !sudo tee %

" let &colorcolumn=join(range(121,999),",") " colorear a partir de 80
" quitar el resaltado de la ultima busqueda
" nnoremap <esc> :noh<return><esc>

" no errorbells nor flash screen
set noerrorbells visualbell t_vb=
if has('autocmd')
    autocmd GUIEnter * set visualbell t_vb=
endif


" reconode los archivod .md como markdown
" autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd BufNewFile,BufReadPost *.md set spell spelllang=es
autocmd BufNewFile,BufReadPost *.md vmap <Leader>b S*gvS*3f*
autocmd BufNewFile,BufReadPost *.md vmap <Leader>i S*f*
autocmd BufNewFile,BufReadPost *.md vmap <Leader>l S]%a(<Esc>"+pa)<Esc>

set wildmenu        " tab completion zsh like
set wildmode=full
set history=1000    " guarda hasta200 comandos lo normal son 20
set undolevels=1000 " guarda 1000 cambios
set noswapfile
" more natural splits
set splitbelow
set splitright
runtime macros/matchit.vim " plugin de vim que habilita saltos, ej html tag
" set t_ut= " para que los colores del background funcionen bien en tmux
set lazyredraw
set ttyfast
