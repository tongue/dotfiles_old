call plug#begin('~/.vim/plugged')
	" Extend
	Plug 'nathanaelkane/vim-indent-guides'
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
	Plug 'tpope/vim-fugitive'
	Plug 'SirVer/ultisnips'
	Plug 'honza/vim-snippets'
	Plug 'mbbill/undotree'
	Plug 'dyng/ctrlsf.vim'
	Plug 'myusuf3/numbers.vim'
	Plug 'terryma/vim-multiple-cursors'
	Plug 'terryma/vim-expand-region'
	Plug 'vim-scripts/gitignore'
	Plug 'jiangmiao/auto-pairs'
	Plug 'ntpeters/vim-better-whitespace'
	Plug 'kshenoy/vim-signature'
	Plug 'ervandew/supertab'
	Plug 'mattn/emmet-vim'
	Plug 'rstacruz/vim-hyperstyle'
	" Colorscheme
	Plug 'morhetz/gruvbox'
	" Backend syntax
	Plug 'vim-scripts/aspnetcs'
	Plug 'OrangeT/vim-csharp'
	" Frontend syntax
	Plug 'cakebaker/scss-syntax.vim'
	Plug 'briancollins/vim-jst'
	Plug 'groenewege/vim-less'
	Plug 'pangloss/vim-javascript'
	Plug 'hail2u/vim-css3-syntax'
	Plug 'othree/yajs.vim'
	Plug 'othree/javascript-libraries-syntax.vim'
	Plug 'sheerun/vim-json'
	Plug 'mustache/vim-mustache-handlebars'
call plug#end()

" Set 256 colors
set t_Co=256
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

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
end

" remove the .ext~ files, but not the swapfiles
set nobackup
set writebackup
set noswapfile

" search settings
set incsearch        " find the next match as we type the search
set hlsearch         " hilight searches by default

" keep the cursor visible within 3 lines when scrolling
set scrolloff=7

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

" Sginify
nnoremap <F4> :SignifyToggle<CR>
let g:signify_vcs_list = ['git', 'svn']

" UndoTree
nnoremap <F5> :UndotreeToggle<CR>
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
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
if file_readable('.jshintrc')
	let g:syntastic_javascript_jshint_args = '--config .jshintrc'
else
	let g:syntastic_javascript_jshint_args = '--config ~/.jshintrc'
endif

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "plugged/vim-snippets/UltiSnips"]

" Emmet
let g:user_emmet_install_global = 0
autocmd FileType html EmmetInstall

" CTRL-P
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git|bower_components\'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_use_caching = 0

" CTRL-P use .gitignore to exclude files
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor

  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
	let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
	let g:ctrlp_prompt_mappings = {
					\ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
				\ }
endif

" Javascript stuff
let g:used_javascript_libs = 'underscore,backbone,jquery,requirejs,handlebars'

" Remap CTRL-P
nnoremap <Leader>e :CtrlPBuffer<CR>
nnoremap <Leader>o :CtrlP<CR>

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

" Vim expand region
map J <Plug>(expand_region_expand)
map K <Plug>(expand_region_shrink)

" Switch window
nnoremap <tab>   <c-w>w
nnoremap <S-tab> <c-w>W

" Check if file has been changed externaly
autocmd CursorHold * checktime

" CtrlSF mappings
nmap     <Leader>ff <Plug>CtrlSFPrompt
vmap     <Leader>fF <Plug>CtrlSFVwordPath
vmap     <Leader>ff <Plug>CtrlSFVwordExec
nmap     <Leader>fn <Plug>CtrlSFCwordPath
nmap     <Leader>fp <Plug>CtrlSFPwordPath
nnoremap <Leader>fo :CtrlSFOpen<CR>
nnoremap <Leader>ft :CtrlSFToggle<CR>
inoremap <Leader>ft <Esc>:CtrlSFToggle<CR>

" Netrw settings
let g:netrw_liststyle=0
let g:netrw_banner=0
let g:netrw_altv=1
let g:netrw_preview=1

" remap ESC
inoremap jk <esc>

set timeoutlen=1000 ttimeoutlen=0

" Airline
let g:airline_powerline_fonts = 1
let g:airline_theme='gruvbox'

" startify
let g:startify_list_order = ['sessions', 'files', 'dir', 'bookmarks']

" Supertab
let g:SuperTabDefaultCompletionType = "context"

" Colorscheme
colorscheme gruvbox
let g:gruvbox_contrast_dark='soft'
set background=dark
