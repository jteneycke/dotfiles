set nocompatible
syntax on
filetype off
set shell=/bin/bash

set mouse=a
if has("mouse_sgr")
  set ttymouse=sgr
else
  set ttymouse=xterm2
end

set number
set hlsearch
set expandtab
set synmaxcol=550
"set guifont=Ubuntu\ Mono\ 24
set clipboard=unnamedplus
"set clipboard=unnamed

if &term =~ '256color'
  " Disable Background Color Erase (BCE) so that color schemes
  " work properly when Vim is used inside tmux and GNU screen.
  " See also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif
set term=screen-256color


"vmap <S-y> y:new ~/.vimbuf<CR>VGp:x<CR>:!xclip -selection c < ~/.vimbuf<CR><CR>
"vmap <S-y> y:new ~/.vimbuf<CR>VGp:x<CR>:!xclip -selection c < ~/.vimbuf<CR><CR>
"vmap <S-y> y:new ~/.vimbuf<CR>VGp:x<CR>:!xclip -i < ~/.vimbuf<CR><CR>
vmap <silent> <S-y> y:new ~/.vimbuf<CR>VGp:x<CR>
map <S-p> :r ~/.vimbuf<CR>


" automatically resize window
au VimResized * exe "normal! \<c-w>="

" _ backups
set undodir=~/.vim/tmp/undo//     " undo files
set undofile
set undolevels=3000
set undoreload=10000
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files
set backup
set noswapfile
set paste
set rtp+=~/.fzf

let mapleader=" "
nnoremap ; :

nnoremap j gj
nnoremap k gk


"nnoremap <Leader>w :%s/\s\+$// <CR>

" copy to buffer
"vmap <C-c> :w! ~/.vimbuffer<CR>
"nmap <C-c> :.w! ~/.vimbuffer<CR>
"" paste from buffer
"map <C-p> :r ~/.vimbuffer<CR>

" yank and paste to sytem clipboard
"nnoremap y "+y
"nnoremap p "+p

" some other crap that doesn't work
"vmap <Leader>y "+y
"vmap <Leader>d "+d
"nmap <Leader>p "+p
"nmap <Leader>P "+P
"vmap <Leader>p "+p
"vmap <Leader>P "+P

" turn this into a function bound to keybinding
":execute 'new | 0read ! testy' expand('%')

call plug#begin('~/.vim/plugged')

"Plug 'NLKNguyen/copy-cut-paste.vim'
"let g:copy_cut_paste_no_mappings = 1
"vmap <S-y> <Plug>CCP_CopyText
"nmap <S-p> <Plug>CCP_PasteText

"Plug 'christoomey/vim-system-copy'

Plug 'ntpeters/vim-better-whitespace'
map <Leader>w :StripWhitespace<CR>

Plug 'godlygeek/tabular'

if exists(":Tabularize")
  nmap <Leader>t= :Tabularize /=<CR>
  vmap <Leader>t= :Tabularize /=<CR>
  nmap <Leader>t: :Tabularize /:\zs<CR>
  vmap <Leader>t: :Tabularize /:\zs<CR>
endif

Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdtree'
"Plug 'jistr/vim-nerdtree-tabs'
"let g:nerdtree_tabs_open_on_console_startup = 1
Plug 'L9'
"Plug 'FuzzyFinder'
"Plug 'Valloric/YouCompleteMe'
Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-classpath'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-rails'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/rainbow_parentheses.vim'
"Plug 'digitaltoad/vim-jade'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-liquid'
"Plug 'vim-ruby/vim-ruby'
"Plug 'tkztmk/vim-vala'
Plug 'digitaltoad/vim-pug'
Plug 'exu/pgsql.vim'
Plug 'guns/vim-clojure-static'
Plug 'elixir-lang/vim-elixir'
Plug 'kchmck/vim-coffee-script'
Plug 'lumiliet/vim-twig'
Plug 'groenewege/vim-less'
Plug 'posva/vim-vue'
Plug 'mustache/vim-mustache-handlebars'
let g:mustache_abbreviations = 1
Plug 'dag/vim-fish'
Plug 'keith/tmux.vim'
Plug 'christoomey/vim-tmux-navigator'

Plug 'benmills/vimux'
map <Leader>rb :call VimuxRunCommand("clear; rspec " . bufname("%"))<CR>
map <Leader>vp :VimuxPromptCommand<CR>
map <Leader>vl :VimuxRunLastCommand<CR>
map <Leader>vi :VimuxInspectRunner<CR>
map <Leader>vq :VimuxCloseRunner<CR>
map <Leader>vs :VimuxInterruptRunner<CR>
map <Leader>vc :VimuxClearRunnerHistory<CR>
map <Leader>vz :VimuxZoomRunner<CR>

Plug 'mileszs/ack.vim'
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
noremap <Leader>a :Ack <cword><cr>

Plug 'tpope/vim-endwise'
Plug 'vim-scripts/omlet.vim'
Plug 'majutsushi/tagbar'
Plug 'airblade/vim-gitgutter'
Plug 'albfan/ag.vim'

