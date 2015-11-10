filetype plugin indent on

let g:python_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let g:mapleader = "\<Space>"

" Autoinstall vim-plug {{{
if empty(glob('~/.nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif
" }}}
call plug#begin('~/.nvim/plugged') " Plugins initialization start {{{
" }}}

" Appearance
" ====================================================================
Plug 'morhetz/gruvbox'
" {{{
	let g:gruvbox_contrast_dark='soft'
" }}}
Plug 'bling/vim-airline'
" {{{
	let g:airline_theme = 'gruvbox'
  let g:airline_powerline_fonts=1

  let g:airline_section_z = '%2p%% %2l/%L:%2v'
  let g:airline#extensions#hunks#enabled=0
  let g:airline#extensions#default#layout = [
    \ [ 'a', 'b', 'c' ],
    \ [ 'x', 'z', 'warning' ]
  \ ]

" }}}
Plug 'nathanaelkane/vim-indent-guides'
" {{{
  let g:indent_guides_default_mapping = 0
  let g:indent_guides_enable_on_vim_startup = 0
  let g:indent_guides_start_level = 2
  let g:indent_guides_exclude_filetypes = ['help', 'startify', 'man', 'rogue']
" }}}
Plug 'kshenoy/vim-signature'
Plug 'mhinz/vim-startify'
" {{{
  let g:startify_session_dir = '~/.nvim/session'
  let g:startify_list_order = ['sessions']
  let g:startify_session_persistence = 1
  let g:startify_session_delete_buffers = 1
  let g:startify_change_to_dir = 1
  let g:startify_change_to_vcs_root = 1
  nnoremap <F12> :Startify<CR>
  autocmd! User Startified setlocal colorcolumn=0
" }}}
Plug 't9md/vim-choosewin'
" {{{
  nmap <leader>' <Plug>(choosewin)
  let g:choosewin_blink_on_land = 0
  let g:choosewin_tabline_replace = 0
" }}}

" Completion
" ====================================================================
Plug 'Shougo/deoplete.nvim'
" {{{
  let g:deoplete#enable_at_startup = 1
" }}}
Plug 'Shougo/neoinclude.vim'
Plug 'Shougo/neco-syntax'
Plug 'Shougo/neosnippet'
" {{{
  let g:neosnippet#snippets_directory = '~/.nvim/snippets'
  let g:neosnippet#data_directory = $HOME . '/.nvim/cache/neosnippet'
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
" }}}

" File Navigation
" ====================================================================
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

Plug 'tpope/vim-vinegar'
Plug 'ryanoasis/vim-devicons'

" Text Navigation
" ====================================================================
Plug 'Lokaltog/vim-easymotion'
" {{{
  let g:EasyMotion_do_mapping = 0
  let g:EasyMotion_smartcase = 1
  let g:EasyMotion_off_screen_search = 0
  nmap ; <Plug>(easymotion-s2)
" }}}
Plug 'rhysd/clever-f.vim'
" {{{
  let g:clever_f_across_no_line = 1
" }}}

" Text Manipulation
" ====================================================================
Plug 'tmhedberg/matchit'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'Raimondi/delimitMate'
" {{{
  let delimitMate_expand_cr = 2
  let delimitMate_expand_space = 1 " {|} => { | }
" }}}
Plug 'AndrewRadev/splitjoin.vim'
Plug 'AndrewRadev/sideways.vim'
" {{{
  nnoremap <Leader>< :SidewaysLeft<CR>
  nnoremap <Leader>> :SidewaysRight<CR>
" }}}
Plug 'maksimr/vim-jsbeautify', { 'for': ['javascript', 'json'] }
map <Leader>b :call JsBeautify()<cr>

" Text Objects
" ====================================================================
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'poetic/vim-textobj-javascript'

" Languages
" ====================================================================
Plug 'benekastah/neomake'
" {{{
  autocmd! BufWritePost * Neomake
  let g:neomake_airline = 1
  let g:neomake_error_sign = { 'text': '✘', 'texthl': 'ErrorSign' }
  let g:neomake_warning_sign = { 'text': '⚠', 'texthl': 'WarningSign' }

	let g:neomake_javascript_jshint_maker = {
    \ 'args': ['--verbose'],
    \ 'errorformat': '%A%f: line %l\, col %v\, %m \(%t%*\d\)',
    \ }
	let g:neomake_javascript_enabled_makers = ['jshint']

	autocmd! BufWritePost * Neomake
  map <F4> :lopen<CR>
" }}}
Plug 'mattn/emmet-vim'
" {{{
  let g:user_emmet_expandabbr_key = '<c-e>'
" }}}
Plug 'Valloric/MatchTagAlways'
Plug 'tpope/vim-ragtag'
" {{{
  let g:ragtag_global_maps = 1
" }}}
Plug 'ap/vim-css-color'
Plug 'vim-scripts/aspnetcs'
Plug 'OrangeT/vim-csharp'
Plug 'cakebaker/scss-syntax.vim'
Plug 'briancollins/vim-jst'
Plug 'groenewege/vim-less'
Plug 'hail2u/vim-css3-syntax'
Plug 'sheerun/vim-json'
Plug 'mustache/vim-mustache-handlebars'
Plug 'othree/yajs.vim'
Plug 'othree/javascript-libraries-syntax.vim'
let g:used_javascript_libs = 'underscore,backbone,jquery,requirejs,handlebars'

" VCS
" ====================================================================
Plug 'mhinz/vim-signify'
let g:signify_vcs_list = ['git', 'svn']

" Utility
" ====================================================================
Plug 'tyru/open-browser.vim'
" {{{
  let g:netrw_nogx = 1
  vmap gx <Plug>(openbrowser-smart-search)
  nmap gx <Plug>(openbrowser-search)
" }}}
Plug 'Shougo/junkfile.vim'
" {{{
  nnoremap <leader>jo :JunkfileOpen
  let g:junkfile#directory = $HOME . '/.nvim/cache/junkfile'
" }}}
Plug 'junegunn/vim-peekaboo'
" {{{
  let g:peekaboo_delay = 400
" }}}
Plug 'mbbill/undotree'
" {{{
  set undofile
  " Auto create undodir if not exists
  let undodir = expand($HOME . '/.nvim/cache/undodir')
  if !isdirectory(undodir)
    call mkdir(undodir, 'p')
  endif
  let &undodir = undodir

  nnoremap <F11> :UndotreeToggle<CR>
" }}}
Plug 'terryma/vim-multiple-cursors'

call plug#end() " Plugins initialization finished {{{
" }}}

" General settings {{{
" ====================================================================
syntax on " syntax highlighting

set clipboard=unnamed,unnamedplus
set number         " show line numbers
set relativenumber " use relative lines numbering by default
set noswapfile     " disable creating of *.swp files
set hidden         " hide buffers instead of closing
set lazyredraw     " speed up on large files
set mouse=         " disable mouse
set visualbell

set scrolloff=8
set undolevels=5000     " set maximum undo levels

" ! save global variables that doesn't contains lowercase letters
" h disable the effect of 'hlsearch' when loading the viminfo
" f1 store marks
" '100 remember 100 previously edited files
set viminfo=!,h,f1,'100

set foldmethod=manual       " use manual folding
set diffopt=filler,vertical " default behavior for diff

" ignore pattern for wildmenu
set wildignore+=*.a,*.o,*.pyc,*~,*.swp,*.tmp
set wildmode=list:longest,full

set listchars=tab:•·,trail:·,extends:❯,precedes:❮,nbsp:×

set laststatus=2 " always show status line
set showcmd      " always show current command

set nowrap        " disable wrap for long lines
set textwidth=0   " disable auto break long lines
" }}}
" Indentation {{{
" ====================================================================
set noexpandtab
set tabstop=2     " number of spaces that a <Tab> in the file counts for
set softtabstop=0 " remove <Tab> symbols as it was spaces
set shiftwidth=2  " indent size for << and >>
set shiftround    " round indent to multiple of 'shiftwidth' (for << and >>)
" }}}
" Search {{{
" ====================================================================
set ignorecase " ignore case of letters
set smartcase  " override the 'ignorecase' when there is uppercase letters
set gdefault   " when on, the :substitute flag 'g' is default on
" }}}
" Colors and highlightings {{{
" ====================================================================
set background=dark
colorscheme gruvbox

set cursorline     " highlight current line

" NeoMake
highlight! ErrorSign guifg=black guibg=#E01600 ctermfg=16 ctermbg=160
highlight! WarningSign guifg=black guibg=#FFED26 ctermfg=16 ctermbg=11
" }}}
" Key Mappings " {{{
nnoremap <leader>vi :tabedit $MYVIMRC<CR>

" Quick way to save file
nnoremap <leader>w :w<CR>

" Disable search highlighting
nnoremap <silent> <Esc><Esc> :nohlsearch<CR><Esc>

" Keep search results at the center of screen
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

" Select all text
noremap vA ggVG

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
nnoremap <silent> <c-k> :move-2<cr>
nnoremap <silent> <c-j> :move+<cr>
nnoremap <silent> <c-h> <<
nnoremap <silent> <c-l> >>
xnoremap <silent> <c-k> :move-2<cr>gv
xnoremap <silent> <c-j> :move'>+<cr>gv
xnoremap <silent> <c-h> <gv
xnoremap <silent> <c-l> >gv

" Insert new line in normal mode
nmap <cr><cr> o<esc>

" }}}
" Cursor configuration {{{
" ====================================================================
" Use a blinking upright bar cursor in Insert mode, a solid block in normal
" and a blinking underline in replace mode
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
  let &t_SI = "\<Esc>[5 q"
  let &t_SR = "\<Esc>[3 q"
  let &t_EI = "\<Esc>[2 q"
" }}}
" vim: set sw=2 ts=2 et foldlevel=0 foldmethod=marker:
