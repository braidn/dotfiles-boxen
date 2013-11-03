"Setup for Vundle
""
set shell=/bin/bash
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

""Hey Vundle
Bundle 'gmarik/vundle'

""MINE!
Bundle 'ChrisYip/Better-CSS-Syntax-for-Vim'
Bundle 'kien/ctrlp.vim'
Bundle 'mattn/gist-vim'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/nerdcommenter'
Bundle 'vim-scripts/Puppet-Syntax-Highlighting'
Bundle 'scrooloose/syntastic'
Bundle 'godlygeek/tabular'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'altercation/vim-colors-solarized'
Bundle 'tpope/vim-cucumber'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'Yggdroot/indentLine'
Bundle 'pangloss/vim-javascript'
Bundle 'leshill/vim-json'
Bundle 'briancollins/vim-jst'
Bundle 'groenewege/vim-less'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-endwise'
Bundle 'tomtom/tlib_vim'
Bundle 'wusher/apidock.vim'
Bundle 'jiangmiao/auto-pairs'
Bundle 'sjl/gundo.vim'
Bundle 'AndrewRadev/switch.vim'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-repeat'
Bundle 'ecomba/vim-ruby-refactoring'
Bundle 'jgdavey/vim-turbux'
Bundle 'benmills/vimux'
Bundle 'sjl/vitality.vim'
Bundle 'vim-scripts/YankRing.vim'
Bundle 'mattn/emmet-vim'
Bundle 'mattn/webapi-vim'
Bundle 'mattn/gist-vim'
Bundle 'nono/vim-handlebars'
Bundle 'itspriddle/vim-marked'
Bundle 'kchmck/vim-coffee-script'
Bundle 'airblade/vim-gitgutter'
Bundle 'ervandew/supertab'
Bundle 'vim-scripts/matchit.zip'
Bundle 'digitaltoad/vim-jade.git'
Bundle 'slim-template/vim-slim'
Bundle 'tpope/vim-fugitive'
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'bling/vim-airline'
Bundle 'wavded/vim-stylus'
Bundle 'szw/vim-tags'
Bundle 'myusuf3/numbers.vim'
Bundle 'tpope/vim-bundler'
Bundle 'Floobits/floobits-vim'
Bundle 'rking/ag.vim'
Bundle 'SirVer/ultisnips'
Bundle 'vim-scripts/ZoomWin'
Bundle 'suan/vim-instant-markdown'



filetype plugin indent on


"Color stuff
syntax enable
scriptencoding utf-8
let g:solarized_termcolors=256
set background=dark
color solarized
call togglebg#map("<F1>")
set clipboard=unnamed

" Random personal settings
set smartindent
set encoding=utf-8
set linespace=0                 " No extra spaces between rows
set backspace=indent,eol,start
set laststatus=2
set t_Co=256
set showmode
set autochdir
set showcmd
set hidden
set visualbell
set number
set cursorline
set ttyfast
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab
set incsearch                   " find as you type search
set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
set hlsearch                    " highlight search terms
set hidden                      " allow buffer switching without saving
set nobackup
set nowb
set noswapfile
set wildmenu
set wildmode=longest:full,full
set synmaxcol=200
set nrformats=
set splitbelow
set splitright
set nowrap
set ttimeoutlen=100

"Yank into OS X, might require reattach-to-user clipboard"
noremap <leader>y "*y
noremap <leader>yy "*Y

"Preserve indentations from pasteboard
noremap <leader>P :set paste<CR>:put  *<CR>:set nopaste<CR>

