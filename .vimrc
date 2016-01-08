syntax on 
filetype plugin indent on
set number
set smartindent

" prevent usage of arrows
nnoremap <Left> :echoe "Use H"<CR> 
nnoremap <Right> :echoe "Use L"<CR>
nnoremap <Up> :echoe "Use K"<CR>
nnoremap <Down> :echoe "Use J"<CR>
noremap! <Up> <Esc>
noremap! <Down> <Esc>
noremap! <Left> <Esc>
noremap! <Right> <Esc>>

set hlsearch
set noswapfile
set nobackup

" indent options
set autoindent
set tabstop=4
set expandtab
set smarttab
"set cursorline
