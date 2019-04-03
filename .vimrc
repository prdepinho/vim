set nocompatible
syntax on
colors zellner

" windows vim
if has("gui_running")
  if has("gui_win32")
    set guifont=Consolas:h10
    set columns=85
    set lines=60
  endif
endif

let $TMPDIR=fnameescape($HOME."/_vim/tmp/")
" let $TMP=fnameescape($HOME."/_vim/tmp/")

" colors for :match highlighting
" eg. :match r /noremap/
hi r ctermfg=White guifg=White ctermbg=Red guibg=Red
hi g ctermfg=Black guifg=Black ctermbg=Green guibg=Green
hi b ctermfg=Black guifg=Black ctermbg=Cyan guibg=Cyan
hi y ctermfg=Black guifg=Black ctermbg=Yellow guibg=Yellow

" indentation and formatting
filetype on
filetype plugin on
filetype indent on
autocmd Filetype text set sw=2 ts=2 softtabstop=2 expandtab wrap linebreak wrapmargin=0 colorcolumn=80 autoindent
autocmd Filetype notype set nonumber norelativenumber colorcolumn=0 nowrap
autocmd Filetype netrw set number relativenumber nowrap
autocmd Filetype vim set sw=2 ts=2 softtabstop=2 expandtab colorcolumn=120 nowrap
autocmd Filetype eruby,html,xml set sw=2 ts=2 softtabstop=2 expandtab colorcolumn=0 nowrap
autocmd Filetype ruby set sw=2 ts=2 softtabstop=2 expandtab colorcolumn=120 nowrap
autocmd Filetype h,hpp,c,cpp,java set softtabstop=4 sw=4 ts=4 colorcolumn=120 noexpandtab nowrap
autocmd Filetype python set softtabstop=4 shiftwidth=4 tabstop=4 colorcolumn=120 expandtab nowrap
autocmd Filetype markdown set softtabstop=4 shiftwidth=4 tabstop=4 colorcolumn=120 expandtab nowrap

autocmd BufEnter * if &filetype == "" | setlocal filetype=notype | endif

" remappings 
map <c-w>q <nop>
noremap <c-n> gt
noremap <c-p> gT
noremap <F1> :copen<cr>
noremap <F2> :cclose<cr>
noremap <F3> :cn<cr>
noremap <F4> :cp<cr>
noremap <F5> :source ~/_vimrc<cr>
noremap <F6> :tabnew ~/_vimrc<cr>
vnoremap // y/\V<C-r>"<CR>
vnoremap < <gv
vnoremap > >gv

" browsing and navigation
let g:netrw_liststyle = 3
let g:netrw_banner = 0
set wildmode=longest,list,full
set wildmenu
set hlsearch
set incsearch
set laststatus=2
set splitbelow
set splitright
set number relativenumber
set mouse=a
set backspace=indent,eol,start

" vim metadata
set history=1000
set backup
set backupdir=~/_vim/backups
set directory=~/_vim/swaps
set lazyredraw

" functions and commands
function! TabGitDiff()
  " Shows git diff of the unstaged files in a new tab.
  tabnew
  r!git diff
  set filetype=git
  set colorcolumn=0
  normal gg
endfunction

function! TabVimdiff(...)

  " Open a tab with a vimdiff screen of the current file and its repository
  " version. It receives the branch as argument in the form repository/branch.
  " The current branch is the default. It is useful for checking the
  " differences of a staged file.
  
  let branch = system("git remote")[:-2]."/".system("git symbolic-ref HEAD --short")[:-2]
  if a:0 >= 1
    let branch = a:1
  endif
  echo branch
  let filename = @%
  tabnew
  execute "r!git show ".branch.":".filename
  normal gg
  normal dd
  execute "vert diffsplit ".filename
endfunction

function! OverwriteRemote()

  " Remove the remote lines of a merging Git file. Only the local
  " modifications remain.

  execute "g/^<<<<<<</d"
  execute "g/^=======$/.,/^>>>>>>>/d"
endfunction

function! OverwriteLocal()

  " Remove the local lines of a merging Git file. The remote lines
  " modifications remain.

  execute "g/^<<<<<<</.,/^=======$/d"
  execute "g/^>>>>>>>/d"
endfunction

function! SolveConflict(...)

  " Opens a new tab with the Git differences of a file in conflict. It
  " received the conflicting branch as argument. The default branch is
  " origin/master.

  let branch = "origin/master"
  if a:0 >= 1
    let branch = a:1
  endif
  call OverwriteRemote()
  execute "w"
  call TabVimdiff(branch)
endfunction

function! CreateWorkspace(...)
  " Opens a variable number of terminals and resizes the text buffer to be
  " just the right size.
  execute "vert term"

  let terminals = 1
  if a:0 >= 1
    let terminals = a:1
  endif

  let x = 1
  while x < terminals
    execute "term"
    let x = x + 1
  endwhile

  wincmd h
  execute "vert res 124"
  execute "set number relativenumber"
endfunction

com! GiffAll call TabGitDiff()
com! -nargs=* Giff call TabVimdiff(<f-args>)
com! OverwriteRemote call OverwriteRemote()
com! OverwriteLocal call OverwriteLocal()
com! -nargs=* SolveConflict call SolveConflict(<f-args>)

com! -nargs=* CreateWorkspace call CreateWorkspace(<f-args>)
