set nocompatible
syntax on
colors zellner

if has("gui_running")
  if has("gui_win32")
    set guifont=Consolas:h10
    set columns=85
    set lines=60
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
autocmd Filetype qf set colorcolumn=-1
autocmd Filetype text set wrap linebreak wrapmargin=0 colorcolumn=80 autoindent
autocmd Filetype notype set nonumber norelativenumber colorcolumn=0 nowrap
autocmd Filetype netrw set number relativenumber
autocmd Filetype vim set sw=2 ts=2 softtabstop=2 expandtab colorcolumn=80
autocmd Filetype eruby,html,xml set sw=2 ts=2 softtabstop=2 expandtab colorcolumn=0
autocmd Filetype ruby set sw=2 ts=2 softtabstop=2 expandtab colorcolumn=120 
autocmd Filetype h,hpp,c,cpp,java set softtabstop=4 sw=4 ts=4 colorcolumn=120 noexpandtab 
autocmd Filetype python set softtabstop=4 shiftwidth=4 tabstop=4 colorcolumn=80 nowrap

autocmd BufEnter * if &filetype == "" | setlocal filetype=notype | endif

" remappings 
noremap <c-n> gt
noremap <c-p> gT
noremap <F1> :copen<cr>
noremap <F2> :cclose<cr>
noremap <F3> :cp<cr>
noremap <F4> :cn<cr>
noremap <F5> :source ~/.vim/vimrc<cr>
noremap <F6> :tabnew ~/.vim/vimrc<cr>
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
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
set lazyredraw

" functions and commands
function! GitDiff()
  r!git diff
  set filetype=git
  set colorcolumn=0
endfunction

function! TabGitDiff()
  tabnew
  call GitDiff()
  normal gg
endfunction

com! Giff call TabGitDiff()

