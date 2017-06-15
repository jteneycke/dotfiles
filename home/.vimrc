" Brief help
" :PlugList          - list configured bundles
" :PlugInstall(!)    - install(update) bundles
" :PlugSearch(!) foo - search(or refresh cache first) for foo
" :PlugClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Plug command are not allowed..

"function hashify
	":'<,'>s/"\]/\:/g<CR>

"	:'<,'>s/$/,/g<CR>
"endfunction


set nocompatible
syntax on
filetype off
filetype plugin indent on

set nolazyredraw
"set termguicolors

" Terminal colors
let g:terminal_color_0  = '#2e3436'
let g:terminal_color_1  = '#cc0000'
let g:terminal_color_2  = '#4e9a06'
let g:terminal_color_3  = '#c4a000'
let g:terminal_color_4  = '#3465a4'
let g:terminal_color_5  = '#75507b'
let g:terminal_color_6  = '#0b939b'
let g:terminal_color_7  = '#d3d7cf'
let g:terminal_color_8  = '#555753'
let g:terminal_color_9  = '#ef2929'
let g:terminal_color_10 = '#8ae234'
let g:terminal_color_11 = '#fce94f'
let g:terminal_color_12 = '#729fcf'
let g:terminal_color_13 = '#ad7fa8'
let g:terminal_color_14 = '#00f5e9'
let g:terminal_color_15 = '#eeeeec'

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
"set paste
set nopaste
set noai

set magic

if (has("termguicolors"))
  set termguicolors
endif
set background=dark

command! -nargs=1 TS setlocal ts=<args> sts=<args> sw=<args>
autocmd FileType ruby setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType haml setlocal shiftwidth=2 tabstop=2 expandtab


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

" Return indent (all whitespace at start of a line), converted from
" tabs to spaces if what = 1, or from spaces to tabs otherwise.
" When converting to tabs, result has no redundant spaces.
function! Indenting(indent, what, cols)
  let spccol = repeat(' ', a:cols)
  let result = substitute(a:indent, spccol, '\t', 'g')
  let result = substitute(result, ' \+\ze\t', '', 'g')
  if a:what == 1
    let result = substitute(result, '\t', spccol, 'g')
  endif
  return result
endfunction

" Convert whitespace used for indenting (before first non-whitespace).
" what = 0 (convert spaces to tabs), or 1 (convert tabs to spaces).
" cols = string with number of columns per tab, or empty to use 'tabstop'.
" The cursor position is restored, but the cursor will be in a different
" column when the number of characters in the indent of the line is changed.
function! IndentConvert(line1, line2, what, cols)
  let savepos = getpos('.')
  let cols = empty(a:cols) ? &tabstop : a:cols
  execute a:line1 . ',' . a:line2 . 's/^\s\+/\=Indenting(submatch(0), a:what, cols)/e'
  call histdel('search', -1)
  call setpos('.', savepos)
endfunction
command! -nargs=? -range=% Space2Tab call IndentConvert(<line1>,<line2>,0,<q-args>)
command! -nargs=? -range=% Tab2Space call IndentConvert(<line1>,<line2>,1,<q-args>)
command! -nargs=? -range=% RetabIndent call IndentConvert(<line1>,<line2>,&et,<q-args>)<Paste>

" Easy esacpe
" ----------------------------------------
tnoremap <Esc> <C-\><C-n>

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

nmap <leader>s :retab<CR>:w<CR>:echom "Saved file"<CR>

"nmap <leader>sh :topleft  vnew<CR>
"nmap <leader>sl :botright vnew<CR>

"nmap <leader>sh :topleft  vnew<CR>
"nmap <leader>sl :botright vnew<CR>

"nmap <leader>th :topleft  vnew<CR>
"nmap <leader>tl :botright vnew<CR>

"nmap <leader>tk :topleft  new<CR>
"nmap <leader>tj :botright new<CR>

nmap <leader>th :topleft  term bash<CR>
nmap <leader>tl :botright vnew<CR>

nmap <leader>tk :topleft  new<CR>
nmap <leader>tj :botright new<CR>

" Easy splitted window navigation
"nnoremap <C-h> <C-w>h
"nnoremap <C-l> <C-w>l
"nnoremap <C-j> <C-w>j
"nnoremap <C-k> <C-w>k

"tnoremap <C-h> <C-\><C-n><C-w>h
"tnoremap <C-j> <C-\><C-n><C-w>j
"tnoremap <C-k> <C-\><C-n><C-w>k
"tnoremap <C-l> <C-\><C-n><C-w>l

" Fast quit / save
" Can't believe I've been using :q all these years like a sucker!
"nmap <Leader>q :clo!<CR>
nmap <Leader>q :q!<CR>
nmap <Leader>s :w<CR> :echo "Saved: " . @% . " at: " . strftime("%c")<CR>

