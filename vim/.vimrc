" ~/.vimrc

" Vundle Start
" see :h vundle or https://github.com/VundleVim/Vundle.vim
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'joshdick/onedark.vim'
Plugin 'sheerun/vim-polyglot'
Plugin 'itchyny/lightline.vim'
Plugin 'Yggdroot/indentLine'
Plugin 'tpope/vim-surround'

call vundle#end()
filetype plugin indent on
" Vundle End

" Use true 24bit color
if (has("termguicolors"))
  set termguicolors
endif

" Polyglot Spessific
"let g:polyglot_disabled = ['python-compiler', 'python-indent', 'python']
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

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

" Disable arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" QoL
set encoding=utf-8
set ttyfast
set wrap
set showcmd
set mouse=a

" Tabs
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set noshiftround

" Highlighting 
set hlsearch
set smartcase 
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Save current file as root
command W w !sudo tee "%" > /dev/null

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
