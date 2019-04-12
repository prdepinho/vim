set nocompatible
syntax on
colors zellner  " a theme that keeps the terminal bg color
set encoding=utf-8

" windows vim
if has("gui_running")

  colors torte
  " Tweaks to the color scheme.
  hi Normal guibg=gray10
  hi TabLine guifg=Black guibg=Grey

  " set guifont=Consolas:h10
  set guifont=Lucida\ Console:h9
  set guioptions=

  " Cursor and column line.
  hi CursorLine guibg=gray15
  hi CursorColumn guibg=gray15
  set cursorline
  set cursorcolumn
  " set columns=85 lines=60

  " Remap meta keys to work in the terminal, instead of printing weird
  " characters.
  tnoremap <M-b> <ESC>b
  tnoremap <M-f> <ESC>f
  tnoremap <M-d> <ESC>d
  tnoremap <M-BS> <ESC><BS>
  tnoremap <S-Insert> <C-w>""

  if has("gui_win32")
    " This changes the default shell for Git Bash, instead of Windows CMD. 
    " If the path has a space, like in Program\ Files, your :! commands will
    " not work, so move or copy your Git instalation somewhere else without a
    " space.
    set shell=C:/MinGw/Git/bin/bash.exe
    set shellpipe=|
    set shellredir=>
    set shellcmdflag=-c

    " I haven't figured out how :grep or :make can use the temp folder on
    " Windows to create an error list. 
    " An alternative to using :grep -e "expression" $(find -name "*.py")
    " is to use :vimgrep "expression" **/*.py instead.
    set grepprg=grep

    " This maximazes the window by opening the window menu with Alt-Space and typing x.
    augroup maximizegroup
      autocmd!
      autocmd VimEnter * simalt ~x
    augroup end
    simalt ~x

    " Copy to clipboard by default.
    set clipboard=unnamed
  endif
endif

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

augroup indentationgroup
  autocmd!
  autocmd Filetype qf set cc=-1
  autocmd Filetype text set sw=2 ts=2 sts=2 et wrap linebreak wrapmargin=0 cc=80 autoindent nu rnu
  autocmd Filetype notype set nonu nornu cc=0 nowrap
  autocmd Filetype netrw set nu rnu nowrap
  autocmd Filetype eruby,html,xml set sw=2 ts=2 sts=2 et cc=0 nowrap nu rnu
  autocmd Filetype sql,vim,ruby  set sw=2 ts=2 sts=2 et cc=120 nowrap nu rnu
  autocmd Filetype h,hpp,c,cpp,java set sts=4 sw=4 ts=4 cc=120 noet nowrap nu rnu
  autocmd Filetype python set sts=4 shiftwidth=4 ts=4 cc=120 et nowrap nu rnu
  autocmd Filetype markdown set sts=4 shiftwidth=4 ts=4 cc=120 et nowrap nu rnu
augroup end 

augroup miscgroup
  autocmd!
  autocmd Filetype netrw autocmd BufEnter hi CursorLine gui=underline
  autocmd BufEnter *.vue setfiletype html
  autocmd BufEnter * if &filetype == "" | setlocal filetype=notype | endif
augroup end

" Auto close tags, (, [ and { when follod with <RETURN> or <SPACE>
augroup tagsgroup
  autocmd!
  autocmd Filetype eruby,html,xml inoremap <buffer> ><RETURN> ><ESC>T<yiwf>a</<ESC>pA><ESC>F<i<RETURN><ESC>O
  autocmd Filetype eruby,html,xml inoremap <buffer> ><SPACE> ><ESC>T<yiwf>a</<ESC>pA><ESC>F<i
augroup end

