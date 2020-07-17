
" ======================================
" Champok Das .vimrc file
" ======================================
"
"
let mapleader=" "

map <F3> <Esc>:set guifont=*<CR>
" Who even needs help anymore lol
nnoremap <F1> <nop>
" What the fuck is Ex mode?
nnoremap Q <nop>
nnoremap gy gT
nnoremap h <C-w>h
nnoremap l <C-w>l
" I like seeing where I came from
map <PageDown> <C-d>zz
map <PageUp> <C-u>zz
imap <PageDown> <C-o><C-d><C-o>zz
imap <PageUp> <C-o><C-u><C-o>zz
nnoremap G Gzz

" Quicker window movement in normal mode
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Pesky little tabs can't hind from me anymore
set listchars=tab:\ \ ,trail:·,extends:>

" Bing bang <silent>
set noerrorbells
set novisualbell

" Some say numbers are for noobs
set number
" Well I say you haven't felt RELATIVE NUMBERS YET
set rnu

" We're not in the 90's anymore old man
set textwidth=150
set ruler
set cursorline " OK fine, I might be a little blind

" Who doesn't like to search things
set hlsearch
set smartcase
set ignorecase
set incsearch
set showmatch

set autoindent

" Tabs are evil
set expandtab
set shiftwidth=2
set smartindent
set smarttab
set softtabstop=2

" But vim tabs are nice sometimes
set tabpagemax=100

" I forget where I am sometimes
set statusline=<<\ %f%m\ >>%r%h%w
set statusline+=[%{&ff}]
set statusline+=%=
set statusline+=\ %P
set statusline+=[%03.3b/\%02.2B]\ [POS=%04v]

set laststatus=2
set showtabline=2

" When you need to yank it
" But things just get in the way
set nowrap

" Make back space great again (or really backspace more modern
set backspace=indent,eol,start

" IDK what these do, but I steal em anyway
set showmode
set lazyredraw
set cursorline
set numberwidth=6

" Stole this one from Kevin to also save my pinky
nmap ; :

set nocompatible

set tags=./tags;/

if (empty($TMUX))
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    " Sometimes may need to use this in when using PuTTy + tmux
    " set Vim-specific sequences for RGB colors
    "let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    "let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
  endif
endif

syntax on
set title
set titleold=
set term=xterm
filetype on
filetype plugin indent on

set swapfile
set dir=/tmp

" Vundle stuff
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'davidhalter/jedi-vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'preservim/nerdtree'
Plugin 'joshdick/onedark.vim'
Plugin 'sheerun/vim-polyglot'
call vundle#end()

colorscheme onedark
let g:jedi#use_splits_not_buffers="right"
let g:jedi#popup_select_first=0
let g:jedi#show_call_signatures=1
let g:multi_cursor_quit_key = '<Esc>'

map<C-o> :NERDTreeToggle<CR>

autocmd FileType python setlocal completeopt-=preview
autocmd VimEnter * NERDTree " open NERDTree on startup
autocmd VimEnter * wincmd w " jump to active window on startup
let NERDTreeShowHidden=1 " always show hidden files

function! GetMatches(line1, line2, pattern)
  let hits = []
  for line in range(a:line1, a:line2)
    let text = getline(line)
    let from = 0
    while 1
      let next = match(text, a:pattern, from, 1)
      if next < 0
        break
      endif
      let from = matchend(text, a:pattern, from, 1)
      if from > next
        call add(hits, strpart(text, next, from - next))
      else
        let char = matchstr(text, '.', next)
        if empty(char)
          break
        endif
        let from = next + strlen(char)
      endif
    endwhile
  endfor
  return hits
endfunction

set wildmenu
"set wildmenu=longest:list,full
set wildignore+=*.o,*.obj,*~
set wildignore+=*vim/backups*

set history=1000
set diffopt+=vertical
set splitbelow
set splitright
