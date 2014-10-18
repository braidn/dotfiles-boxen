"Setup for Vundle
""
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

set encoding=utf-8
scriptencoding utf-8
set shell=/bin/bash
""Hey Vundle
Plugin 'gmarik/Vundle.vim'

""Plugins
Plugin 'Shougo/unite.vim'
Plugin 'Shougo/vimproc.vim'
Plugin 'mattn/gist-vim'
Plugin 'scrooloose/syntastic'
Plugin 'godlygeek/tabular'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'Yggdroot/indentLine'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-endwise'
Plugin 'tomtom/tlib_vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'sjl/gundo.vim'
Plugin 'AndrewRadev/switch.vim'
Plugin 'tpope/vim-repeat'
Plugin 'benmills/vimux'
Plugin 'skalnik/vim-vroom'
Plugin 'sjl/vitality.vim'
Plugin 'vim-scripts/YankRing.vim'
Plugin 'mattn/emmet-vim'
Plugin 'mattn/webapi-vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'ervandew/supertab'
Plugin 'vim-scripts/matchit.zip'
Plugin 'tpope/vim-fugitive'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'szw/vim-tags'
Plugin 'myusuf3/numbers.vim'
Plugin 'tpope/vim-bundler'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'vim-scripts/ZoomWin'
Plugin 'itchyny/lightline.vim'
Plugin 'thoughtbot/vim-rspec'
Plugin 'rizzatti/funcoo.vim'
Plugin 'rizzatti/dash.vim'
Plugin 'edkolev/tmuxline.vim'
Plugin 'gcmt/wildfire.vim'
Plugin 'tpope/vim-dispatch'
Plugin 'fatih/vim-go'
""Will you make the cut
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'tpope/vim-vinegar'
Plugin 'tpope/vim-commentary'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'mrtazz/simplenote.vim'
Plugin 'malkomalko/projections.vim'

""Syntax
Plugin 'ChrisYip/Better-CSS-Syntax-for-Vim'
Plugin 'vim-scripts/Puppet-Syntax-Highlighting'
Plugin 'tpope/vim-cucumber'
Plugin 'pangloss/vim-javascript'
Plugin 'leshill/vim-json'
Plugin 'briancollins/vim-jst'
Plugin 'groenewege/vim-less'
Plugin 'tpope/vim-haml'
Plugin 'plasticboy/vim-markdown'
Plugin 'nono/vim-handlebars'
Plugin 'kchmck/vim-coffee-script'
Plugin 'digitaltoad/vim-jade.git'
Plugin 'slim-template/vim-slim'
Plugin 'wavded/vim-stylus'
Plugin 'heartsentwined/vim-emblem'

call vundle#end()            " required
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

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#custom#source('grep', 'ignore_globs', ['./.git/*', './.bundle/*'])
call unite#custom#source('file_rec/async', 'ignore_globs', ['./.git/*', './.bundle/*'])
let g:unite_source_rec_async_command =
    \ 'ag --follow --nocolor --nogroup -g ""'

" A Better Grep
if executable('ag')
  " Use ag over grep
   let g:unite_source_grep_command='ag'
   let g:unite_source_grep_default_opts='--nocolor --line-numbers --nogroup -S -C4'
   let g:unite_source_grep_recursive_opt=''
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