" Resize pane
nnoremap <silent> + <C-w>>
nnoremap <silent> _ <C-w><

" Move tab left and right (for sorting and rearranging)
nmap <Leader>h :tabm -1<CR>
nmap <Leader>l :tabm +1<CR>

" Go forwards and backwards a tab
nmap <Leader>j :tabp<CR>
nmap <Leader>k :tabn<CR>

" What should new tab be?
"map <Leader>n :tabnew<CR>

" This is probably going to be obsoleted now that we've got terminal in vim
" Paste last line of pry history to buffer
nmap <Leader>ph :<c-u>let pc = (v:count1 ? v:count1 : 1)<cr>:read !tail -<c-r>=pc<cr> ~/.pry_history<cr>:.-<c-r>=pc-1<cr>:norm <c-r>=pc<cr>==<cr>

" Who's to blame!
nmap <Leader>g :Gblame<CR>

" Quick reloading for binding and function development (The proverbial Escher hand drawing the hand.)
" ----------------------------------------
nmap <Leader>pi :w<CR>:so ~/.vimrc<CR> :PlugInstall<CR>
nmap <Leader>r :w<CR>:so ~/.vimrc<CR> :echo "Saved and sourced vimrc."<CR>
nmap <leader>ve :tabnew ~/.vimrc<CR>

" Terminal Bindings
" ----------------------------------------
"map <Leader>t :split term://bash<CR>
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" https://vi.stackexchange.com/questions/3670/how-to-enter-insert-mode-when-entering-neovim-terminal-pane
autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert

"tnoremap <Esc> <C-\><C-n>


" https://medium.com/@garoth/neovim-terminal-usecases-tricks-8961e5ac19b9#.xqgzmptda
" Window split settings
highlight TermCursor ctermfg=red guifg=red
set splitbelow
set splitright

" Terminal settings
tnoremap <Leader><ESC> <C-\><C-n>

