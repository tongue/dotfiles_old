" set <space> as leader
let g:mapleader="\<space>"

" make vim try to detect file types and load plugins for them
filetype on
filetype plugin on
filetype indent on

call plug#begin('~/.vim/plugged')
	" Colorscheme
	Plug 'morhetz/gruvbox'
	let g:gruvbox_contrast_dark='soft'

	Plug 'tmhedberg/matchit'
	Plug 'nathanaelkane/vim-indent-guides'
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-sensible'
	Plug 'tpope/vim-vinegar'
	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-ragtag'
	Plug 'tpope/vim-fugitive'
	Plug 'tpope/vim-repeat'
	Plug 'terryma/vim-multiple-cursors'
	Plug 'vim-scripts/gitignore'
	Plug 'ntpeters/vim-better-whitespace'
	Plug 'kshenoy/vim-signature'
	Plug 'rstacruz/vim-hyperstyle'
	Plug 'kana/vim-textobj-user'
	Plug 'poetic/vim-textobj-javascript'
	Plug 'AndrewRadev/splitjoin.vim'
	Plug 'mtth/scratch.vim'
	Plug 'jeffkreeftmeijer/vim-numbertoggle'

	Plug 'Raimondi/delimitMate'
	let delimitMate_expand_cr=1

	Plug 'bling/vim-airline'
	let g:airline_powerline_fonts=1
	let g:airline_theme='gruvbox'
	let g:airline#extensions#hunks#enabled=0
	let g:airline#extensions#default#layout = [
			\ [ 'a', 'b', 'c' ],
			\ [ 'x', 'z', 'warning' ]
		\ ]

	Plug 'scrooloose/syntastic'
	let g:syntastic_check_on_open=1
	let g:syntastic_javascript_checkers = ['jshint']
	let g:syntastic_error_symbol='✗'
	let g:syntastic_warning_symbol='⚠'

	Plug 'kien/ctrlp.vim'
	let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git|bower_components\'
	let g:ctrlp_working_path_mode = 'ra'
	let g:ctrlp_use_caching=0
	" use .gitignore to exclude files
	if executable('ag')
		set grepprg=ag\ --nogroup\ --nocolor
		let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
	else
		let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
		let g:ctrlp_prompt_mappings = {
						\ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
					\ }
	endif
	nnoremap <Leader>e :CtrlPBuffer<CR>
	nnoremap <Leader>o :CtrlP<CR>

	Plug 'mhinz/vim-signify'
	let g:signify_vcs_list = ['git', 'svn']

	Plug 'mhinz/vim-startify'
	let g:startify_list_order = ['sessions', 'files', 'dir', 'bookmarks']

	Plug 'SirVer/ultisnips'
	Plug 'honza/vim-snippets'
	let g:UltiSnipsExpandTrigger="<tab>"
	let g:UltiSnipsJumpForwardTrigger="<tab>"
	let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
	let g:UltiSnipsSnippetDirectories=["UltiSnips", "plugged/vim-snippets/UltiSnips"]

	Plug 'mbbill/undotree'
	nnoremap <F5> :UndotreeToggle<CR>
	if has("persistent_undo")
		set undodir='~/.undodir/'
		set undofile
	endif

	Plug 'dyng/ctrlsf.vim'
	let g:ctrlsf_default_root='project'
	nmap <Leader>ff <Plug>CtrlSFPrompt
	vmap <Leader>fF <Plug>CtrlSFVwordPath
	vmap <Leader>ff <Plug>CtrlSFVwordExec
	nmap <Leader>fn <Plug>CtrlSFCwordPath
	nmap <Leader>fp <Plug>CtrlSFPwordPath
	nnoremap <Leader>fo :CtrlSFOpen<CR>
	nnoremap <Leader>ft :CtrlSFToggle<CR>
	inoremap <Leader>ft <Esc>:CtrlSFToggle<CR>

	Plug 'terryma/vim-expand-region'
	vmap v <Plug>(expand_region_expand)
	vmap <C-v> <Plug>(expand_region_shrink)

	Plug 'mattn/emmet-vim'
	let g:user_emmet_install_global=0
	autocmd FileType html,html.handlebars EmmetInstall

	Plug 'marijnh/tern_for_vim', {'do': 'npm install'}
	let g:tern_show_argument_hints='on_hold'
	nmap <Leader>td :TernDef<cr>
	nmap <Leader>tr :TernRefs<cr>

	" Close Scratch when exiting Insert mode
	autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
	autocmd InsertLeave * if pumvisible() == 0|pclose|endif

	" Backend syntax
	Plug 'vim-scripts/aspnetcs'
	Plug 'OrangeT/vim-csharp'

	" Frontend syntax
	Plug 'cakebaker/scss-syntax.vim'
	Plug 'briancollins/vim-jst'
	Plug 'groenewege/vim-less'
	Plug 'pangloss/vim-javascript'
	Plug 'hail2u/vim-css3-syntax'
	Plug 'sheerun/vim-json'
	Plug 'mustache/vim-mustache-handlebars'

	Plug 'othree/yajs.vim'
	Plug 'othree/javascript-libraries-syntax.vim'
	let g:used_javascript_libs = 'underscore,backbone,jquery,requirejs,handlebars'
call plug#end()


if has("gui_running")
	" hide unnecessary gui in gVim
	set guioptions-=m  " remove menu bar
	set guioptions-=T  " remove toolbar
	set guioptions-=r  " remove right-hand scroll bar
	set guioptions-=L  " remove left-hand scroll bar
	set linespace=3
end

if has('nvim')
	" Python in NeoVim
	let g:python_host_prog = '/usr/local/bin/python'
	let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

" Set 256 colors
set t_Co=256

" Disable bell
set visualbell

" turn on syntax highlighting
syntax on

" and show line numbers
set relativenumber

" Highlight current line
set cursorline

" reload files changed outside vim
set autoread

" encoding is utf 8
set fileencoding=utf-8

" enable mouse
set mouse=a

" dont't unload buffers when they are abandoned, instead stay in the background
set hidden

" set unix line endings
set fileformat=unix
" when reading files try unix line endings then dos, also use unix for new buffers
set fileformats=unix,dos

" remove the .ext~ files, but not the swapfiles
set nobackup
set writebackup
set noswapfile

" search settings
set incsearch        " find the next match as we type the search
set hlsearch         " hilight searches by default

" keep the cursor visible within 3 lines when scrolling
set scrolloff=8

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
set textwidth=300

" Disable strange Vi defaults
set nocompatible

" Allow for mappings including <Esc>
set ttimeout
set timeoutlen=500

" Set default whitespace caracters
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+

" Save file
nnoremap <Leader>w :w<CR>

" Go to visual line mode
nmap <Leader><Leader> V

" Copy and paste to system clipboard
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" Moving lines
nnoremap <silent> <C-k> :move-2<cr>
nnoremap <silent> <C-j> :move+<cr>
nnoremap <silent> <C-h> <<
nnoremap <silent> <C-l> >>
xnoremap <silent> <C-k> :move-2<cr>gv
xnoremap <silent> <C-j> :move'>+<cr>gv
xnoremap <silent> <C-l> >gv
xnoremap <silent> <C-h> <gv
xnoremap < <gv
xnoremap > >gv

" Switch window
nnoremap <tab>   <c-w>w
nnoremap <S-tab> <c-w>W

" Check if file has been changed externaly
autocmd CursorHold * checktime

" Insert new line in normal mode
nmap <cr><cr> o<esc>

" Netrw settings
let g:netrw_liststyle=0
let g:netrw_banner=0
let g:netrw_altv=1

set background=dark
colorscheme gruvbox
