filetype plugin indent on

let g:python_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'
let g:python_host_skip_check = 1
let g:python3_host_skip_check = 1
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let $LANG = 'en'
let g:mapleader = "\<Space>"

call plug#begin('~/.config/nvim/plugged')
Plug 'tongue/vim-colors-paramount'
Plug 'morhetz/gruvbox'
Plug 'fenetikm/falcon'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'junegunn/vim-peekaboo'
Plug 'tmhedberg/matchit'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-vinegar'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'Raimondi/delimitMate'
Plug 'w0rp/ale'
Plug 'hail2u/vim-css3-syntax'
Plug 'sheerun/vim-json'
Plug 'leafgarland/typescript-vim'
Plug 'mbbill/undotree'
Plug 'dyng/ctrlsf.vim'
Plug 'bronson/vim-trailing-whitespace'
Plug 'sgur/vim-editorconfig'
Plug 'pangloss/vim-javascript'
Plug 'chemzqm/vim-jsx-improve'
Plug 'mhartington/nvim-typescript'
Plug 'calebeby/ncm-css'
Plug 'roxma/nvim-cm-tern',  {'do': 'npm install'}
Plug 'roxma/ncm-flow'
Plug 'mattn/emmet-vim'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'roxma/nvim-completion-manager'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-unimpaired'
Plug 'scrooloose/nerdtree'
Plug 'kshenoy/vim-signature'
Plug 'mustache/vim-mustache-handlebars'
call plug#end()

" AUTOCMD ==========================================================
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS

" FZF ================================================================
let g:fzf_layout = { 'up': '100%' }

function! s:fzf_ag_raw(cmd)
  call fzf#vim#ag_raw(a:cmd)
endfunction

" DELIMITMATE ========================================================
let delimitMate_expand_cr = 2
let delimitMate_expand_space = 1 " {|} => { | }

" ALE ================================================================
let g:ale_linters = {
			\   'javascript': ['flow', 'eslint'],
			\   'typescript': ['tslint'],
			\   'css': ['stylelint'],
			\   'scss': ['stylelint'],
			\}
let g:ale_fixers = {
			\   'javascript': ['prettier'],
			\   'typescript': ['prettier'],
			\   'scss': ['prettier'],
			\}
let g:ale_sign_column_always = 1
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1

" UNDOTREE ===========================================================
set undofile
" Auto create undodir if not exists
let undodir = expand($HOME . '/.config/nvim/cache/undodir')
if !isdirectory(undodir)
	call mkdir(undodir, 'p')
endif
let &undodir = undodir

" NERDTREE ===========================================================
let NERDTreeMinimalUI=1
let NERDTreeShowHidden=1
let NERDTreeHijackNetrw=0
let NERDTreeWinSize=100

" CTRLSF ===========================================================
let g:ctrlsf_default_root = 'project'
let g:ctrlsf_populate_qflist = 1

" JSX ==============================================================
let g:jsx_ext_required = 0

" MAPPINGS =========================================================
" Git
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gd :Gdiff<CR>

" Visual line
nmap <Leader><Leader> V

" Write file
nnoremap <leader>w :w<CR>

" Visually select pasted text
nnoremap <Leader>v `[v`]

" Clear search highlights
nnoremap <silent> <Esc><Esc> :nohlsearch<CR><Esc>

" Only
nnoremap <BS><BS> :only<CR>

" FZF
nnoremap <leader>o :GFiles<CR>
nnoremap <leader>e :Buffers<CR>
nnoremap <leader>i :Files<CR>
nnoremap <leader>u :Ag<CR>

" NerdTree
silent! map <Leader>1 :NERDTreeToggle<CR>
silent! map <Leader>2 :NERDTreeFind<CR>

" ALE
nmap <silent> <Up> <Plug>(ale_previous_wrap)
nmap <silent> <Down> <Plug>(ale_next_wrap)

" UndoTree
nnoremap <Leader>0 :UndotreeToggle<CR>

" CtrlSF
nmap <Leader>ff <Plug>CtrlSFPrompt
vmap <Leader>ff <Plug>CtrlSFPromptExec
nnoremap <Leader>ft :CtrlSFToggle<CR>
inoremap <Leader>ft <Esc>:CtrlSFToggle<CR>

" UltiSnips
" The default value for g:UltiSnipsJumpBackwardTrigger interferes with the
" built-in complete function: |i_CTRL-X_CTRL-K|
inoremap <c-x><c-k> <c-x><c-k>

" LanguageServer
let g:LanguageClient_serverCommands = {
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['javascript-typescript-stdio'],
    \ 'typescript': ['javascript-typescript-stdio'],
    \ }

let g:LanguageClient_diagnosticsEnable = 0
let g:ale_set_highlights = 0

" SETTINGS =========================================================
syntax on

set number
set relativenumber
set noswapfile
set hidden
set nolazyredraw
set mouse=
set visualbell
set autoread

set scrolloff=8
set undolevels=5000

set foldmethod=manual
set diffopt=filler,vertical

set listchars=tab:•·,trail:·,extends:❯,precedes:❮,nbsp:×

set showcmd
set noshowcmd noruler

set nowrap
set textwidth=0

" Indentation
set noexpandtab
set tabstop=2
set softtabstop=0
set shiftwidth=2
set shiftround

" Search
set ignorecase
set smartcase
set gdefault

set background=dark
set cursorline
colorscheme gruvbox

" CURSOR ==========================================================
" Use a blinking upright bar cursor in Insert mode, a solid block in normal
" and a blinking underline in replace mode
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
let &t_SI = "\<Esc>[5 q"
let &t_SR = "\<Esc>[3 q"
let &t_EI = "\<Esc>[2 q"

function! Current_git_branch()
	let l:branch = split(fugitive#statusline(),'[()]')
	if len(l:branch) > 1
		return remove(l:branch, 1)
	endif
	return ""
endfunction

" STATUSLINE ======================================================
set statusline=
set statusline+=%#PmenuSel#
set statusline+=\ 
set statusline+=%{Current_git_branch()}
set statusline+=\ 
set statusline+=%#LineNr#
set statusline+=\ %<%f\ %h%m%r
set statusline+=%=
set statusline+=%{ALEGetStatusLine()}
set statusline+=\ 
set statusline+=\ \[%{&fileencoding?&fileencoding:&encoding}\]
set statusline+=\[%{&fileformat}\]
set statusline+=%y
