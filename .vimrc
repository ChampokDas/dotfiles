
" ======================================
" Champok Das .vimrc file
" ======================================
"
"
let mapleader=" "

map <F3> <Esc>:set guifont=*<CR>
nnoremap gy gT
nnoremap h <C-w>h
nnoremap l <C-w>l

" Quicker window movement in normal mode
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

nnoremap f za
vnoremap f zf

set noerrorbells
set novisualbell
set number
set linebreak
set showbreak=+++
set textwidth=150
set showmatch
set ruler

set hlsearch
set smartcase
set ignorecase
set incsearch

set autoindent
set expandtab
set shiftwidth=2
set smartindent
set smarttab
set softtabstop=2
set tabpagemax=100
set laststatus=2
set showtabline=2

set foldmethod=indent " fold by indentlevel
set nofoldenable      " but all folds open by default

set wrap
" Stole this one from Kevin to also save my pinky
nmap ; :

set nocompatible

set tags=./tags;/

if (empty($TMUX))
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
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
" whenever i use java, this is the one thing that i hate the most
imap ;sout System.out.println("");<left><left><left>
