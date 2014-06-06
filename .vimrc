" This shows what you are typing as a command.
set showcmd

" Needed for Syntax Highlighting and stuff
filetype on
filetype plugin on
syntax enable

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Who doesn't like autoindent?
set autoindent

" Spaces are better than a tab character
set expandtab
set smarttab

" Who wants an 8 character tab?  Not me!
set shiftwidth=2
set softtabstop=2

" Cool tab completion stuff
set wildmenu
"set wildmode=list:longest,full

" Line Numbers PWN!
"set number

" Ignoring case is a fun trick
set ignorecase

" And so is Artificial Intellegence!
set smartcase

"Always show status bar (the grey one at bottom)
set laststatus=2


"Show current line number
set ruler

"Always show tab title
set stal=2

"Highlight search pattern matches
set hlsearch

"Toggles paste identation
set pastetoggle=<F2>

"Avoids replacing copied text when deleting new
vnoremap p "_dP

"Set tag file path
" set tag=./tags,./TAGS,tags,TAGS,~/.vim/tags/stdlibcpp

""YCM section

"Set file for ycm clang completer 
let g:ycm_global_ycm_extra_conf = '/home/rprs/.vim/.ycm_extra_conf.py'

"Make sure preview window never opens
set completeopt-=preview
let g:ycm_add_preview_to_completeopt = 0

