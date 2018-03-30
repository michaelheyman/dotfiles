set nocompatible              " be iMproved, required
filetype off                  " required

"------------------------------------------------------------
" Vundle options

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Colorschemes
"Plugin 'altercation/vim-colors-solarized'
Plugin 'junegunn/seoul256.vim'
"Plugin 'morhetz/gruvbox'
"Plugin 'Lokaltog/vim-distinguished'

" Plugins
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'lervag/vimtex'
Plugin 'tpope/vim-surround'

call vundle#end()               " required
filetype plugin indent on

"call :PluginInstall to install plugins

"------------------------------------------------------------
" Plugin options

" vim-airline
"Automatically displays all buffers when there's only one tab open.
let g:airline#extensions#tabline#enabled = 1
set laststatus=2
let g:airline_theme="distinguished"

" vimtex
"these options are not working
let g:vimtex_disable_version_warning = 1
let g:vimtex_compiler_latexmk = {'callback' : 0}

" Skim config for vimtext
let g:vimtex_view_general_viewer
            \ = '/Applications/Skim.app/Contents/SharedSupport/displayline'
let g:vimtex_view_general_options = '-r @line @pdf @tex'

" This adds a callback hook that updates Skim after compilation
let g:vimtex_latexmk_callback_hooks = ['UpdateSkim']
function! UpdateSkim(status)
    if !a:status | return | endif

    let l:out = b:vimtex.out()
    let l:tex = expand('%:p')
    let l:cmd = [g:vimtex_view_general_viewer, '-r']
    if !empty(system('pgrep Skim'))
        call extend(l:cmd, ['-g'])
    endif
    if has('nvim')
        call jobstart(l:cmd + [line('.'), l:out, l:tex])
    elseif has('job')
        call job_start(l:cmd + [line('.'), l:out, l:tex])
    else
        call system(join(l:cmd + [line('.'), shellescape(l:out), shellescape(l:tex)], ' '))
    endif
endfunction

" Clears auxiliary build files on vimtex exit
augroup vimtex_config
    au!
    au User VimtexEventQuit call vimtex#compiler#clean(0)
augroup END
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
"set hlsearch
" Highlight searches without requiring :noh afterwards
set incsearch nohlsearch

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

" removes delay from inserting new line with O
set ttimeoutlen=100

" sets a vertical bar to suggest word-wrapping
set colorcolumn=80
"------------------------------------------------------------
" Key remaps

" Fix persistent save and quit errors
command W w
command Wq wq
command Q q

" Clear highlighted search
nmap <leader>q :nohlsearch<CR>

" Move between open buffers
nmap gn :bn<CR>
nmap gp :bp<CR>

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

" Templates for tutoring
function! CppMain()
    call append(0, "#include <iostream>")
    call append(1, "#include <string>")
    call append(2, "using namespace std;")
    call append(3, "")
    call append(4, "int main() {")
    call append(5, "")
    call append(6, "    return 0;")
    call append(7, "}")
endfunction

function! JavaMain()
    call append(0, "class Application {")
    call append(1, "    public static void main(String[] args) {")
    call append(2, "    }")
    call append(3, "}")
endfunction
