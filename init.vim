filetype plugin indent on

let g:python_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'
let g:python_host_skip_check = 1
let g:python3_host_skip_check = 1
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let $LANG = 'en'
let g:mapleader = "\<Space>"

call plug#begin('~/.config/nvim/plugged')
Plug 'ayu-theme/ayu-vim'
Plug 'axvr/photon.vim'
Plug 'gruvbox-community/gruvbox'
Plug 'SirVer/ultisnips'
Plug 'junegunn/vim-peekaboo'
Plug 'andymass/vim-matchup'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'Raimondi/delimitMate'
" Plug 'w0rp/ale'
Plug 'mbbill/undotree'
Plug 'dyng/ctrlsf.vim'
Plug 'sgur/vim-editorconfig'
Plug 'mattn/emmet-vim'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'kshenoy/vim-signature'
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install() }}
" Plug 'neovim/nvim-lsp'
Plug 'airblade/vim-gitgutter'
call plug#end()

" AUTOCMD ==========================================================

" Trigger autoread when changing buffers or coming back to vim.
au FocusGained,BufEnter * :silent! !

" FZF ================================================================
let g:fzf_layout = { 'up': '100%' }

function! s:fzf_ag_raw(cmd)
  call fzf#vim#ag_raw(a:cmd)
endfunction

" DELIMITMATE ========================================================
let delimitMate_expand_cr = 2
let delimitMate_expand_space = 1 " {|} => { | }

" ALE ================================================================
" let g:ale_fixers = {
" 			\   'javascript': ['prettier'],
" 			\   'typescript': ['prettier'],
" 			\   'json': ['prettier'],
" 			\   'svelte': ['prettier'],
" 			\   'css': ['prettier'],
" 			\}
" let g:ale_fix_on_save = 1

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
let NERDTreeHijackNetrw=1

" CTRLSF ===========================================================
let g:ctrlsf_default_root = 'project'
let g:ctrlsf_populate_qflist = 1

" JSX ==============================================================
let g:jsx_ext_required = 0

" MAPPINGS =========================================================
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gd :Gdiff<CR>

nnoremap <leader>w :w<CR>

nnoremap <Leader>v `[v`]

nnoremap <silent> <Esc><Esc> :nohlsearch<CR><Esc>

nnoremap <BS><BS> :only<CR>

nnoremap <leader>o :GFiles<CR>
nnoremap <leader>e :Buffers<CR>
nnoremap <leader>i :Files<CR>
nnoremap <leader>u :Ag<CR>

silent! map <Leader>1 :NERDTreeToggle<CR>
silent! map <Leader>2 :NERDTreeFind<CR>

nmap <silent> <Up> <Plug>(ale_previous_wrap)
nmap <silent> <Down> <Plug>(ale_next_wrap)

nnoremap <Leader>0 :UndotreeToggle<CR>

nmap <Leader>ff <Plug>CtrlSFPrompt
vmap <Leader>ff <Plug>CtrlSFPromptExec
nnoremap <Leader>ft :CtrlSFToggle<CR>
inoremap <Leader>ft <Esc>:CtrlSFToggle<CR>

" UltiSnips
let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsSnippetDirectories=[$HOME.'/dotfiles/UltiSnips']
" The default value for g:UltiSnipsJumpBackwardTrigger interferes with the
" built-in complete function: |i_CTRL-X_CTRL-K|
inoremap <c-x><c-k> <c-x><c-k>

" COC
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

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
set termguicolors
set cursorline
let ayucolor="dark"
" let g:gruvbox_contrast_dark = "soft"
" let g:gruvbox_italic = 1
" let g:gruvbox_underline = 1
" let g:gruvbox_undercurl = 1
colorscheme ayu

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
set statusline+=%{coc#status()}%{get(b:,'coc_current_function','')}
set statusline+=\ 
set statusline+=\ \[%{&fileencoding?&fileencoding:&encoding}\]
set statusline+=\[%{&fileformat}\]
set statusline+=%y
