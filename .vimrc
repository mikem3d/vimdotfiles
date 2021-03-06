" tlack's vimrc
"

set nocompatible  " Use Vim defaults (much better!)
set bs=indent,eol,start   " allow backspacing over everything in insert mode
set backup   

"syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

"if &term=="xterm"
"     set t_Co=8
"     set t_Sb=^[[4%dm
"     set t_Sf=^[[3%dm
"endif

set t_Co=256
" colors zenburn
colors lucius

" don't make it look like there are line breaks where there aren't:
set nowrap

set tabstop=2
set shiftwidth=2
set autoindent
set smartindent
set showmatch
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2
let mapleader = ","

filetype plugin on

" automatically change to the folder of the file you're editing
set autochdir

" maximize windows
set winheight=9999
set winminheight=0

set foldmethod=marker
nmap <F2> 0v/{<CR>%zf

" make tab in normal mode go to next file, shfit tab previous
nmap <Tab> <C-W><Down>
nmap <S-Tab> <C-W><Up>
nnoremap <C-N> :next<CR>
nnoremap <C-P> :prev<CR>

" have CTRL-J reformat the current paragraph (or selected text if there is any):
nnoremap <C-J> gqap 
vnoremap <C-J> gq
inoremap <C-J> <Esc>gqi

inoremap <Tab> <C-T>
inoremap <S-Tab> <C-D>
map  <C-A> <Home>
map  <C-E> <End>
map  <C-K> :dl<CR>
map  <C-A> ^
imap <C-A> <Esc>^i
map! <C-E> <End>
imap <C-K> <Esc>:dl<CR>i
" fuzzyfinder buffer search - ctrl-b
map <C-B> :FufBuffer<CR>
" normal mode space scrolls page
noremap <space> <C-f> 
" insert mode: Ctrl-Z is undo
imap <C-Z> <Esc>ui
" make tab in visual mode indent, shift-tab dedent
vmap <tab> >gv
vmap <s-tab> <gv
inoremap ,, <ESC>
" nnoremap <leader>w <C-w>v<C-w>l
nmap <silent> <Leader>w :vsplit<bar>wincmd l<bar>exe "norm! Ljz<c-v><cr>"<cr>:set scb<cr>:wincmd h<cr>:set scb<cr>

map <ESC>[1;5A <C-Up>
map <ESC>[1;5B <C-Down>
map! <ESC>[1;5A <C-Up>
map! <ESC>[1;5B <C-Down>
nnoremap <silent> <C-Right> <c-w>l
nnoremap <silent> <C-Left> <c-w>h
nnoremap <silent> <C-Up> <c-w>k
nnoremap <silent> <C-Down> <c-w>j

" run as q script
nmap <Leader>q :w<CR>:!rlwrap ~/q/w32/q %<CR>
" run test.sh with this filename as arg
nmap <Leader>t :w<CR>:!sh test.sh % \|\| sh ../test.sh %<CR>
" run start.sh with this filename as arg
nmap <Leader>s :w<CR>:!sh start.sh % \|\| sh ../start.sh %<CR>
" find run command in comment, then call with filename as arg
nmap <Leader>r :w<CR>:!sh `sed -n 's/.* RUN:\(.*\)$/\1/p' %`<CR>

set wildmenu
set wildmode=list:longest,full

" When editing a file, always jump to the last known cursor position.
" " Don't do it when the position is invalid or when inside an event handler
" " (happens when dropping a file on gvim).
autocmd BufReadPost *
	\ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

" NERDTree
map <C-n> :NERDTreeToggle<CR>
" disable fancy unicode directory UI - breaks some vims
let g:NERDTreeDirArrows=0 
let g:NERDTreeTabsOpenOnGUIStartup=0


    autocmd StdinReadPre * let s:std_in=1
		autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif


" pop: coreytabs
autocmd BufRead,BufNewFile *pop*/*php set expandtab tabstop=4 shiftwidth=4
autocmd BufRead,BufNewFile *.q set nobackup nowritebackup noswapfile
autocmd BufRead,BufNewFile *.k        setfiletype k
autocmd BufRead,BufNewFile *.q        setfiletype q
autocmd BufRead,BufNewFile *.s        setfiletype sql
autocmd BufRead,BufNewFile *.xxl      setfiletype xxl

let g:ale_fixers = {}
let g:ale_fixers.javascript = ['prettier', 'eslint']
let g:ale_fix_on_save = 1
let g:mix_format_on_save = 1

let g:ale_linters = {}
let g:ale_linters.elixir = ['elixir-ls']
let g:ale_elixir_elixir_ls_release = expand("~/elixir-ls/rel")
set completeopt=menu,menuone,preview,noselect,noinsert
let g:ale_completion_enabled = 1

"let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

let g:ctrlp_user_command = 'fdfind --type f --color=never "" %s'

nmap <silent> <S-down> <Plug>(ale_next_wrap)
nmap <silent> <S-up> <Plug>(ale_previous_wrap)

call pathogen#infect()

