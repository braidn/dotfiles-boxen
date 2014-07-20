"Setup for Vundle
""
set shell=/bin/bash
scriptencoding utf-8
set encoding=utf-8
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

""Hey Vundle
Bundle 'gmarik/vundle'

""Plugins
Bundle 'kien/ctrlp.vim'
Bundle 'mattn/gist-vim'
Bundle 'scrooloose/syntastic'
Bundle 'godlygeek/tabular'
Bundle 'altercation/vim-colors-solarized'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'Yggdroot/indentLine'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-endwise'
Bundle 'tomtom/tlib_vim'
Bundle 'jiangmiao/auto-pairs'
Bundle 'sjl/gundo.vim'
Bundle 'AndrewRadev/switch.vim'
Bundle 'tpope/vim-repeat'
Bundle 'benmills/vimux'
Bundle 'skalnik/vim-vroom'
Bundle 'sjl/vitality.vim'
Bundle 'vim-scripts/YankRing.vim'
Bundle 'mattn/emmet-vim'
Bundle 'mattn/webapi-vim'
Bundle 'airblade/vim-gitgutter'
Bundle 'ervandew/supertab'
Bundle 'vim-scripts/matchit.zip'
Bundle 'tpope/vim-fugitive'
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'szw/vim-tags'
Bundle 'myusuf3/numbers.vim'
Bundle 'tpope/vim-bundler'
Bundle 'SirVer/ultisnips'
Bundle 'honza/vim-snippets'
Bundle 'vim-scripts/ZoomWin'
Bundle 'itchyny/lightline.vim'
Bundle 'thoughtbot/vim-rspec'
Bundle 'rizzatti/funcoo.vim'
Bundle 'rizzatti/dash.vim'
Bundle 'edkolev/tmuxline.vim'
Bundle 'gcmt/wildfire.vim'
Bundle 'tpope/vim-dispatch'
""Will you make the cut
Bundle 'AndrewRadev/splitjoin.vim'
Bundle 'tpope/vim-vinegar'
Bundle 'tpope/vim-commentary'
Bundle 'editorconfig/editorconfig-vim'
Bundle 'mrtazz/simplenote.vim'
Bundle 'malkomalko/projections.vim'

""Syntax
Bundle 'ChrisYip/Better-CSS-Syntax-for-Vim'
Bundle 'vim-scripts/Puppet-Syntax-Highlighting'
Bundle 'tpope/vim-cucumber'
Bundle 'pangloss/vim-javascript'
Bundle 'leshill/vim-json'
Bundle 'briancollins/vim-jst'
Bundle 'groenewege/vim-less'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-haml'
Bundle 'nono/vim-handlebars'
Bundle 'kchmck/vim-coffee-script'
Bundle 'digitaltoad/vim-jade.git'
Bundle 'slim-template/vim-slim'
Bundle 'wavded/vim-stylus'
Bundle 'heartsentwined/vim-emblem'




filetype plugin indent on

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste'  ], [ 'fugitive', 'filename'  ], ['ctrlpmark']  ],
      \   'right': [ [ 'syntastic', 'lineinfo'  ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype'  ]  ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'MyFugitive',
      \   'filename': 'MyFilename',
      \   'fileformat': 'MyFileformat',
      \   'filetype': 'MyFiletype',
      \   'fileencoding': 'MyFileencoding',
      \   'mode': 'MyMode',
      \   'ctrlpmark': 'CtrlPMark',
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

function! CtrlPMark()
  if expand('%:t') =~ 'ControlP'
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
  \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
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
"let g:solarized_termcolors=256
set background=dark
colorscheme solarized
call togglebg#map("<F1>")
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
let g:yankring_history_dir = '~/.vim/tmp'
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
" " Inspect runner pane
 map <Leader>ro :VimuxOpenPane<CR>
" " Close all other tmux panes in current window
 map <Leader>rx :CloseVimTmuxPanes<CR>
" " Interrupt any command running in the runner pane
 map <Leader>rs :VimuxClearRunnerHistory<CR>

" Vroom Settings
let g:vroom_use_zeus = 1
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

"Ctrl-p Bindings
let g:ctrlp_map = '<Leader>p'
nnoremap <Leader>b :CtrlPBuffer<CR>
nnoremap <Leader>. :CtrlPTag<CR>

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

nnoremap <Leader>zt :call RunCurrentSpecFile()<CR>
nnoremap <Leader>zl :call RunLastSpec()<CR>
let g:rspec_command = "Dispatch bundle exec rspec {spec}"

" When dealing with special file types
au BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery
autocmd Filetype gitcommit setlocal spell textwidth=72
let g:slime_target = "tmux"

" A Better Grep
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
