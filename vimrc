set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" lternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Colorschemes
Plugin 'altercation/vim-colors-solarized'
Plugin 'junegunn/seoul256.vim'
Plugin 'morhetz/gruvbox'
Plugin 'Lokaltog/vim-distinguished'

" call :PluginInstall to install plugins

call vundle#end()               " required
filetype plugin indent on

command W w
command Q q

" Color
syntax enable

" gruvbox:
"let g:gruvbox_termcolors=16
"colo gruvbox

" seoul256:
"   Range:   233 (darkest) ~ 239 (lightest)
"   Default: 237
let g:seoul256_background=234
colo seoul256

" solarized:
" set background=dark
" let g:solarized_termcolors=256
" colorscheme solarized

" distinguished:
" set t_Co=256
" set cursorline
" colorscheme distinguished

"set nu						" display line numbers
set hlsearch				" highlight searches

" Disable swap and backup files
set noswapfile
set nobackup
set undofile
set undodir=~/.vim/undo

" Indent options
set autoindent
set softtabstop=4
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

" remember last cursor position
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
