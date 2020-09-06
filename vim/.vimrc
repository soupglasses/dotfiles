" ~/.vimrc

" Vundle Start
" see :h vundle or https://github.com/VundleVim/Vundle.vim
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'joshdick/onedark.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'Yggdroot/indentLine'
Plugin 'tpope/vim-surround'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-scripts/indentpython.vim'

call vundle#end()
filetype plugin indent on
" Vundle End

" Use true 24bit color
if (has("termguicolors"))
  set termguicolors
endif

" Styling
syntax on
set number
set cursorline
set cursorlineopt=number
set title
set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)

" Theme setup
set laststatus=2
colorscheme onedark
let g:lightline = {'colorscheme': 'onedark'}
set noshowmode

" Disable arrow keys in normal mode
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" Split setup
set splitbelow
set splitright

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" QoL
set encoding=utf-8
set ttyfast
set wrap
set showcmd
set mouse=a

" Default tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Tabs for Python
au BufNewFile,BufRead *.py set
    \ tabstop=4
    \ softtabstop=4
    \ shiftwidth=4
    \ expandtab
    \ autoindent

" Tabs for HTML, CSS and JS
au BufNewFile,BufRead *.js, *.html, *.css set
    \ tabstop=2
    \ softtabstop=2
    \ shiftwidth=2

" Highlighting 
set hlsearch
set smartcase 
nnoremap <silent> <Space> :nohlsearch<CR>

" Show hidden characters
set listchars=nbsp:_,tab:>-,trail:🞄,extends:>,precedes:<
command Show set list!

" Toggle Line80
let g:line80=0
function! ToggleLine80()
    if g:line80
        set colorcolumn=0 
        let g:line80=0
    else
        set colorcolumn=80
        let g:line80=1
    endif
endfunction
command Line80 :call ToggleLine80()