" Themes
Plug 'joshdick/onedark.vim'
Plug 'tomasr/molokai'
"let g:rehash256 = 1
colorscheme molokai

"let g:onedark_termcolors=16
"colorscheme onedark

Plug 'ElmCast/elm-vim'
let g:elm_format_autosave = 1

" Indent Settings
Plug 'nathanaelkane/vim-indent-guides'
set ts=2 sw=2 et
let g:indent_guides_start_level = 2
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=black    ctermbg=235
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=darkgrey ctermbg=236
Plug 'michaeljsmith/vim-indent-object'
let g:indentobject_meaningful_indentation = ["haml", "sass", "python", "yaml", "markdown"]

" CtrlP
Plug 'ctrlpvim/ctrlp.vim'
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_match_window_bottom = 1 " Show at top of window
let g:ctrlp_jump_to_buffer = 'Et' " Jump to tab AND buffer if already open
"let g:ctrlp_split_window = 1 " <CR> = New Tab
let g:ctrlp_open_new_file = 't' " Open newly created files in a new tab
let g:ctrlp_open_multiple_files = 't' " Open multiple files in new tabs
let g:ctrlp_show_hidden = 1 " Index hidden files
set wildignore+=*/public/uploads/*
nnoremap <leader>t :CtrlPTag<cr>

" Save current file, reload vim config, and restart i3.
map <Leader>b :w<CR>:so ~/.vimrc<CR> :PlugInstall<CR>
map <Leader>r :w<CR>:so ~/.vimrc<CR>
nnoremap <leader>v :tabnew ~/.vimrc<cr>

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

"start fuzzy finder
map <leader>p :FZF<CR>

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

let g:fzf_layout = { 'down': '~40%' }
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }


" Only show cursorline in the current window and in normal mode.
augroup cline
    au!
    au WinLeave * set nocursorline
    au WinEnter * set cursorline
    au InsertEnter * set nocursorline
    au InsertLeave * set cursorline
augroup END

" File associations
au BufNewFile,BufRead *.sql set filetype=pgsql
au BufNewFile,BufRead *.ejs* set filetype=html
au BufNewFile,BufRead *.html.slim set filetype=slim
"au BufNewFile,BufRead *.cljs set filetype=clojure
au BufNewFile,BufRead *.pde set filetype=java
au BufNewFile,BufRead *.hl set filetype=clojure
au BufNewFile,BufRead *.liso set filetype=julia
au BufNewFile,BufRead *.vala set filetype=cs
au BufNewFile,BufRead *.odocl set filetype=ocaml
au BufNewFile,BufRead *.topscript set filetype=ocaml
au BufNewFile,BufRead *.rawscript set filetype=ocaml
au BufNewFile,BufRead .pryrc set filetype=ruby
au BufNewFile,BufRead *.jbuilder set filetype=ruby
au BufNewFile,BufRead *.cr set filetype=ruby
au BufNewFile,BufRead *.thor set filetype=ruby
au BufNewFile,BufRead *.routes set filetype=erlang
au BufNewFile,BufRead rebar.config set filetype=erlang
au BufRead,BufNewFile schema.rb set filetype=txt

" Fast up / down
"nnoremap <S-j> <C-d>
"nnoremap <S-k> <C-u>
nnoremap <S-j> }
nnoremap <S-k> {

" Easy splitted window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k

nnoremap <silent> + <C-w>>
nnoremap <silent> _ <C-w><

"nnoremap <Leader>p :CtrlP<CR>
"nnoremap <Leader>p :FZF<CR>
nnoremap <Leader>d :NERDTreeFind<CR>
"map <Leader>f <plug>NERDTreeTabsToggle<CR>
map <Leader>f :NERDTreeToggle<CR>

" Wicked Tab management
map <Leader>h :tabm -1<CR>
map <Leader>l :tabm +1<CR>

map <Leader>j :tabp<CR>
map <Leader>k :tabn<CR>

map <Leader>n :tabnew<CR>

map <Leader>q :q<CR>
map <Leader>s :w<CR>
map <Leader>gb :Gblame<CR>

map <Leader>g :Goyo<CR>
autocmd User GoyoEnter :set linebreak
autocmd User GoyoEnter Limelight
autocmd User GoyoLeave :set linebreak!
autocmd User GoyoLeave Limelight!


" Paste last line of pry history to buffer
nmap <Leader>ph :<c-u>let pc = (v:count1 ? v:count1 : 1)<cr>:read !tail -<c-r>=pc<cr> ~/.pry_history<cr>:.-<c-r>=pc-1<cr>:norm <c-r>=pc<cr>==<cr>

"call vundle#end()
call plug#end()

filetype plugin indent on     " required!
"
" Brief help
" :PlugList          - list configured bundles
" :PlugInstall(!)    - install(update) bundles
" :PlugSearch(!) foo - search(or refresh cache first) for foo
" :PlugClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Plug command are not allowed..
