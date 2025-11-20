call plug#begin()

" Colorschemes
"Plugin 'altercation/vim-colors-solarized'
"Plugin 'junegunn/seoul256.vim'
Plug 'morhetz/gruvbox'
"Plugin 'Lokaltog/vim-distinguished'
Plug 'w0ng/vim-hybrid'

" Plugins
Plug 'elmcast/elm-vim', { 'for': 'elm' }
Plug 'guns/vim-clojure-static', { 'for': 'clojure' }
Plug 'kien/rainbow_parentheses.vim', { 'for': 'clojure' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
Plug 'purescript-contrib/purescript-vim', { 'for': 'purescript' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()
