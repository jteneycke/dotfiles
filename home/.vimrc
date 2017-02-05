" Brief help
" :PlugList          - list configured bundles
" :PlugInstall(!)    - install(update) bundles
" :PlugSearch(!) foo - search(or refresh cache first) for foo
" :PlugClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Plug command are not allowed..

set nocompatible
syntax on
filetype off
filetype plugin indent on

" Take me to your leader! What's that? He's the biggest key on the board?
let mapleader=" "

" No one wants to type shift a billion times just to enter commands
nnoremap ; :

set shell=/bin/bash
set number
set hlsearch
set expandtab
set synmaxcol=550
set backup
set noswapfile
set undofile
set undolevels=3000
set undoreload=10000
set clipboard+=unnamed
set paste

if (has("termguicolors"))
  set termguicolors
endif
set background=dark

" Store all those temp files the editor makes somewhere out of the way
" ----------------------------------------

" Ensure the temp dirs exist
call system("mkdir -p ~/.vim/tmp/swap")
call system("mkdir -p ~/.vim/tmp/backup")
call system("mkdir -p ~/.vim/tmp/undo")
" Change where we store swap/undo files
set dir=~/.vim/tmp/swap/
set backupdir=~/.vim/tmp/backup/
set undodir=~/.vim/tmp/undo/


" Play nice with tmux
" ----------------------------------------
" set mouse=a
" if has("mouse_sgr")
"   set ttymouse=sgr
" else
"   set ttymouse=xterm2
" end

if &term =~ '256color'
  " Disable Background Color Erase (BCE) so that color schemes
  " work properly when Vim is used inside tmux and GNU screen.
  " See also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

" set term=screen-256color


" Navigational Bindings
" ----------------------------------------

" Go directly to column below instead of wrapping to next line
nnoremap j gj
nnoremap k gk

