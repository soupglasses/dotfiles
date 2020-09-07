" ~/.vimrc

" Vundle Start
" see :h vundle or https://github.com/VundleVim/Vundle.vim
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
" Sensible Defaults
Plugin 'tpope/vim-sensible'
" Themes
Plugin 'joshdick/onedark.vim'
Plugin 'itchyny/lightline.vim'
" QoL
Plugin 'Yggdroot/indentLine'
Plugin 'tpope/vim-surround'
Plugin 'airblade/vim-gitgutter'
Plugin 'majutsushi/tagbar'
Plugin 'vim-scripts/loremipsum'
" Python Spessific
Plugin 'Vimjas/vim-python-pep8-indent'
Plugin 'vim-python/python-syntax'
" HTML + CSS + JS
Plugin 'pangloss/vim-javascript'
" Markdown
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'dhruvasagar/vim-table-mode'

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
let g:onedark_terminal_italics = 1
colorscheme onedark
let g:lightline = {'colorscheme': 'onedark'}
set noshowmode

" Python highlighting
let g:python_highlight_all = 1

" Markdown
let g:pandoc#syntax#codeblocks#embeds#langs = ['bash', 'python', 'dockerfile']
let g:pandoc#syntax#conceal#use = 0
let g:pandoc#spell#default_langs = ['en']

" Markdown Tables
let g:table_mode_corner='+'
let g:table_mode_corner_corner='+'
let g:table_mode_header_fillchar='='

" Netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_winsize = 20

" \ commands
au BufNewFile,BufRead *.py map <silent> <leader>t :TagbarOpenAutoClose<CR>
au BufNewFile,BufRead *.md map <silent> <leader>c :TOC<CR>
map <leader>n :Lex<CR>:echo<CR>
map <expr> <silent> <leader>l ":Loremipsum " . input('Loremipsum: ') . "<CR>"

" QoL
set encoding=utf-8
set fileencoding=utf-8
set fileformat=unix
set ttyfast
set wrap
set showcmd
set mouse=a

" Show hidden characters
set listchars=nbsp:_,tab:>-,trail:🞄,extends:>,precedes:<
command Show set list!

" Code folding
set foldmethod=indent
set foldlevel=99

" Highlighting 
set hlsearch
set smartcase 
nnoremap <silent> <Space> :nohlsearch<CR>:echo<CR>

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
