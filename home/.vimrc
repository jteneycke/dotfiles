let mapleader = " "

autocmd!
set nocompatible

filetype off
filetype plugin on
filetype indent on
set nobackup
set nowritebackup
set noswapfile
set number
set tabstop=2 shiftwidth=2      " a tab is two spaces
set expandtab                   " use spaces, not tabs
set incsearch
set hlsearch
set exrc
set autoread
set laststatus=2
set noshowmode
set tags=tags;/

autocmd FileType ruby compiler ruby

autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1

au BufWritePost .vimrc so $MYVIMRC

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=/usr/local/opt/fzf
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'vim-ruby/vim-ruby'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'rking/ag.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/nerdcommenter'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'edkolev/tmuxline.vim'
Plugin 'KurtPreston/vim-autoformat-rails'
Plugin 'ervandew/supertab'
Plugin 'thoughtbot/vim-rspec'
Plugin 'tpope/vim-rbenv'
Plugin 'benmills/vimux'
Plugin 'jgdavey/vim-turbux'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'yegappan/mru'
Plugin 'ctrlpvim/ctrlp.vim'
" All of your Plugins must be added before the following line
call vundle#end()


"Stop hightling search words
nnoremap <leader><space> :nohlsearch<CR>

"key word search
nnoremap <leader>a :Ag!
noremap <leader>z :Ag! <C-r>=expand('<cword>')<CR><CR>

"open related file in vertical split
nnoremap <leader>b :AV<CR>

"remove trailing whitespace on save
autocmd BufWritePre * StripWhitespace

"testing
let g:turbux_command_prefix = 'bundle exec'
" Run the current file with rspec

" Prompt for a command to run
map <Leader>vp :VimuxPromptCommand<CR>

" Run last command executed by VimuxRunCommand
map <Leader>vl :VimuxRunLastCommand<CR>

" Inspect runner pane
map <Leader>vi :VimuxInspectRunner<CR>

" Close vim tmux runner opened by VimuxRunCommand
map <Leader>vq :VimuxCloseRunner<CR>

" Interrupt any command running in the runner pane
map <Leader>vx :VimuxInterruptRunner<CR>

" Zoom the runner pane (use <bind-key> z to restore runner pane)
map <Leader>vz :call VimuxZoomRunner()<CR>

"start fuzzy finder
map <leader>f :FZF<CR>

"moving lines
nnoremap J :m .+1<CR>==
nnoremap K :m .-2<CR>==
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"colourscheme
set t_Co=256
let g:solarized_termcolors=256
syntax enable
set background=dark
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
colorscheme solarized
let g:airline_powerline_fonts = 1

"toggle nerdtree
map <leader>n :NERDTreeToggle<CR>

"save and quit
map <leader>s :w<CR>
map <leader>q :q<CR>

"source vim file
nnoremap <leader>sv :source $MYVIMRC<cr>