" Fast up / down across blank lines
nnoremap <S-j> }
nnoremap <S-k> {

" Same split bind semantic as fzf find buffer
"nnoremap <C-v> :vsplit<CR>
"nnoremap <C-x> :split<CR>

nmap <leader>- :split<CR>
nmap <leader>\ :vsplit<CR>

"nmap <leader>sh :topleft  vnew<CR>
"nmap <leader>sl :botright vnew<CR>

"nmap <leader>sk :topleft  new<CR>
"nmap <leader>sj :botright new<CR>

" Easy splitted window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k

tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

" Fast quit / save
" Can't believe I've been using :q all these years like a sucker!
map <Leader>q :clo<CR>
nnoremap <C-s> :w<CR>:echo "Saved file ${filename}"<CR>

" Resize pane
nnoremap <silent> + <C-w>>
nnoremap <silent> _ <C-w><

" Move tab left and right (for sorting and rearranging)
map <Leader>h :tabm -1<CR>
map <Leader>l :tabm +1<CR>

" Go forwards and backwards a tab
map <Leader>j :tabp<CR>
map <Leader>k :tabn<CR>

" What should new tab be?
"map <Leader>n :tabnew<CR>

" This is probably going to be obsoleted now that we've got terminal in vim
" Paste last line of pry history to buffer
nmap <Leader>ph :<c-u>let pc = (v:count1 ? v:count1 : 1)<cr>:read !tail -<c-r>=pc<cr> ~/.pry_history<cr>:.-<c-r>=pc-1<cr>:norm <c-r>=pc<cr>==<cr>

" Who's to blame!
map <Leader>g :Gblame<CR>

" Quick reloading for binding and function development (The proverbial Escher hand drawing the hand.)
" ----------------------------------------
map <Leader>pi :w<CR>:so ~/.vimrc<CR> :PlugInstall<CR>
map <Leader>vs :w<CR>:so ~/.vimrc<CR> :echo "Saved and sourced vimrc."<CR>
map <leader>vrc :tabnew ~/.vimrc<cr>


" Start of plugin block
" ----------------------------------------
call plug#begin('~/.vim/plugged')


" FZF
" ----------------------------------------
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

"start fuzzy finder
nnoremap <C-p> :Files<CR>
map <Leader>; :Files<CR>

"" Mapping selecting mappings
"nmap <leader><tab> <plug>(fzf-maps-n)
"xmap <leader><tab> <plug>(fzf-maps-x)
"omap <leader><tab> <plug>(fzf-maps-o)

let g:fzf_layout = { 'down': '~10%' }
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

"Plug 'L9' "utility functions for vundle?

" TODO: Setup bindings for staging lines from gitguttter
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
"Plug 'tpope/vim-commentary'
Plug 'scrooloose/nerdcommenter'
"map <Leader>c :NERDComToggleComment<CR>

"Plug 'jceb/vim-orgmode'

Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-classpath'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'

Plug 'junegunn/rainbow_parentheses.vim'
Plug 'vim-scripts/omlet.vim'
Plug 'majutsushi/tagbar'
Plug 'Shougo/vimproc.vim'
Plug 'Shougo/vimshell.vim'

" TODO: Get this working - it seems to be broken right now
" Sweet-ass powerline
" ----------------------------------------
Plug 'itchyny/lightline.vim'
Plug 'itchyny/lightline-powerful'
"let g:lightline = {
      "\ 'colorscheme': 'wombat',
      "\ }

" Languages and Syntax Highlighting
" ----------------------------------------
Plug 'scrooloose/syntastic'
Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
Plug 'tpope/vim-haml'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-liquid'
Plug 'digitaltoad/vim-pug'
Plug 'exu/pgsql.vim'
Plug 'guns/vim-clojure-static'
Plug 'elixir-lang/vim-elixir'
Plug 'kchmck/vim-coffee-script'
Plug 'groenewege/vim-less'
Plug 'posva/vim-vue'
Plug 'dag/vim-fish'
Plug 'ElmCast/elm-vim'
let g:elm_format_autosave = 1


" Easy, breezy, seamless Rails testing and development
" ----------------------------------------
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-rails'

"Plug 'tpope/dispatch'
"Plug 'skalnik/vim-vroom'
"let g:vroom_use_zeus = 1
" run bash command on current_file name
"nmap <silent> <leader>t :!echo %:p

" close, but needs to do it in a seperate pane
"Plug 'janko-m/vim-test'
"let test#strategy = "vtr"
"nmap <silent> <leader>t :TestNearest<CR>
"nmap <silent> <leader>T :TestFile<CR>
"nmap <silent> <leader>a :TestSuite<CR>
"nmap <silent> <leader>l :TestLast<CR>
"nmap <silent> <leader>g :TestVisit<CR>

" Tmux integrations
" ----------------------------------------
" TODO: let's use turbux and be cool like Emma :)
Plug 'keith/tmux.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'christoomey/vim-tmux-runner'
"Plug 'benmills/vimux'
"map <Leader>rb :call VimuxRunCommand("clear; rspec " . bufname("%"))<CR>
"map <Leader>vp :VimuxPromptCommand<CR>
"map <Leader>vl :VimuxRunLastCommand<CR>
"map <Leader>vi :VimuxInspectRunner<CR>
"map <Leader>vq :VimuxCloseRunner<CR>
"map <Leader>vs :VimuxInterruptRunner<CR>
"map <Leader>vc :VimuxClearRunnerHistory<CR>
"map <Leader>vz :VimuxZoomRunner<CR>


Plug 'skywind3000/asyncrun.vim'

" Simple file browser tree
" ----------------------------------------
Plug 'scrooloose/nerdtree'
let NERDTreeHijackNetrw=1
let NERDTreeShowHidden=1
nnoremap <Leader>f :NERDTreeToggle<CR>
nnoremap <Leader>d :NERDTreeFind<CR>

Plug 'tpope/vim-vinegar'


" Grep across repository
" ----------------------------------------
Plug 'mileszs/ack.vim'
Plug 'albfan/ag.vim'
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

if executable('rg')
  let g:ackprg = 'rg --vimgrep --no-heading'
endif

noremap <Leader>a :Ack <cword><cr>


" Indent Settings
" ----------------------------------------
Plug 'nathanaelkane/vim-indent-guides'
set ts=2 sw=2 et
let g:indent_guides_start_level = 2
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 1
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=grey    ctermbg=235
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=darkgrey ctermbg=236

Plug 'michaeljsmith/vim-indent-object'
let g:indentobject_meaningful_indentation = ["haml", "sass", "python", "yaml", "markdown"]


" Prevent and trim whitespace from getting into diffs
" ----------------------------------------
Plug 'ntpeters/vim-better-whitespace'
map <Leader>w :StripWhitespace<CR>


" Align hashes, json, and whatnot by a given character
" ----------------------------------------
"Plug 'godlygeek/tabular'
"if exists(":Tabularize")
"  nmap <Leader>t= :Tabularize /=<CR>
"  vmap <Leader>t= :Tabularize /=<CR>
"  nmap <Leader>t: :Tabularize /:\zs<CR>
"  vmap <Leader>t: :Tabularize /:\zs<CR>
"endif


" Writing mode
" ----------------------------------------
"Plug 'junegunn/limelight.vim'
"Plug 'junegunn/goyo.vim'
"map <Leader>gy :Goyo<CR>
"autocmd User GoyoEnter :set linebreak
"autocmd User GoyoEnter Limelight
"autocmd User GoyoLeave :set linebreak!
"autocmd User GoyoLeave Limelight!


" A hack to cut and paste between vim instances in the event of a non-functing system clipboard
" ----------------------------------------
"vmap <silent> <S-y> y:new ~/.vimbuf<CR>VGp:x<CR>
"map <S-p> :r ~/.vimbuf<CR>


" Colorschemes
" ----------------------------------------
Plug 'colepeters/spacemacs-theme.vim'
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'tomasr/molokai'
"let g:rehash256 = 1
"colorscheme molokai

" End of plugin declarations and loading
" ----------------------------------------
call plug#end()

colorscheme spacemacs-theme

" Over ride some vim default weirdness. Perhaps not needed with nvim now?
" ----------------------------------------

" automatically resize window
au VimResized * exe "normal! \<c-w>="

" Only show cursorline in the current window and in normal mode.
augroup cline
  au!
  au WinLeave * set nocursorline
  au WinEnter * set cursorline
  au InsertEnter * set nocursorline
  au InsertLeave * set cursorline
augroup END
