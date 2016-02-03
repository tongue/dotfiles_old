filetype plugin indent on

let g:python_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'
" Faster startup time on neovim
let g:python_host_skip_check = 1
let g:python3_host_skip_check = 1
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

let g:mapleader = "\<Space>"

call plug#begin('~/.config/nvim/plugged') " Plugins initialization start {{{
" }}}

" Appearance
" ====================================================================
Plug 'morhetz/gruvbox'
" {{{
	let g:gruvbox_contrast_dark='soft'
  let g:gruvbox_bold=1
" }}}

" Completion
" ====================================================================
Plug 'Shougo/deoplete.nvim'
" {{{
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#auto_completion_start_length=1

  let g:deoplete#sources={}
  let g:deoplete#sources._    = ['buffer', 'file', 'ultisnips']
  let g:deoplete#sources.ruby = ['buffer', 'member', 'file', 'ultisnips']
  let g:deoplete#sources.vim  = ['buffer', 'member', 'file', 'ultisnips']
  let g:deoplete#sources.css  = ['buffer', 'member', 'file', 'omni', 'ultisnips']
  let g:deoplete#sources.scss = ['buffer', 'member', 'file', 'omni', 'ultisnips']
" }}}
Plug 'Shougo/neoinclude.vim'
Plug 'Shougo/neco-syntax'
Plug 'Shougo/neosnippet'
" {{{
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
" }}}

" File Navigation
" ====================================================================
Plug 'kien/ctrlp.vim'
" {{{
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

" Argument: len
"           a:1
fu! CtrlP_main_status(...)
  let regex = a:3 ? '%2*regex %*' : ''
  let prv = '%#StatusLineNC# '.a:4.' %*'
  let item = ' ' . (a:5 == 'mru files' ? 'mru' : a:5) . ' '
  let nxt = '%#StatusLineNC# '.a:6.' %*'
  let byfname = '%2* '.a:2.' %*'
  let dir = '%#SLBranch# ← %*%#StatusLineNC#' . fnamemodify(getcwd(), ':~') . '%* '

  " only outputs current mode
  retu ' %#SLArrows#»%*' . item . '%#SLArrows#«%* ' . '%=%<' . dir

  " outputs previous/next modes as well
  " retu prv . '%4*»%*' . item . '%4*«%*' . nxt . '%=%<' . dir
endf

" StatusLine: 
" Arguments: focus, byfname, s:regexp, prv, item, nxt, marked
"            a:1    a:2      a:3       a:4  a:5   a:6  a:7
fu! CtrlP_progress_status(...)
  let len = '%#Function# '.a:1.' %*'
  let dir = ' %=%<%#LineNr# '.getcwd().' %*'
  retu len.dir
endf

let g:ctrlp_status_func = {
  \ 'main': 'CtrlP_main_status',
  \ 'prog': 'CtrlP_progress_status'
  \}
" }}}
Plug 'tpope/vim-vinegar'

" Text Navigation
" ====================================================================
Plug 'unblevable/quick-scope'
" {{{
" let g:qs_first_occurrence_highlight_color = '#afff5f' 
" let g:qs_second_occurrence_highlight_color = '#5fffff'
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
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

" Text Objects
" ====================================================================
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'poetic/vim-textobj-javascript'

" Languages
" ====================================================================
Plug 'benekastah/neomake'
" {{{
  let g:neomake_airline = 1
  let g:neomake_error_sign = { 'text': '❌' }
  let g:neomake_warning_sign = { 'text': '⚠️' }

	let g:neomake_javascript_enabled_makers = ['eslint']

	" npm install -g eslint
	autocmd BufWritePost *.js Neomake eslint
  map <F4> :lopen<CR>
" }}}
Plug 'mattn/emmet-vim'
" {{{
  let g:user_emmet_expandabbr_key = '<c-e>'
  let g:user_emmet_install_global = 1
" }}}
Plug 'ap/vim-css-color'
Plug 'cakebaker/scss-syntax.vim'
Plug 'groenewege/vim-less'
Plug 'hail2u/vim-css3-syntax'
Plug 'sheerun/vim-json'
Plug 'mustache/vim-mustache-handlebars'

" VCS
" ====================================================================
Plug 'mhinz/vim-signify'
" {{{
let g:signify_vcs_list = ['git', 'svn']
" "}}}
Plug 'tpope/vim-fugitive'

" Utility
" ====================================================================
Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }
" {{{
nnoremap <silent> <Leader>q :Sayonara<CR>
" }}}
Plug 'junegunn/vim-peekaboo'
" {{{
  let g:peekaboo_delay = 400
" }}}
Plug 'mbbill/undotree'
" {{{
  set undofile
  " Auto create undodir if not exists
  let undodir = expand($HOME . '/.config/nvim/cache/undodir')
  if !isdirectory(undodir)
    call mkdir(undodir, 'p')
  endif
  let &undodir = undodir

  nnoremap <F11> :UndotreeToggle<CR>
