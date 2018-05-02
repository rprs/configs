" First thing on any vimrc file: Set no compatible
set nocompatible


" Mappings for quickly editing and sourcing and editing ~/.vimrc
:nnoremap <leader>ve :vsplit $MYVIMRC<cr>
:nnoremap <leader>vs :w\|:bd\|source $MYVIMRC<cr>
:nnoremap <leader>vq :bd!<cr>

" Mappings for quickly showing diffs.
:nnoremap <leader>cdq :bd\|diffoff<cr>
:nnoremap <leader>cdu :Gdiff<cr>
:nnoremap <leader>cds :Gdiff HEAD<cr>

" Mapping for using FZF:
:nnoremap <leader>cfs :FZF<cr>

"" How we limited ag to only look for certain directories:
" let g:rprs_tree_directories = map([
  " \ 'src/',
  " \ ], 'piperlib#GetRootDir() . v:val')
" let $FZF_DEFAULT_COMMAND = join(map(copy(g:rprs_tree_directories),
        " \ '''ag '' . v:val . '' --nocolor --nogroup --ignore "**/*.pyc" -g ""'''), ' ; ')

" Let fzf use ag with all directories
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

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
" Cscope section
" ----------------------------------------------------------------------------

" This tests to see if vim was configured with the '--enable-cscope' option
" when it was compiled.  If it wasn't, time to recompile vim... 
if has("cscope")

  """"""""""""" Standard cscope/vim boilerplate

  " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
  set cscopetag

  " check cscope for definition of a symbol before checking ctags: set to 1
  " if you want the reverse search order.
  set csto=0

  " add any cscope database in current directory
  if filereadable("cscope.out")
    cs add cscope.out  
    " else add the database pointed to by environment variable 
  elseif $CSCOPE_DB != ""
    cs add $CSCOPE_DB
  endif

  " show msg when any other cscope db added
  set cscopeverbose  


  """"""""""""" My cscope/vim key mappings
  "
  " The following maps all invoke one of the following cscope search types:
  "
  "   's'   symbol: find all references to the token under cursor
  "   'g'   global: find global definition(s) of the token under cursor
  "   'c'   calls:  find all calls to the function name under cursor
  "   't'   text:   find all instances of the text under cursor
  "   'e'   egrep:  egrep search for the word under cursor
  "   'f'   file:   open the filename under cursor
  "   'i'   includes: find files that include the filename under cursor
  "   'd'   called: find functions that function under cursor calls
  "
  " Below are three sets of the maps: one set that just jumps to your
  " search result, one that splits the existing vim window horizontally and
  " diplays your search result in the new window, and one that does the same
  " thing, but does a vertical split instead (vim 6 only).
  "
  " I've used CTRL-\ and CTRL-@ as the starting keys for these maps, as it's
  " unlikely that you need their default mappings (CTRL-\'s default use is
  " as part of CTRL-\ CTRL-N typemap, which basically just does the same
  " thing as hitting 'escape': CTRL-@ doesn't seem to have any default use).
  " If you don't like using 'CTRL-@' or CTRL-\, , you can change some or all
  " of these maps to use other keys.  One likely candidate is 'CTRL-_'
  " (which also maps to CTRL-/, which is easier to type).  By default it is
  " used to switch between Hebrew and English keyboard mode.
  "
  " All of the maps involving the <cfile> macro use '^<cfile>$': this is so
  " that searches over '#include <time.h>" return only references to
  " 'time.h', and not 'sys/time.h', etc. (by default cscope will return all
  " files that contain 'time.h' as part of their name).


  " To do the first type of search, hit 'CTRL-\', followed by one of the
  " cscope search types above (s,g,c,t,e,f,i,d).  The result of your cscope
  " search will be displayed in the current window.  You can use CTRL-T to
  " go back to where you were before the search.  
  "

  nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>  
  nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>  
  nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>  
  nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>  
  nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>  
  nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>  
  nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
  nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>  


  " Using 'CTRL-spacebar' (intepreted as CTRL-@ by vim) then a search type
  " makes the vim window split horizontally, with search result displayed in
  " the new window.
  "
  " (Note: earlier versions of vim may not have the :scs command, but it
  " can be simulated roughly via:
  "    nmap <C-@>s <C-W><C-S> :cs find s <C-R>=expand("<cword>")<CR><CR>  

  nmap <C-@>s :scs find s <C-R>=expand("<cword>")<CR><CR> 
  nmap <C-@>g :scs find g <C-R>=expand("<cword>")<CR><CR> 
  nmap <C-@>c :scs find c <C-R>=expand("<cword>")<CR><CR> 
  nmap <C-@>t :scs find t <C-R>=expand("<cword>")<CR><CR> 
  nmap <C-@>e :scs find e <C-R>=expand("<cword>")<CR><CR> 
  nmap <C-@>f :scs find f <C-R>=expand("<cfile>")<CR><CR> 
  nmap <C-@>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR> 
  nmap <C-@>d :scs find d <C-R>=expand("<cword>")<CR><CR> 


  " Hitting CTRL-space *twice* before the search type does a vertical 
  " split instead of a horizontal one (vim 6 and up only)
  "
  " (Note: you may wish to put a 'set splitright' in your .vimrc
  " if you prefer the new window on the right instead of the left

  nmap <C-@><C-@>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
  nmap <C-@><C-@>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
  nmap <C-@><C-@>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
  nmap <C-@><C-@>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
  nmap <C-@><C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
  nmap <C-@><C-@>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR> 
  nmap <C-@><C-@>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR> 
  nmap <C-@><C-@>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>

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

  " Tell VAM which plugins to fetch & load:
  " call vam#ActivateAddons([], {'auto_install' : 0})
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
" Removing youcompleteme until I configure it correclty.
" \"github:Valloric/YouCompleteMe",
let myplugins = [
      \"github:airblade/vim-gitgutter",
      \"github:tpope/vim-fugitive",
      \"diffchar",
      \"github:junegunn/fzf",
      \"github:Valloric/YouCompleteMe",
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
