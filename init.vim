filetype plugin indent on

let g:python_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'
" Faster startup time on neovim
let g:python_host_skip_check = 1
let g:python3_host_skip_check = 1
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let $LANG = 'en'

let g:mapleader = "\<Space>"

call plug#begin('~/.config/nvim/plugged') " Plugins initialization start

" Appearance
" ====================================================================
Plug 'tongue/vim-colors-paramount'

" Completion
" ====================================================================
Plug 'roxma/nvim-completion-manager', {'do': 'npm install'}
" (optional) javascript completion
Plug 'roxma/nvim-cm-tern',  {'do': 'npm install'}
" (optional) language server protocol framework
Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }

" don't give |ins-completion-menu| messages.  For example,
" '-- XXX completion (YYY)', 'match 1 of 2', 'The only match',
set shortmess+=c
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

Plug 'Shougo/neoinclude.vim'
Plug 'Shougo/neco-syntax'
Plug 'Shougo/neosnippet'
let g:neosnippet#snippets_directory = '~/dotfiles/neovim/snippets'
let g:neosnippet#data_directory = $HOME . '/.config/nvim/cache/neosnippet'
let g:neosnippet#disable_runtime_snippets = { '_' : 1 }

nnoremap <leader>se :NeoSnippetEdit -split<CR>
nnoremap <leader>sc :NeoSnippetClearMarkers<CR>

imap <expr><TAB> neosnippet#expandable() ?
			\ "\<Plug>(neosnippet_expand)"
			\ : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() ?
			\ "\<Plug>(neosnippet_expand)"
			\ : "\<TAB>"

" jump to the next snippet trigger or move to the right split
nmap <expr><C-l> neosnippet#jumpable() ?
			\ ":call feedkeys('i<C-l>')<CR>"
			\ : ":diffupdate<CR>:redraw!<CR>"
" jump to the next snippet trigger or redraw a screen
" (default <C-l> behaviour in normal mode)
imap <expr><C-l> neosnippet#jumpable() ?
			\ "\<Plug>(neosnippet_jump)"
			\ : "<ESC>:redraw!<CR>a"
smap <expr><C-l> neosnippet#jumpable() ?
			\ "\<Plug>(neosnippet_jump)" :
			\ "\<C-l>"
xmap <C-l> <Plug>(neosnippet_expand_target)

" File Navigation
" ====================================================================
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
let g:fzf_layout = { 'window': 'enew' }
nnoremap <leader>o :GFiles<CR>
nnoremap <leader>e :Buffers<CR>
nnoremap <leader>i :Files<CR>
nnoremap <leader>u :Ag<CR>
nnoremap <leader>r :e#<CR>

Plug 'scrooloose/nerdtree'
let NERDTreeStatusline="NERDTree"
let NERDTreeMinimalUI=1
let NERDTreeWinSize=40
let NERDTreeShowHidden=1
silent! map <F1> :NERDTreeToggle<CR>
silent! map <F2> :NERDTreeFind<CR>

" Text Navigation
" ====================================================================
Plug 'unblevable/quick-scope'
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" Text Manipulation
" ====================================================================
Plug 'tpope/vim-unimpaired'
Plug 'tmhedberg/matchit'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-commentary'
Plug 'Raimondi/delimitMate'
  let delimitMate_expand_cr = 2
  let delimitMate_expand_space = 1 " {|} => { | }

Plug 'AndrewRadev/splitjoin.vim'

" Languages
" ====================================================================
Plug 'w0rp/ale'
let g:ale_linters = {
\   'javascript': ['eslint', 'flow'],
\}
let g:ale_sign_column_always = 1
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
let g:ale_statusline_format = ['❌: %d', '⚠️ : %d', '💚']
let g:ale_lint_on_save = 0
let g:ale_lint_on_text_changed = 1

nmap <silent> <Up> <Plug>(ale_previous_wrap)
nmap <silent> <Down> <Plug>(ale_next_wrap)

Plug 'mattn/emmet-vim'
let g:user_emmet_expandabbr_key = '<c-e>'
let g:user_emmet_mode='i'

Plug 'hail2u/vim-css3-syntax'
Plug 'sheerun/vim-json'
Plug 'mustache/vim-mustache-handlebars'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
let g:jsx_ext_required = 0

