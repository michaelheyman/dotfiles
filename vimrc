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
set tabstop=4
set shiftwidth=4
set expandtab					" use spaces instead of tabs

"relative number function toggle
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
    set number
  elseif(&number == 1)
    set nonumber
  else
    set relativenumber
  endif
endfunc
nnoremap <silent> <C-n> :call NumberToggle()<cr>
