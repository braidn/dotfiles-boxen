"Setup for Plugin Manager
""
set nocompatible
filetype off
call plug#begin('~/.vim/plugged')

set encoding=utf-8
scriptencoding utf-8
set shell=/bin/bash

""Plugs
Plug 'altercation/vim-colors-solarized'
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimproc.vim', { 'do': 'make -f make_mac.mak' }
Plug 'mattn/gist-vim'
Plug 'scrooloose/syntastic'
Plug 'godlygeek/tabular'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'Lokaltog/vim-easymotion'
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tomtom/tlib_vim'
Plug 'jiangmiao/auto-pairs'
Plug 'sjl/gundo.vim'
Plug 'AndrewRadev/switch.vim'
Plug 'tpope/vim-repeat'
Plug 'benmills/vimux'
Plug 'skalnik/vim-vroom'
Plug 'sjl/vitality.vim'
Plug 'mattn/emmet-vim'
Plug 'mattn/webapi-vim'
Plug 'airblade/vim-gitgutter'
Plug 'ervandew/supertab'
Plug 'vim-scripts/matchit.zip'
Plug 'tpope/vim-fugitive'
Plug 'christoomey/vim-tmux-navigator'
Plug 'szw/vim-tags'
Plug 'b3niup/numbers.vim'
Plug 'tpope/vim-bundler'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'vim-scripts/ZoomWin'
Plug 'itchyny/lightline.vim'
Plug 'thoughtbot/vim-rspec'
Plug 'rizzatti/funcoo.vim'
Plug 'rizzatti/dash.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'gcmt/wildfire.vim'
Plug 'tpope/vim-dispatch'
Plug 'fatih/vim-go'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install'  }
Plug 'gabebw/vim-rdio'
""Will you make the cut
Plug 'AndrewRadev/splitjoin.vim'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-commentary'
Plug 'editorconfig/editorconfig-vim'
Plug 'mrtazz/simplenote.vim'
Plug 'malkomalko/projections.vim'
Plug 'Shougo/neocomplete.vim'

""Syntax
Plug 'ChrisYip/Better-CSS-Syntax-for-Vim'
Plug 'vim-scripts/Puppet-Syntax-Highlighting'
Plug 'tpope/vim-cucumber'
Plug 'pangloss/vim-javascript'
Plug 'leshill/vim-json'
Plug 'briancollins/vim-jst'
Plug 'groenewege/vim-less'
Plug 'tpope/vim-haml'
Plug 'plasticboy/vim-markdown'
Plug 'nono/vim-handlebars'
Plug 'kchmck/vim-coffee-script'
Plug 'wting/rust.vim'
Plug 'slim-template/vim-slim'
Plug 'wavded/vim-stylus'
Plug 'heartsentwined/vim-emblem'

call plug#end()            " required
filetype plugin indent on

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste'  ], [ 'fugitive', 'filename'  ] ],
      \   'right': [ [ 'syntastic', 'lineinfo'  ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype'  ]  ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'MyFugitive',
      \   'filename': 'MyFilename',
      \   'fileformat': 'MyFileformat',
      \   'filetype': 'MyFiletype',
      \   'fileencoding': 'MyFileencoding',
      \   'mode': 'MyMode',
      \ },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
      \ },
      \ 'subseparator': { 'left': '|', 'right': '|'  }
      \ }


function! MyModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! MyFilename()
  let fname = expand('%:t')
  return fname == 'ControlP' ? g:lightline.ctrlp_item :
        \ fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
      let mark = ''  " edit here for cool mark
      let _ = fugitive#head()
      return strlen(_) ? mark._ : ''
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
  let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction

augroup AutoSyntastic
  autocmd!
  autocmd BufWritePost *.c,*.cpp call s:syntastic()
augroup END
function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0


"Color stuff
syntax enable
set term=xterm-256color
let g:solarized_termtrans = 1
set background=dark
colorscheme solarized
set clipboard=unnamed

" Random personal settings
set smartindent
set linespace=0                 " No extra spaces between rows
set backspace=indent,eol,start
set laststatus=2
set t_Co=256
set showmode
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
"trim whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

