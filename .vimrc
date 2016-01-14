" Enable syntax higlighting
"syntax on 
syntax enable

"set t_Co=256
set background=dark
"colorscheme monokai
colorscheme solarized

" plugins
filetype plugin indent on

" Enable line numbers
set number

" Enable smart indentation
"set smartindent

" prevent usage of arrows
nnoremap <Left> :echoe "Use H"<CR> 
nnoremap <Right> :echoe "Use L"<CR>
nnoremap <Up> :echoe "Use K"<CR>
nnoremap <Down> :echoe "Use J"<CR>
noremap! <Up> <Esc>
noremap! <Down> <Esc>
noremap! <Left> <Esc>
noremap! <Right> <Esc>>

" Highlight searches
set hlsearch

" Disable swap and backup files
set noswapfile
set nobackup

" Indent options
set autoindent
set noexpandtab
set tabstop=4
"set expandtab
set shiftwidth=4

set smarttab

"set cursorline
