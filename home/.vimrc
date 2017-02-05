set nocompatible
syntax on
filetype off

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
set mouse=a
if has("mouse_sgr")
  set ttymouse=sgr
else
  set ttymouse=xterm2
end

if &term =~ '256color'
  " Disable Background Color Erase (BCE) so that color schemes
  " work properly when Vim is used inside tmux and GNU screen.
  " See also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif
set term=screen-256color


" Navigational Bindings
" ----------------------------------------

" Go directly to column below instead of wrapping to next line
nnoremap j gj
nnoremap k gk

" Fast up / down across blank lines
nnoremap <S-j> }
nnoremap <S-k> {

" Easy splitted window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k

" Resize pane
nnoremap <silent> + <C-w>>
nnoremap <silent> _ <C-w><

" Move tab left and right (for sorting and rearranging)
map <Leader>h :tabm -1<CR>
map <Leader>l :tabm +1<CR>

" Go forwards and backwards a tab
map <Leader>j :tabp<CR>
map <Leader>k :tabn<CR>

"map <Leader>n :tabnew<CR>

" Fast quit / save
map <Leader>q :q<CR>
map <Leader>s :w<CR>

" Paste last line of pry history to buffer
nmap <Leader>ph :<c-u>let pc = (v:count1 ? v:count1 : 1)<cr>:read !tail -<c-r>=pc<cr> ~/.pry_history<cr>:.-<c-r>=pc-1<cr>:norm <c-r>=pc<cr>==<cr>

" Who's to blame!
map <Leader>g :Gblame<CR>


" Quick reloading for binding and function development
" ----------------------------------------
map <Leader>vi :w<CR>:so ~/.vimrc<CR> :PlugInstall<CR>
map <Leader>vr :w<CR>:so ~/.vimrc<CR> :echo "Saved and sourced vimrc."<CR>
"nnoremap <leader>v :tabnew ~/.vimrc<cr>


" Start of plugin block
" ----------------------------------------
call plug#begin('~/.vim/plugged')

Plug 'L9' "utility functions for vundle?

" TODO: Setup bindings for staging lines from gitguttter
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-classpath'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'

Plug 'junegunn/rainbow_parentheses.vim'
Plug 'vim-scripts/omlet.vim'
Plug 'majutsushi/tagbar'


" TODO: Get this working - it seems to be broken right now
" Sweet-ass powerline
" ----------------------------------------
Plug 'itchyny/lightline.vim'


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
Plug 'janko-m/vim-test'
let test#strategy = "vtr"
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

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


" Simple file browser tree
" ----------------------------------------
Plug 'scrooloose/nerdtree'
let NERDTreeHijackNetrw=1
let NERDTreeShowHidden=1
nnoremap <Leader>f :NERDTreeToggle<CR>
nnoremap <Leader>d :NERDTreeFind<CR>

Plug 'tpope/vim-vinegar'


" TODO: User ripgrep for this intead
" Grep across repository
" ----------------------------------------
Plug 'albfan/ag.vim'
Plug 'mileszs/ack.vim'
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

if executable('rg')
  let g:ackprg = 'rg --vimgrep --no-heading'
endif

noremap <Leader>a :Ack <cword><cr>


" Colorschemes
" ----------------------------------------
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'tomasr/molokai'
let g:rehash256 = 1
colorscheme molokai


" Indent Settings
" ----------------------------------------
Plug 'nathanaelkane/vim-indent-guides'
set ts=2 sw=2 et
let g:indent_guides_start_level = 2
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
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


" CtrlP and fuzzy file finding
" ----------------------------------------
"Plug 'ctrlpvim/ctrlp.vim'
"set runtimepath^=~/.vim/bundle/ctrlp.vim
"let g:ctrlp_match_window_bottom = 1 " Show at top of window
"let g:ctrlp_jump_to_buffer = 'Et' " Jump to tab AND buffer if already open
""let g:ctrlp_split_window = 1 " <CR> = New Tab
"let g:ctrlp_open_new_file = 't' " Open newly created files in a new tab
"let g:ctrlp_open_multiple_files = 't' " Open multiple files in new tabs
"let g:ctrlp_show_hidden = 1 " Index hidden files
"set wildignore+=*/public/uploads/*
"nnoremap <leader>t :CtrlPTag<cr>


" FZF - TODO: Use this instead of CtrlP
" ----------------------------------------
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

"start fuzzy finder
nnoremap <C-p> :Files<CR>

"" Mapping selecting mappings
"nmap <leader><tab> <plug>(fzf-maps-n)
"xmap <leader><tab> <plug>(fzf-maps-x)
"omap <leader><tab> <plug>(fzf-maps-o)

let g:fzf_layout = { 'down': '~20%' }
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }


" Writing mode
" ----------------------------------------
"Plug 'junegunn/limelight.vim'
"Plug 'junegunn/goyo.vim'
"map <Leader>gy :Goyo<CR>
"autocmd User GoyoEnter :set linebreak
"autocmd User GoyoEnter Limelight
"autocmd User GoyoLeave :set linebreak!
"autocmd User GoyoLeave Limelight!


" TODO: Figure this shit out. Must have cross platform behavior.
" Various paste binding strategies to get cross pane, single clipboard effect
" ----------------------------------------

"vmap <S-y> y:new ~/.vimbuf<CR>VGp:x<CR>:!xclip -selection c < ~/.vimbuf<CR><CR>
"vmap <S-y> y:new ~/.vimbuf<CR>VGp:x<CR>:!xclip -selection c < ~/.vimbuf<CR><CR>
"vmap <S-y> y:new ~/.vimbuf<CR>VGp:x<CR>:!xclip -i < ~/.vimbuf<CR><CR>
vmap <silent> <S-y> y:new ~/.vimbuf<CR>VGp:x<CR>
map <S-p> :r ~/.vimbuf<CR>

" Remove trailing white space
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

"Plug 'NLKNguyen/copy-cut-paste.vim'
"let g:copy_cut_paste_no_mappings = 1
"vmap <S-y> <Plug>CCP_CopyText
"nmap <S-p> <Plug>CCP_PasteText

"Plug 'christoomey/vim-system-copy'
" turn this into a function bound to keybinding
":execute 'new | 0read ! testy' expand('%')


" End of plugin declarations and loading
" ----------------------------------------
call plug#end()


" Make vim defaults more bearable
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


" File associations for syntax highlighting
" ----------------------------------------
au BufNewFile,BufRead *.sql set filetype=pgsql
au BufNewFile,BufRead *.ejs* set filetype=html
au BufNewFile,BufRead *.html.slim set filetype=slim
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