"Yank into OS X, might require reattach-to-user clipboard"
noremap <leader>y "*y
noremap <leader>yy "*Y

"Preserve indentations from pasteboard
noremap <leader>P :set paste<CR>:put  *<CR>:set nopaste<CR>

" Leader Mapping
let mapleader = "\<Space>"
let g:gitgutter_enabled = 0
nmap <leader>nx :vp.<CR>
nmap <leader>nv :ss.<CR>
nmap <silent> <leader>\ :nohlsearch<CR>
nmap <leader>yr :YRShow<cr>
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
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
nnoremap <silent> <leader>gw :Gwrite!<CR>

"Indent Lines
hi Conceal ctermfg=red ctermbg=NONE

" Vimux stuff
" Prompt for a command to run
 map <Leader>rt :VimuxPromptCommand<CR>
" " Run last command executed by RunVimTmuxCommand
 map <Leader>rl :VimuxRunLastCommand<CR>
" " Close all other tmux panes in current window
 map <Leader>rx :VimuxCloseRunner<CR>
" " Interrupt any command running in the runner pane
 map <Leader>rh :VimuxClearRunnerHistory<CR>

" Vroom Settings
let g:vroom_use_dispatch = 1

"Switch
nnoremap - :Switch<cr>

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
let g:UltiSnipsSnippetsDir        = '/.vim/bundle/vim-snippets/'
let g:UltiSnipsSnippetDirectories = ['UltiSnips']
let g:UltiSnipsListSnippets = "<c-a>"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"

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

"TmuxLine settings
let g:tmuxline_preset = {
      \'a' : '#S',
      \'b' : '#(whoami)',
      \'c' : '#(~/src/battery Discharging)',
      \'win'  : ['#I', '#W'],
      \'cwin' : ['#I', '#W', '#F'],
      \'z' : '#(tmux-mem-cpu-load 2)',}

""Key remaps
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
inoremap jj <ESC>

nnoremap <Leader>p :Unite file_rec/async:./<cr>
nnoremap <Leader>/ :Unite grep:.<cr>
let g:unite_source_history_yank_enable = 1
nnoremap <Leader>Y :Unite history/yank<cr>
nnoremap <Leader>s :Unite -quick-match buffer<cr>

nnoremap <Leader>zt :call RunCurrentSpecFile()<CR>
nnoremap <Leader>zl :call RunLastSpec()<CR>
let g:rspec_command = "Dispatch bundle exec rspec {spec}"

" When dealing with special file types
au BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery
autocmd Filetype gitcommit setlocal spell textwidth=72
let g:slime_target = "tmux"
let g:netrw_bufsettings='nu'
let netrw_liststyle=3
let g:syntastic_javascript_checkers = ['jshint']

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#custom#source('grep', 'ignore_globs', ['./.git/*', './.bundle/*', 'node_modules/**', 'app/bower_components/**', 'app/images/**', 'dist/**'])
call unite#custom#source('file_rec/async', 'ignore_globs', ['./.git/*', './.bundle/*', 'node_modules/**', 'app/bower_components/**', 'app/images/**', 'dist/**'])
let g:unite_source_rec_async_command =
    \ 'ag --follow --nocolor --nogroup -g ""'

let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()
inoremap <expr><C-e>  neocomplete#cancel_popup()

nnoremap <Leader>nce :NeoCompleteEnable<cr>
nnoremap <Leader>ncd :NeoCompleteDisable<cr>

" A Better Grep
if executable('ag')
  " Use ag over grep
   let g:unite_source_grep_command='ag'
   let g:unite_source_grep_default_opts='--nocolor --line-numbers --nogroup -S -C4'
   let g:unite_source_grep_recursive_opt='--line-numbers'
  set grepprg=ag\ --nogroup\ --nocolor
endif

function! s:RevealInFinder()
  if filereadable(expand("%"))
    let l:command = "open -R %"
  elseif getftype(expand("%:p:h")) == "dir"
    let l:command = "open %:p:h"
  else
    let l:command = "open ."
  endif
  execute ":silent! !" . l:command
 " For terminal Vim not to look messed up.
 redraw!
endfunction command! Reveal call <SID>RevealInFinder()