inoremap (<RETURN> ()<ESC>i<RETURN><ESC>O
inoremap [<RETURN> []<ESC>i<RETURN><ESC>O
inoremap {<RETURN> {}<ESC>i<RETURN><ESC>O
inoremap (<SPACE> ()<ESC>i
inoremap [<SPACE> []<ESC>i
inoremap {<SPACE> {}<ESC>i

" remappings 
map <c-w>q <nop>
noremap <c-n> gt
noremap <c-p> gT
noremap <C-TAB> gt
noremap <C-S-TAB> gT
tnoremap <C-TAB> <C-w>:normal gt<CR>
tnoremap <C-S-TAB> <C-w>:normal gT<CR>
noremap <F1> :copen<cr>
noremap <F2> :cclose<cr>
noremap <F3> :cn<cr>
noremap <F4> :cp<cr>

" In GitBash has("Win32") returns false;
" this returns true on Windows even when in GitBash.
if $OS == "Windows_NT"
  noremap <F5> :source ~/_vimrc<cr>
  noremap <F6> :tabnew ~/_vimrc<cr>
else
  noremap <F5> :source ~/.vim/vimrc<cr>
  noremap <F6> :tabnew ~/.vim/vimrc<cr>
endif

vnoremap // y/\V<C-r>"<CR>
vnoremap < <gv
vnoremap > >gv

" browsing and navigation
let g:netrw_bufsettings = 'noma nomod nu rnu nobl nowrap ro'
let g:netrw_liststyle = 1
let g:netrw_banner = 0
set wildmode=longest,list,full
set wildmenu
set hlsearch
set incsearch
set laststatus=2
set statusline=%<%f%h%m%r%=%b\ 0x%B\ \ %l,%c%V\ %P
set showcmd
set splitbelow
set splitright
set number relativenumber
set mouse=a
set backspace=indent,eol,start

" vim metadata
set history=1000
set backup
if $OS == "Windows_NT"
  set backupdir=~/_vim/backups
  set directory=~/_vim/swaps
else
  set backupdir=~/.vim/backups
  set directory=~/.vim/swaps
endif
" set lazyredraw  " This makes my tag closing remaps indent too much.

"
" Functions and commands
"
function! Path(path)
  " Substitutes backslashes on a windows path to forward slashes.
  let new_path = substitute(a:path, "\\", "/", "g")
  return new_path
endfunction

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
  let branch = Path(system("git remote")[:-2]."/".system("git symbolic-ref HEAD --short")[:-2])
  if a:0 >= 1
    let branch = a:1
  endif
  echo branch
  let filename = Path(@%)
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

function! TransformPath(path)
  " Transform a path into a valid filename.
  let new_path = substitute(a:path, "\\", "__", "g")
  let new_path = substitute(new_path, "/", "__", "g")
  let new_path = substitute(new_path, " ", "_", "g")
  let new_path = substitute(new_path, ":", "", "g")
  return new_path
endfunction

function! OpenSession(...)
  " Open a session with the specified session name. If no name is specified,
  " open the session of the directory previously created by calling
  " CloseSession without argumnt at the same directory.
  if a:0 >= 1
    let session_name = a:1
  else
    let pwd = getcwd()
    let session_name = TransformPath(pwd)
  endif
  execute "source ~/_vim/sessions/".session_name.".vim"
endfunction

function! CloseSession(...)
  " Save the session with the specified name and close Vim. If no name is
  " specified, a session will be created with a name based on the working
  " directory path. This session may be open by calling OpenSession without
  " argument at the same directory.
  if a:0 >= 1
    let session_name = a:1
  else
    let pwd = getcwd()
    let session_name = TransformPath(pwd)
  endif
  execute "mks! ~/_vim/sessions/".session_name.".vim"
  execute "wa"
  execute "qa!"
endfunction

" Git commands
com! GiffAll call TabGitDiff()
com! -nargs=* Giff call TabVimdiff(<f-args>)
com! OverwriteRemote call OverwriteRemote()
com! OverwriteLocal call OverwriteLocal()
com! -nargs=* SolveConflict call SolveConflict(<f-args>)

" Misc commands
com! -nargs=* CreateWorkspace call CreateWorkspace(<f-args>)
com! -nargs=* OpenSession call OpenSession(<f-args>)
com! -nargs=* CloseSession call CloseSession(<f-args>)
