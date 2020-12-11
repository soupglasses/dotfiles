" ~/.vimrc

" Plugin Managment
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"" Plugin manager
Plugin 'VundleVim/Vundle.vim'
"" QoL
Plugin 'tpope/vim-sensible'
Plugin 'Yggdroot/indentLine'
Plugin 'tpope/vim-surround'
Plugin 'airblade/vim-gitgutter'
Plugin 'majutsushi/tagbar'
Plugin 'vim-scripts/loremipsum'
"" Themes & TUI
Plugin 'joshdick/onedark.vim'
Plugin 'itchyny/lightline.vim'
"" Launguage spessiffic
""" Python
Plugin 'python-mode/python-mode'
""" HTML + CSS + JS
Plugin 'pangloss/vim-javascript'
""" SQL
Plugin 'alcesleo/vim-uppercase-sql'
""" Markdown
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'dhruvasagar/vim-table-mode'
call vundle#end()
filetype plugin indent on


" Styling
syntax on
set number
"set relativenumber
set cursorline
set title
set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)

"" Theme setup
set laststatus=2
let g:onedark_terminal_italics = 1
colorscheme onedark
let g:lightline = {'colorscheme': 'onedark'}
set noshowmode

""" Use true 24bit color
if (has("termguicolors"))
  set termguicolors
endif


" Plugin Configuration
"" Python
let g:pymode_options_colorcolumn = 0
let g:pymode_rope_lookup_project = 1
"" Markdown
let g:pandoc#syntax#codeblocks#embeds#langs = ['bash', 'python', 'dockerfile']
let g:pandoc#syntax#conceal#use = 0
let g:pandoc#spell#default_langs = ['en']
""" Markdown Tables
let g:table_mode_corner='+'
let g:table_mode_corner_corner='+'
let g:table_mode_header_fillchar='='
"" Netrw
let g:netrw_banner = 0
let g:netrw_list_hide = '^\.\.\=/\=$,.DS_Store,.idea,.git,__pycache__,venv,node_modules,*\.o,*\.pyc,.*\.swp'
let g:netrw_hide = 1
let g:netrw_browse_split = 0
let g:netrw_liststyle = 3
let g:netrw_winsize = 20


" Commands
"" Leader '\' commands
au BufNewFile,BufRead *.py map <silent> <leader>b :TagbarOpenAutoClose<CR>
au BufNewFile,BufRead *.md map <silent> <leader>c :TOC<CR>
map <silent> <leader>e :Lex<CR>
map <expr> <silent> <leader>l ":Loremipsum " . input('Loremipsum: ') . "<CR>"
"" Show hidden characters
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


" QoL
"" Sensible encoding
set encoding=utf-8
set fileencoding=utf-8
set fileformat=unix
"" Better TUI experience
set ttyfast
set showcmd
set mouse=a
set wrap
"" Code folding
set foldmethod=indent
set foldlevel=99
"" Highlighting 
set hlsearch
set smartcase 
nnoremap <silent> <Space> :nohlsearch<CR>
"" Split setup
set splitbelow
set splitright
""" Split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
"" Default tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
""" Tabs for Python
au BufNewFile,BufRead *.py set
    \ tabstop=4
    \ softtabstop=4
    \ shiftwidth=4
    \ expandtab
    \ autoindent
""" Tabs for HTML, CSS and JS
au BufNewFile,BufRead *.js, *.html, *.css set
    \ tabstop=2
    \ softtabstop=2
    \ shiftwidth=2
"" Bad habit killer
""" Disable arrow keys in normal mode
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
