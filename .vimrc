set nocompatible  " Use Vim defaults (much better!)"
set bs=indent,eol,start   " allow backspacing over everything in insert mode"
set backup   
set backupdir=~/tmp

set t_Co=256
colors molokai

" don't make it look like there are line breaks where there aren't:"
set nowrap

set hlsearch

filetype plugin indent on
" On pressing tab, insert 2 spaces
set expandtab
" show existing tab with 2 spaces width
set tabstop=2
set softtabstop=2
" when indenting with '>', use 2 spaces width
set shiftwidth=2

set autoindent
set smartindent
set showmatch
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2
let mapleader = ","
set number

filetype plugin on

" automatically change to the folder of the file you're editing"
set autochdir

" maximize windows"
set winheight=9999
set winminheight=0

set foldmethod=marker
nmap <F2> 0v/{<CR>%zf

" make tab in normal mode go to next file, shift tab previous"
nmap <tab> <Ctrl-W><Down>
nmap <s-tab> :prev<CR>
nnoremap <C-N> :next<CR>
nnoremap <C-P> :prev<CR>

" have CTRL-J reformat the current paragraph (or selected text if there is any):"
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

" normal mode space scrolls page"
noremap <space> <C-f> 

" insert mode: Ctrl-Z is undo"
imap <C-Z> <Esc>ui

" make tab in visual mode indent, shift-tab dedent"
vmap <tab> >gv
vmap <s-tab> <gv

inoremap ,, <ESC>
" nnoremap <leader>w <C-w>v<C-w>l"
nmap <silent> <Leader>w :vsplit<bar>wincmd l<bar>exe "norm! Ljz<c-v><cr>"<cr>:set scb<cr>:wincmd h<cr>:set scb<cr>
nmap <Leader>r :w<CR>:!sh `sed -n 's/.* run: \(.*\)/\1/p' %`<CR>

set wildmenu
set wildmode=list:longest,full

" When editing a file, always jump to the last known cursor position."
"  Don't do it when the position is invalid or when inside an event handler"
"  (happens when dropping a file on gvim)."
autocmd BufReadPost *
	\ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

"Store swapfiles in tmp"
set swapfile
set dir=~/tmp

" PLUG "
nnoremap <silent> <M-j> :MultipleCursorsFind <C-R>/<CR>
vnoremap <silent> <M-j> :MultipleCursorsFind <C-R>/<CR>
noremap <M-Up> [{
noremap <M-Down> }]

nmap <silent> t<C-f> :TestFile<CR>

call plug#begin('~/.vim/plugged')

Plug 'terryma/vim-multiple-cursors'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'mattn/emmet-vim'
Plug 'mattn/webapi-vim'
Plug 'prettier/vim-prettier'
Plug 'janko-m/vim-test'
Plug 'flowtype/vim-flow'
Plug 'jiangmiao/auto-pairs'
Plug 'epilande/vim-es2015-snippets'
Plug 'epilande/vim-react-snippets'
Plug 'SirVer/ultisnips'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'w0rp/ale'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

call plug#end()

if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

augroup myvimrc
  autocmd!
  autocmd QuickFixCmdPost [^l]* cwindow
  autocmd QuickFixCmdPost l*    lwindow
augroup END

let g:UltiSnipsExpandTrigger="<tab>"
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.json,*.css,*.scss,*.less,*.graphql PrettierAsync
nnoremap <Bslash> :Ag 

nmap <silent> <S-Left> <Plug>(ale_previous_wrap)
nmap <silent> <S-Right> <Plug>(ale_next_wrap)

let g:ale_fixers = {
\  'javascript': ['eslint'],
\}

nnoremap <C-S-H> :ALEfix<cr>
let g:fixmyjs_engine = 'eslint'
let g:ale_fix_on_save = 1
