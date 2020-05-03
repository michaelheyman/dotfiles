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
"Plugin 'junegunn/seoul256.vim'
Plugin 'morhetz/gruvbox'
"Plugin 'Lokaltog/vim-distinguished'
Plugin 'w0ng/vim-hybrid'

" Plugins
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'lervag/vimtex'
Plugin 'tpope/vim-surround'
Plugin 'guns/vim-clojure-static'        "clojure
Plugin 'kien/rainbow_parentheses.vim'   "clojure
Plugin 'tpope/vim-fireplace'            "clojure
Plugin 'elmcast/elm-vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'neovimhaskell/haskell-vim'
Plugin 'purescript-contrib/purescript-vim'

call vundle#end()               " required
filetype plugin indent on

"call :PluginInstall to install plugins

"------------------------------------------------------------
" Plugin options

" haskell-vim options
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords

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
" colorscheme gruvbox
" set background=dark

" seoul256:
"   Range:   233 (darkest) ~ 239 (lightest)
"   Default: 237
"let g:seoul256_background=234
"colo seoul256

" solarized:
" set background=dark
" let g:solarized_termcolors=256
" colorscheme solarized

" distinguished:
" set t_Co=256
" set cursorline
" colorscheme distinguished

" hybrid
set background=dark
colorscheme hybrid
set cursorline
set number

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
"set colorcolumn=80
"let &colorcolumn=join(range(81,999),",")
highlight OverLength ctermbg=red ctermfg=white
match OverLength /\%74v\+/

" netrw options
let g:netrw_liststyle = 3 " set default netrw view to tree
let g:netrw_banner = 0
let g:netrw_winsize = 25

" open vsplit to the right
set splitright

" open term on the bottom instead of above
set splitbelow

" :term size
" set termwinsize=15x0

" allows switching to another buffer without having to save it first
set hidden

" prevent {} motion from opening fold
set foldopen-=block

" set autoformat for haskell with keybind gq
":set formatprg=stylish-haskell

set tw=79

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

" Enable backspace in vim 8.1.X -- I probably should do this
set backspace=2

"------------------------------------------------------------
" Functions

"relative number function toggle
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
  elseif(&number == 1)
    set nonumber
    set relativenumber
  else
    set number
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

let buildCommand = { 
            \'cpp' : 'g++ -std=c++11',
            \'elm' : 'elm-make',
            \'py': 'python3'
            \}

" Different settings for different filetypes
autocmd Filetype clj,hs,lhs setlocal ts=2 sw=2 sts=2
"autocmd FileType elm map ,t :w\|!elm make %
autocmd FileType cpp map ,t :w\|!g++ -std=c++11 %
autocmd FileType py map ,t :w\|!python3 %