" Leader Mapping
let mapleader = ","
let g:yankring_history_dir = '~/.vim/tmp'
let g:gitgutter_enabled = 0
nmap <silent> <leader>\ :nohlsearch<CR>
nmap <leader>yr :YRShow<cr>
nmap <leader>? :Ag 
nnoremap <leader>u :GundoToggle<cr>
nnoremap <silent> <leader>tt :TagbarToggle<CR>
nnoremap <Leader>rm :Rmodel
nnoremap <Leader>rv :Rview
nnoremap <Leader>rc :Rcontroller
nnoremap <Leader>sl :set cc=80<CR>
nnoremap <leader>gg :GitGutterToggle<cr>
nnoremap <leader>= :Tab/
nnoremap <leader>tw :set textwidth=80<cr>

" I gots the SpLITZ
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"Fugitive bindings
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>gp :Git push<CR>

"Indent Lines
hi Conceal ctermfg=red ctermbg=NONE

" Vimux stuff
" Prompt for a command to run
 map <Leader>rt :VimuxPromptCommand<CR>
" " Run last command executed by RunVimTmuxCommand
 map <Leader>rl :VimuxRunLastCommand<CR>
" " Inspect runner pane
 map <Leader>ro :VimuxOpenPane<CR>
" " Close all other tmux panes in current window
 map <Leader>rx :CloseVimTmuxPanes<CR>
" " Interrupt any command running in the runner pane
 map <Leader>rs :VimuxClearRunnerHistory<CR>
" Zeus love
 map <Leader>zr :ZeusRspec<CR>
 map <Leader>zc :ZeusCucumber<CR>
 map <Leader>zd :ZeusDestroy<CR>
 map <Leader>zs :ZeusStart<CR>

" Turbux Window
map <leader>tb :let g:VimuxUseNearestPane =
" Turbx Mapping
let g:no_turbux_mappings = 1
 let g:turbux_runner  = 'vimux'
map <leader>m <Plug>SendTestToTmux
map <leader>M <Plug>SendFocusedTestToTmux

"Switch
nnoremap - :Switch<cr>

" Nerd Tree jazz
let NERDTreeShowLineNumbers=1
let NERDTreeWinPos='right'
nmap <Leader>n :NERDTreeToggle<CR>

" Tabularize
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:<CR>
vmap <Leader>a: :Tabularize /:<CR>
nmap <Leader>a:: :Tabularize /:\zs<CR>
vmap <Leader>a:: :Tabularize /:\zs<CR>
nmap <Leader>a, :Tabularize /,<CR>
vmap <Leader>a, :Tabularize /,<CR>

" OmniComplete Supertab and UltraSnips
set omnifunc=syntaxcomplete#Complete
" Ultisnips directory for extra snipps
let g:UltiSnips = {}
let g:UltiSnips.ListSnippets = "<c-a>"
let g:UltiSnips.ExpandTrigger="<tab>"
let g:UltiSnips.JumpForwardTrigger="<tab>"

 "Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

if has('conceal')
  set conceallevel=2 concealcursor=i
endif

""Key remaps
let g:ctrlp_map = '<Leader>p'
nnoremap <Leader>b :CtrlPBuffer<CR>
nnoremap <Leader>. :CtrlPTag<CR>
nnoremap ; :
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
inoremap jj <ESC>
nnoremap <leader><space> :noh<cr>

"Ruby Refactoring

nnoremap <leader>rap  :RAddParameter<cr>
nnoremap <leader>rcpc :RConvertPostConditional<cr>
nnoremap <leader>rel  :RExtractLet<cr>
vnoremap <leader>rec  :RExtractConstant<cr>
vnoremap <leader>relv :RExtractLocalVariable<cr>
nnoremap <leader>rit  :RInlineTemp<cr>
vnoremap <leader>rrlv :RRenameLocalVariable<cr>
vnoremap <leader>rriv :RRenameInstanceVariable<cr>
vnoremap <leader>rem  :RExtractMethod<cr>

" 0
" Font and size
set guifont=Menlo-Powerline:h12
"let g:Powerline_symbols = 'fancy'
let g:airline_powerline_fonts = 1

" When dealing with special file types
au BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery
autocmd Filetype gitcommit setlocal spell textwidth=72
let g:slime_target = "tmux"


