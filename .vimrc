set nocompatible

" colors for :match highlighting
hi r ctermfg=White guifg=White ctermbg=Red guibg=Red
hi g ctermfg=Black guifg=Black ctermbg=Green guibg=Green
hi b ctermfg=Black guifg=Black ctermbg=Cyan guibg=Cyan

" indentation and formatting
filetype plugin on
filetype plugin indent on
set sw=2
set ts=2
set softtabstop=2
set expandtab
autocmd Filetype h,hpp,c,cpp,java,python set softtabstop=4 sw=4 ts=4 noexpandtab
autocmd Filetype text set wrap linebreak textwidth=0 wrapmargin=0
set nowrap

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
set number relativenumber
set mouse=a

" vim metadata
set backup
set backupdir=~/.vim/backups
set directory=~/.vim/swaps

