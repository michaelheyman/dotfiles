" Enable syntax higlighting
syntax on 

" color scheme
"set t_Co=256
"set background=dark

filetype plugin indent on

" Enable line numbers
set number

" Enable smart indentation
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

" Highlight searches
set hlsearch

" Disable swap and backup files
set noswapfile
set nobackup

" Indent options
set autoindent
set tabstop=2
set expandtab
set smarttab
set shiftwidth=4

"set cursorline
