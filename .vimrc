syntax enable				" syntax highlighting

" Color
set t_Co=256 				" Distinguished specific
set cursorline				" Distinguished specific
colorscheme distinguished

" Plugins
filetype plugin indent on

set nu						" display line numbers

" Avoid usage of arrows
nnoremap <Left> :echoe "Use H"<CR> 
nnoremap <Right> :echoe "Use L"<CR>
nnoremap <Up> :echoe "Use K"<CR>
nnoremap <Down> :echoe "Use J"<CR>
noremap! <Up> <Esc>
noremap! <Down> <Esc>
noremap! <Left> <Esc>
noremap! <Right> <Esc>>

set hlsearch				" highlight searches

" Disable swap and backup files
set noswapfile
set nobackup

" Indent options
set autoindent
set noexpandtab				" use tab instead of spaces
set tabstop=4
set shiftwidth=4

set clipboard=unnamed		" enable osx clipboard sharing