" Window navigation function
" Make ctrl-h/j/k/l move between windows and auto-insert in terminals
"func! s:mapMoveToWindowInDirection(direction)
    "func! s:maybeInsertMode(direction)
        "stopinsert
        "execute "wincmd" a:direction

        "if &buftype == 'terminal'
            "startinsert!
        "endif
    "endfunc

    "execute "tnoremap" "<silent>" "<C-" . a:direction . ">"
                "\ "<C-\\><C-n>"
                "\ ":call <SID>maybeInsertMode(\"" . a:direction . "\")<CR>"
    "execute "nnoremap" "<silent>" "<C-" . a:direction . ">"
                "\ ":call <SID>maybeInsertMode(\"" . a:direction . "\")<CR>"
"endfunc
"for dir in ["h", "j", "l", "k"]
    "call s:mapMoveToWindowInDirection(dir)
"endfor


" Start of plugin block
" ----------------------------------------
call plug#begin('~/.vim/plugged')

"Plug 'sjbach/lusty'


" FZF
" ----------------------------------------
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'Chiel92/vim-autoformat'
Plug 'vim-scripts/DirDo.vim'

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

"Plug 'roman/golden-ratio'

" TODO: Setup bindings for staging lines from gitguttter
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'scrooloose/nerdcommenter'
let g:NERDCreateDefaultMappings = 0
map <Leader>l <Plug>NERDCommenterInvert


"Plug 'tpope/vim-commentary'
"Plug 'tpope/vim-commentary'
""Plug 'sudar/comments.vim'
"let g:comments_map_keys = 0
"" key-mappings for comment line in normal mode
"noremap  <silent> <Leader>l :call CommentLine()<CR>
"" key-mappings for range comment lines in visual <Shift-V> mode
"vnoremap <silent> <Leader>l :call RangeCommentLine()<CR>
"
"" key-mappings for un-comment line in normal mode
"noremap  <silent> <Leader>c :call UnCommentLine()<CR>
"" key-mappings for range un-comment lines in visual <Shift-V> mode
"vnoremap <silent> <Leader>c :call RangeUnCommentLine()<CR>



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

Plug 'terryma/vim-multiple-cursors'
let g:multi_cursor_use_default_mapping=0
" Default mapping
let g:multi_cursor_next_key='<M-n>'
let g:multi_cursor_prev_key='<M-p>'
let g:multi_cursor_skip_key='<M-x>'
let g:multi_cursor_quit_key='<Esc>'

" TODO: Get this working - it seems to be broken right now
" Sweet-ass powerline
" ----------------------------------------
Plug 'itchyny/lightline.vim'
Plug 'itchyny/lightline-powerful'
"let g:lightline = {
      "\ 'colorscheme': 'wombat',
      "\ }

let g:lightline = {
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \ },
      \ }

function! LightlineFilename()
  return expand('%:f') !=# '' ? expand('%:f') : '[No Name]'
endfunction

" Languages and Syntax Highlighting
" ----------------------------------------
"Plug 'scrooloose/syntastic'
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
Plug 'posva/vim-vue'
Plug 'ElmCast/elm-vim'
let g:elm_format_autosave = 1

Plug 'jaxbot/semantic-highlight.vim'

"Plug 'neowit/vim-force.com'
Plug 'benburwell/vim-syntax-apex'

" Easy, breezy, seamless Rails testing and development
" ----------------------------------------
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-rails'
Plug 'BlakeWilliams/vim-pry'
"Plug 'sovetnik/vim-minispec'

"Plug 'tpope/dispatch'
"Plug 'skalnik/vim-vroom'
"let g:vroom_use_zeus = 1
" run bash command on current_file name
"nmap <silent> <leader>t :!echo %:p

" close, but needs to do it in a seperate pane
"Plug 'janko-m/vim-test'
"let test#strategy = "neovim"
"nmap <silent> <leader>t :TestNearest<CR>
"nmap <silent> <leader>T :TestFile<CR>
"nmap <silent> <leader>a :TestSuite<CR>
"nmap <silent> <leader>l :TestLast<CR>
"nmap <silent> <leader>g :TestVisit<CR>

" Tmux integrations
" ----------------------------------------
Plug 'keith/tmux.vim'

"Plug 'drmikehenry/vim-fixkey'
Plug 'christoomey/vim-tmux-navigator'
"let g:tmux_navigator_no_mappings = 1
"nnoremap <silent> <M-h> :TmuxNavigateLeft<cr>
"nnoremap <silent> <M-j> :TmuxNavigateDown<cr>
"nnoremap <silent> <M-k> :TmuxNavigateUp<cr>
"nnoremap <silent> <M-l> :TmuxNavigateRight<cr>
"nnoremap <silent> <M-\> :TmuxNavigatePrevious<cr>


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


"Plug 'skywind3000/asyncrun.vim'

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
"Plug 'Yggdroot/indentLine'

"let g:indentLine_char = '⎸'
"let g:indentLine_color_term = 239

"" https://github.com/nathanaelkane/vim-indent-guides/issues/46#issuecomment-9444925
"exe 'syn match Guides ''%(^%( {'.&sw.'})*)@<= '' conceal cchar=|'
"setl conceallevel=2 concealcursor=nc

Plug 'nathanaelkane/vim-indent-guides'
set ts=2 sw=2 et
let g:indent_guides_start_level = 2
let g:indent_guides_enable_on_vim_startup = 1

"let g:indent_guides_auto_colors = 1

"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=grey    ctermbg=235
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=darkgrey ctermbg=236

Plug 'michaeljsmith/vim-indent-object'
let g:indentobject_meaningful_indentation = ["haml", "sass", "python", "yaml", "markdown"]


" Prevent and trim whitespace from getting into diffs
" ----------------------------------------
Plug 'ntpeters/vim-better-whitespace'
map <Leader>w :StripWhitespace<CR>


" Easy align
" ----------------------------------------
Plug 'junegunn/vim-easy-align'

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaiph)
nmap ga <Plug>(EasyAlign)


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
"map <S-p> :r ~/.vim" Yank to file
"map y y:e ~/.vim/clipboard.tmp<CR>P:w <CR><CR>:bdelete!<CR>
" Y to copy until end of line, like D
"map Y y$

""nnoremap y :'<,'>w! ~/.vim/clipboard.tmp<CR>:echo 'Copied!'<CR>
"map y :'<,'>w! ~/.vim/clipboard.tmp<CR>
"map p :exe 'norm i' . system("cat ~/.vim/clipboard.tmp")<CR>


" Colorschemes
" ----------------------------------------
Plug 'colepeters/spacemacs-theme.vim'
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'tomasr/molokai'
"let g:rehash256 = 1
"colorscheme molokai

Plug 'vim-scripts/SQLUtilities'

Plug 'xolox/vim-session'
Plug 'xolox/vim-misc'

let g:session_autoload = 'no'


" End of plugin declarations and loading
" ----------------------------------------'
call plug#end()

colorscheme spacemacs-theme

" Very nice!
set fillchars+=vert:│
hi VertSplit ctermbg=NONE guibg=NONE


autocmd BufNewFile,BufRead *.apex set syntax=apex
autocmd BufNewFile,BufRead *.rabl set syntax=ruby


"let g:indentLine_showFirstIndentLevel = 1

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
