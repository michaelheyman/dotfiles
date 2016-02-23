execute pathogen#infect()
syntax on
filetype plugin indent on

command W w
command Q q

" Color
set t_Co=256 				" Distinguished specific
set cursorline				" Distinguished specific
colorscheme distinguished

"set nu						" display line numbers
set hlsearch				" highlight searches

" Disable swap and backup files
set noswapfile
set nobackup
set undofile
set undodir=~/.vim/undo

" Indent options
set autoindent
"set noexpandtab				" use tab instead of spaces
set expandtab					" use spaces instead of tabs
set tabstop=4
set shiftwidth=4

set clipboard=unnamed		" enable osx clipboard sharing
