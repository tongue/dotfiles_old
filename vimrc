call plug#begin('~/.vim/plugged')
	" Extend
	Plug 'ervandew/supertab'
	Plug 'nathanaelkane/vim-indent-guides'
	Plug 'raimondi/delimitMate'
	Plug 'bling/vim-airline'
	Plug 'scrooloose/syntastic'
	Plug 'kien/ctrlp.vim'
	Plug 'mhinz/vim-signify'
	Plug 'mhinz/vim-startify'
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-sensible'
	Plug 'tpope/vim-vinegar'
	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-ragtag'
	Plug 'pangloss/vim-javascript'
	Plug 'SirVer/ultisnips'
	Plug 'honza/vim-snippets'
	Plug 'Valloric/YouCompleteMe'
	Plug 'marijnh/tern_for_vim'
	Plug 'junegunn/rainbow_parentheses.vim'
	Plug 'mbbill/undotree'
	Plug 'dyng/ctrlsf.vim'
	Plug 'myusuf3/numbers.vim'
	Plug 'terryma/vim-multiple-cursors'
	" Colorschemes
	Plug 'junegunn/seoul256.vim'
	Plug 'morhetz/gruvbox'
	Plug 'chriskempson/base16-vim'
	" Backend
	Plug 'vim-scripts/aspnetcs'
	" Frontend
	Plug 'cakebaker/scss-syntax.vim'
	Plug 'mattn/emmet-vim'
	Plug 'briancollins/vim-jst'
	Plug 'groenewege/vim-less'
	Plug 'hail2u/vim-css3-syntax'
	Plug 'jelera/vim-javascript-syntax'
	Plug 'helino/vim-json'
	Plug 'maksimr/vim-jsbeautify'
	Plug 'einars/js-beautify'
	Plug 'kewah/vim-cssfmt'
	Plug 'mustache/vim-mustache-handlebars'
call plug#end()

" Set 256 colors
set t_Co=256

" Disable bell
set visualbell

" turn on syntax highlighting
syntax on

" and show line numbers
set number

" Highlight current line
set cursorline

" make vim try to detect file types and load plugins for them
filetype on
filetype plugin on
filetype indent on

" set <space> as leader
let mapleader="\<space>"

" reload files changed outside vim
set autoread

" encoding is utf 8
set encoding=utf-8
set fileencoding=utf-8

" enable matchit plugin which ships with vim and greatly enhances '%'
runtime macros/matchit.vim

" dont't unload buffers when they are abandoned, instead stay in the
" background
set hidden

" set unix line endings
set fileformat=unix
" when reading files try unix line endings then dos, also use unix for new buffers
set fileformats=unix,dos

if has("gui_running")
	" hide unnecessary gui in gVim
	set guioptions-=m  " remove menu bar
	set guioptions-=T  " remove toolbar
	set guioptions-=r  " remove right-hand scroll bar
	set guioptions-=L  " remove left-hand scroll bar
	set linespace=3

	" When pressing <D-s> in gvim go to normal mode
	iunmenu File.Save
	imenu <silent> File.Save <Esc>:if expand("%") == ""<Bar>browse confirm w<Bar>else<Bar>confirm w<Bar>endif<CR>
end

" remove the .ext~ files, but not the swapfiles
set nobackup
set writebackup
set noswapfile

" search settings
set incsearch        " find the next match as we type the search
set hlsearch         " hilight searches by default

" keep the cursor visible within 3 lines when scrolling
set scrolloff=3

" indentation
set autoindent      " autoindent based on line above, works most of the time
set smartindent     " smarter indent for C-like languages
set noexpandtab
set copyindent
set preserveindent
set softtabstop=0
set shiftwidth=2
set tabstop=2

"show status all the time
set laststatus=2

" no lines longer than 80 cols
set textwidth=80

" UndoTree
nnoremap <F5> :UndotreeToggle<cr>
if has("persistent_undo")
	set undodir='~/.undodir/'
	set undofile
endif

if has('nvim')
	" Python in NeoVim
	let g:python_host_prog = '/usr/local/bin/python'
endif
" Syntastic
let g:syntastic_check_on_open=1
let g:syntastic_javascript_checkers=['standard']

" Airline
let g:airline_powerline_fonts = 1
let g:airline_theme='gruvbox'

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "plugged/vim-snippets/UltiSnips"]

" Emmet
imap <C-e> <C-Y>,

" CTRL-P
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git|bower_components\'
let g:ctrlp_working_path_mode = 'ra'
map <Leader>d :CtrlPBuffer<CR>

" JsBeautify
autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
autocmd FileType html.handlebars noremap <buffer> <c-f> :call HtmlBeautify()<cr>
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>

" Moving lines
nnoremap <silent> <C-k> :move-2<cr>
nnoremap <silent> <C-j> :move+<cr>
nnoremap <silent> <C-h> <<
nnoremap <silent> <C-l> >>
xnoremap <silent> <C-k> :move-2<cr>gv
xnoremap <silent> <C-j> :move'>+<cr>gv
xnoremap <silent> <C-h> <gv
xnoremap <silent> <C-l> >gv
xnoremap < <gv
xnoremap > >gv

" Switch window
nnoremap <tab>   <c-w>w
nnoremap <S-tab> <c-w>W

" Colorscheme and font
colorscheme gruvbox
set background=dark
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h13
