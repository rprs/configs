" First thing on any vimrc file: Set no compatible
set nocompatible


" Mappings for quickly editing and sourcing and editing ~/.vimrc
:nnoremap <leader>ve :vsplit $MYVIMRC<cr>
:nnoremap <leader>vs :w\|:bd\|source $MYVIMRC<cr>
:nnoremap <leader>vq :bd!<cr>

" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

" Delete comment character when joining commented lines
if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j
endif

" Characters that show whitespaces.
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

" Who wants an 8 character tab?  Not me!
set softtabstop=2
set shiftwidth=2
set tabstop=2
set shiftround

" Who doesn't like autoindent?
set autoindent
set smartindent

" Spaces are better than a tab character
set expandtab
set smarttab

" Line Numbers PWN!
set number

" This shows what you are typing as a command.
set showcmd

" show part of last line even if it too long to show it complete.
set display+=lastline

" Autocomplete vim commands
set wildmenu

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

" Show search pattern matches as you type
set incsearch

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" Automatically load file if it has changed outside vim.
set autoread

"Toggles paste identation
set pastetoggle=<F2>

" command history
if &history < 1000
  set history=1000
endif

"Max number of tabs
if &tabpagemax < 50
  set tabpagemax=50
endif

" Avoid undoable undos
inoremap <C-U> <C-G>u<C-U>

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux'
  set t_Co=16
endif

" Diffing
highlight DiffAdd      ctermfg=231  ctermbg=22   cterm=NONE
highlight DiffChange   ctermfg=231  ctermbg=17   cterm=NONE
highlight DiffDelete   ctermfg=196  ctermbg=88   cterm=NONE
highlight DiffText     ctermfg=000  ctermbg=214  cterm=NONE

" Search
hi Search ctermfg=8  ctermbg=7

" Needed for Syntax Highlighting and stuff
if has('autocmd')
  filetype on
  filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
  syntax on
endif

" ----------------------------------------------------------------------------
" YCM section
" ----------------------------------------------------------------------------

"Set file for ycm clang completer
"let g:ycm_global_ycm_extra_conf = '/home/rprs/.vim/.ycm_extra_conf.py'

"Make sure preview window never opens
"set completeopt-=preview
"let g:ycm_add_preview_to_completeopt = 0

" ----------------------------------------------------------------------------
" vam (vi addon manager) section
" ----------------------------------------------------------------------------

fun! EnsureVamIsOnDisk(plugin_root_dir)
  " windows users may want to use http://mawercer.de/~marc/vam/index.php
  " to fetch VAM, VAM-known-repositories and the listed plugins
  " without having to install curl, 7-zip and git tools first
  " -> BUG [4] (git-less installation)
  let vam_autoload_dir = a:plugin_root_dir.'/vim-addon-manager/autoload'
  if isdirectory(vam_autoload_dir)
    return 1
  else
    if 1 == confirm("Clone VAM into ".a:plugin_root_dir."?","&Y\n&N")
      " I'm sorry having to add this reminder. Eventually it'll pay off.
      call confirm("Remind yourself that most plugins ship with ".
            \"documentation (README*, doc/*.txt). It is your ".
            \"first source of knowledge. If you can't find ".
            \"the info you're looking for in reasonable ".
            \"time ask maintainers to improve documentation")
      call mkdir(a:plugin_root_dir, 'p')
      execute '!git clone --depth=1 git://github.com/MarcWeber/vim-addon-manager '.
            \       shellescape(a:plugin_root_dir, 1).'/vim-addon-manager'
      " VAM runs helptags automatically when you install or update
      " plugins
      exec 'helptags '.fnameescape(a:plugin_root_dir.'/vim-addon-manager/doc')
    endif
    return isdirectory(vam_autoload_dir)
  endif
endfun

fun! SetupVAM()
  " Set advanced options like this:
  " let g:vim_addon_manager = {}
  " let g:vim_addon_manager.key = value
  "     Pipe all output into a buffer which gets written to disk
  " let g:vim_addon_manager.log_to_buf =1

  " Example: drop git sources unless git is in PATH. Same plugins can
  " be installed from www.vim.org. Lookup MergeSources to get more control
  " let g:vim_addon_manager.drop_git_sources = !executable('git')
  " let g:vim_addon_manager.debug_activation = 1

  " VAM install location:
  let c = get(g:, 'vim_addon_manager', {})
  let g:vim_addon_manager = c
  let c.plugin_root_dir = expand('$HOME/.vim/vim-addons', 1)
  if !EnsureVamIsOnDisk(c.plugin_root_dir)
    echohl ErrorMsg | echomsg "No VAM found!" | echohl NONE
    return
  endif
  let &rtp.=(empty(&rtp)?'':',').c.plugin_root_dir.'/vim-addon-manager'

  " Examples
  " Tell VAM which plugins to fetch & load:
  "call vam#ActivateAddons([], {'auto_install' : 0})
  " sample: call vam#ActivateAddons(['pluginA','pluginB', ...], {'auto_install' : 0})
  " Also See "plugins-per-line" below

  " Addons are put into plugin_root_dir/plugin-name directory
  " unless those directories exist. Then they are activated.
  " Activating means adding addon dirs to rtp and do some additional
  " magic

  " How to find addon names?
  " - look up source from pool
  " - (<c-x><c-p> complete plugin names):
  " You can use name rewritings to point to sources:
  "    ..ActivateAddons(["github:foo", .. => github://foo/vim-addon-foo
  "    ..ActivateAddons(["github:user/repo", .. => github://user/repo
  " Also see section "2.2. names of addons and addon sources" in VAM's documentation
endfun
call SetupVAM()
" experimental [E1]: load plugins lazily depending on filetype, See
" NOTES
" experimental [E2]: run after gui has been started (gvim) [3]
" option1:  au VimEnter * call SetupVAM()
" option2:  au GUIEnter * call SetupVAM()
" See BUGS sections below [*]
" Vim 7.0 users see BUGS section [3]


" ----------------------------------------------------------------------------
" Installing plugins
" ----------------------------------------------------------------------------

" List of plugins to make only one call to vam#ActivateAddons.
" vim-gutgitter to mark lines that have changed.
" vim-fugitive for git integration.
" Diffchar to make diff more readable.
let myplugins = [
      \"github:airblade/vim-gitgutter",
      \"github:tpope/vim-fugitive",
      \"github:Valloric/YouCompleteMe",
      \"diffchar",
      \]
call vam#ActivateAddons(myplugins, {'auto_install' : 0})


" ----------------------------------------------------------------------------
" Plugins settings
" ----------------------------------------------------------------------------

"" DIFFCHAR
" diff by words, not by chars:
let g:DiffUnit = 'Word1'
" " update diffs (not sure why this isn't default)
let g:DiffUpdate = 1