" }}}
Plug 'terryma/vim-multiple-cursors'
Plug 'dyng/ctrlsf.vim'
" {{{
  let g:ctrlsf_default_root = 'project'
  nmap <Leader>ff <Plug>CtrlSFPrompt
  vmap <Leader>ff <Plug>CtrlSFPromptExec
  nnoremap <Leader>ft :CtrlSFToggle<CR>
  inoremap <Leader>ft <Esc>:CtrlSFToggle<CR>
" }}}
Plug 'tpope/vim-repeat'
Plug 'kshenoy/vim-signature'

call plug#end() " Plugins initialization finished {{{
" }}}

" General settings {{{
" ====================================================================
syntax on " syntax highlighting

set number         " show line numbers
set norelativenumber " use relative lines numbering by default
set noswapfile     " disable creating of *.swp files
set hidden         " hide buffers instead of closing
set lazyredraw     " speed up on large files
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
" }}}
" Key Mappings " {{{

" Quick way to save file
nnoremap <leader>w :w<CR>

" Disable search highlighting
nnoremap <silent> <Esc><Esc> :nohlsearch<CR><Esc>

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

map ö [
map ä ]
map Ö {
map Ä }

nnoremap gp `[v`]
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
" Statusline {{{
" ====================================================================
" Dynamically getting the fg/bg colors from the current colorscheme, returns hex which is enough for me to use in Neovim
" Needs to figure out how to return cterm values too
let fgcolor=synIDattr(synIDtrans(hlID("Normal")), "fg", "gui")
let bgcolor=synIDattr(synIDtrans(hlID("Normal")), "bg", "gui")

" Statusline
" https://github.com/Greduan/dotfiles/blob/76e16dd8a04501db29989824af512c453550591d/vim/after/plugin/statusline.vim
let g:currentmode={
      \ 'n'  : 'NORMAL ',
      \ 'no' : 'N·Operator Pending ',
      \ 'v'  : 'VISUAL ',
      \ 'V'  : 'V·Line ',
      \ '' : 'V·Block ',
      \ 's'  : 'Select ',
      \ 'S'  : 'S·Line ',
      \ '' : 'S·Block ',
      \ 'i'  : 'INSERT ',
      \ 'R'  : 'REPLACE ',
      \ 'Rv' : 'V·Replace ',
      \ 'c'  : 'Command ',
      \ 'cv' : 'Vim Ex ',
      \ 'ce' : 'Ex ',
      \ 'r'  : 'Prompt ',
      \ 'rm' : 'More ',
      \ 'r?' : 'Confirm ',
      \ '!'  : 'Shell ',
      \ 't'  : 'Terminal '
      \}

" " Automatically change the statusline color depending on mode
function! ChangeStatuslineColor()
  if (mode() =~# '\v(n|no)')
    exe 'hi! StatusLine guifg=#928374'
  elseif (mode() =~# '\v(v|V)' || g:currentmode[mode()] ==# 'V·Block' || get(g:currentmode, mode(), '') ==# 't')
    exe 'hi! StatusLine guifg=#d65d0e'
  elseif (mode() ==# 'i')
    exe 'hi! StatusLine guifg=#b8bb26'
  else
    exe 'hi! StatusLine guifg=#fb4934'
  endif

  return ''
endfunction

function! ReadOnly()
  if &readonly || !&modifiable
    return '🔒'
	else
    return ''
endfunction


" " http://stackoverflow.com/a/10416234/213124
set laststatus=2
set statusline=
set statusline+=%{ChangeStatuslineColor()}               " Changing the statusline color
set statusline+=%0*\ %{toupper(g:currentmode[mode()])}   " Current mode
set statusline+=%{ReadOnly()}\ \ %F\ %m\ %w\        " File+path
set statusline+=\ %=
" set statusline+=%y                                 " FileType
" set statusline+=%0*\ 🔃\ %3p%%\                " Rownumber/total (%)
set statusline+=\%{neomake#statusline#LoclistStatus('\ 😡\ \ ')}
set statusline+=%0*\ 
"}}}
" CTAGS {{{
" ====================================================================
set tags+=.tags

function! GenerateCtags() abort

  silent execute '!ctags  --extra=+f -Rf .tags'
        \ '--exclude=.git --exclude=node_modules --exclude=bower_components --exclude=.meteor --languages=-sql'
  echom 'Tags generated into .tags file!'
endfunction
command! GenerateCT :call GenerateCtags()
" }}}
" Autocommands {{{
" ====================================================================
" Check if file has been changed externaly
autocmd CursorHold * checktime
" }}}
" vim: set sw=2 ts=2 et foldlevel=0 foldmethod=marker:
