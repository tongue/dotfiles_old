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
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'Quramy/tsuquyomi'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'scrooloose/nerdtree'
Plug 'tmhedberg/matchit'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'Raimondi/delimitMate'
Plug 'w0rp/ale'
Plug 'hail2u/vim-css3-syntax'
Plug 'sheerun/vim-json'
Plug 'leafgarland/typescript-vim'
Plug 'mbbill/undotree'
Plug 'dyng/ctrlsf.vim'
Plug 'bronson/vim-trailing-whitespace'
Plug 'prettier/vim-prettier', {
			\ 'do': 'yarn install',
			\ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql'] }
Plug 'sgur/vim-editorconfig'
Plug 'pangloss/vim-javascript'
Plug 'chemzqm/vim-jsx-improve'
Plug 'roxma/nvim-completion-manager'
Plug 'calebeby/ncm-css'
Plug 'roxma/nvim-cm-tern',  {'do': 'npm install'}
Plug 'roxma/ncm-flow'
Plug 'mattn/emmet-vim'
call plug#end()

" AUTOCMD ==========================================================
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS

" FZF ================================================================
let g:fzf_layout = { 'up': '100%' }

function! s:fzf_ag_raw(cmd)
  call fzf#vim#ag_raw(a:cmd)
endfunction

" NERDTREE ===========================================================
let NERDTreeMinimalUI=1
let NERDTreeWinSize=40
let NERDTreeShowHidden=1

" DELIMITMATE ========================================================
let delimitMate_expand_cr = 2
let delimitMate_expand_space = 1 " {|} => { | }

" ALE ================================================================
let g:ale_linters = {
			\   'javascript': ['flow', 'eslint'],
			\   'typescript': ['tslint'],
			\   'css': ['stylelint'],
			\}
let g:ale_fixers = {
			\   'javascript': ['prettier'],
			\   'typescript': ['prettier'],
			\   'css': ['prettier'],
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

" CTRLSF ===========================================================
let g:ctrlsf_default_root = 'project'
let g:ctrlsf_populate_qflist = 1

" PRETTIER =========================================================
let g:prettier#config#print_width = 80
let g:prettier#config#tab_width = 2
let g:prettier#config#use_tabs = 'true'
let g:prettier#config#semi = 'true'
let g:prettier#config#single_quote = 'false'
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#jsx_bracket_same_line = 'false'
let g:prettier#config#trailing_comma = 'none'
let g:prettier#config#parser = 'typescript'
let g:prettier#config#config_precedence = 'cli-override'

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

" STATUSLINE ======================================================
set statusline=%<%f\ %h%m%r
set statusline+=%=
set statusline+=\ 
set statusline+=%{ALEGetStatusLine()}
set statusline+=\ 
set statusline+=%y
set statusline+=%{fugitive#statusline()}
