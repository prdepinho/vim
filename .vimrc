set nocompatible

" colors for :match highlighting
hi r ctermfg=White guifg=White ctermbg=Red guibg=Red
hi g ctermfg=Black guifg=Black ctermbg=Green guibg=Green
hi b ctermfg=Black guifg=Black ctermbg=Cyan guibg=Cyan

" indentation and formatting
filetype on
filetype plugin on
filetype indent on
set sw=2
set ts=2
set softtabstop=2
set expandtab
set nowrap
autocmd Filetype vim set sw=2 ts=2 softtabstop=2 expandtab textwidth=0 
autocmd Filetype help set sw=2 ts=2 softtabstop=2 expandtab textwidth=120 colorcolumn=0
autocmd Filetype eruby,html,xml set sw=2 ts=2 softtabstop=2 expandtab textwidth=0
autocmd Filetype ruby set sw=2 ts=2 softtabstop=2 expandtab textwidth=120 colorcolumn=-2
autocmd Filetype h,hpp,c,cpp,java,python set softtabstop=4 sw=4 ts=4 textwidth=120 noexpandtab colorcolumn=-2
autocmd Filetype text set wrap linebreak textwidth=0 wrapmargin=0


" remappings 
noremap <c-n> gt
noremap <c-p> gT
noremap zl 15zl
noremap zh 15zh
noremap <F3> :tabnew ~/.vimrc<cr>
noremap <F4> :source ~/.vimrc<cr>
noremap <F5> :copen<cr>
noremap <F6> :cclose<cr>
noremap <F7> :cn<cr>
noremap <F8> :cp<cr>
vnoremap // y/\V<C-r>"<CR>

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
set winfixwidth
set number relativenumber
set mouse=a

" vim metadata
set backup
set backupdir=~/.vim/backups
set directory=~/.vim/swaps