" VCS
" ====================================================================
Plug 'tpope/vim-fugitive'

" Utility
" ====================================================================
Plug 'junegunn/vim-peekaboo'
Plug 'mbbill/undotree'
set undofile
" Auto create undodir if not exists
let undodir = expand($HOME . '/.config/nvim/cache/undodir')
if !isdirectory(undodir)
	call mkdir(undodir, 'p')
endif
let &undodir = undodir

nnoremap <F11> :UndotreeToggle<CR>

" Plug 'terryma/vim-multiple-cursors'
Plug 'dyng/ctrlsf.vim'
let g:ctrlsf_default_root = 'project'
nmap <Leader>ff <Plug>CtrlSFPrompt
vmap <Leader>ff <Plug>CtrlSFPromptExec
nnoremap <Leader>ft :CtrlSFToggle<CR>
inoremap <Leader>ft <Esc>:CtrlSFToggle<CR>

Plug 'tpope/vim-repeat'
Plug 'lilydjwg/colorizer'
Plug 'bronson/vim-trailing-whitespace'
Plug 'grassdog/tagman.vim'

set statusline=%<%f\ %h%m%r
set statusline+=%=
set statusline+=\ 
set statusline+=%{ALEGetStatusLine()}
set statusline+=\ 
set statusline+=%y
set statusline+=%{fugitive#statusline()}

call plug#end()

" General settings
" ====================================================================
syntax on " syntax highlighting

set relativenumber " use relative lines numbering by default
set number         " show line numbers
set noswapfile     " disable creating of *.swp files
set hidden         " hide buffers instead of closing
set nolazyredraw     " speed up on large files
set mouse=         " disable mouse
set visualbell
set autoread			" reload files outside vim

set scrolloff=8
set undolevels=5000     " set maximum undo levels

" ! save global variables that doesn't contains lowercase letters
" h disable the effect of 'hlsearch' when loading the viminfo
" f1 store marks
" '100 remember 100 previously edited files
set viminfo=!,h,f1,'100

set foldmethod=manual       " use manual folding
set diffopt=filler,vertical " default behavior for diff

set listchars=tab:•·,trail:·,extends:❯,precedes:❮,nbsp:×

set showcmd      " always show current command

set nowrap        " disable wrap for long lines
set textwidth=0   " disable auto break long lines

" Indentation
" ====================================================================
set noexpandtab
set tabstop=2     " number of spaces that a <Tab> in the file counts for
set softtabstop=0 " remove <Tab> symbols as it was spaces
set shiftwidth=2  " indent size for << and >>
set shiftround    " round indent to multiple of 'shiftwidth' (for << and >>)

" Search
" ====================================================================
set ignorecase " ignore case of letters
set smartcase  " override the 'ignorecase' when there is uppercase letters
set gdefault   " when on, the :substitute flag 'g' is default on

" Colors and highlightings {{{
" ====================================================================
set background=dark
colorscheme paramount

set cursorline     " highlight current line
" Key Mappings

" Quick way to save file
nnoremap <leader>w :w<CR>

" Disable search highlighting
nnoremap <silent> <Esc><Esc> :nohlsearch<CR><Esc>

" Go to visual line mode
nmap <Leader><Leader> V

" Moving lines
nnoremap <silent> <c-k> :move-2<cr>
nnoremap <silent> <c-j> :move+<cr>
xnoremap <silent> <c-k> :move-2<cr>gv
xnoremap <silent> <c-j> :move'>+<cr>gv

" Insert new line in normal mode
nmap <cr><cr> o<esc>

nnoremap gp `[v`]

" Cursor configuration
" ====================================================================
" Use a blinking upright bar cursor in Insert mode, a solid block in normal
" and a blinking underline in replace mode
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
  let &t_SI = "\<Esc>[5 q"
  let &t_SR = "\<Esc>[3 q"
  let &t_EI = "\<Esc>[2 q"

"
"Autocommands
" ====================================================================
" Check if file has been changed externaly
autocmd CursorHold * checktime

" Omnifuncs
" ====================================================================
augroup omnifuncs
  autocmd!
  autocmd FileType css,scss,less setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown,handlebars setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
augroup end
