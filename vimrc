set nocompatible              " be iMproved, required
filetype off                  " required

"------------------------------------------------------------
" Vundle options

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
" Plugins
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/syntastic'
" call :PluginInstall to install plugins

call vundle#end()               " required
filetype plugin indent on

"------------------------------------------------------------
" Plugin options

" Automatically displays all buffers when there's only one tab open.
let g:airline#extensions#tabline#enabled = 1
set laststatus=2
let g:airline_theme="distinguished"

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"------------------------------------------------------------
" Color options

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

"------------------------------------------------------------
" Usability options

syntax enable

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Highlight searches
set hlsearch

" Disable swap and backup files
set noswapfile
set nobackup
set undofile
set undodir=~/.vim/undo

" Indent options
set autoindent
set softtabstop=4
set shiftwidth=4

" Use spaces instead of tabs
set expandtab


" remember last cursor position
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

"------------------------------------------------------------
" Key remaps

" Fix persistent save and quit errors
command W w
command Q q

" Clear highlighted search
nmap <leader>q :nohlsearch<CR>

" Move between open buffers
nmap <leader>l :bnext<CR>
nmap <leader>h :bprevious<CR>

"------------------------------------------------------------
" Functions

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
