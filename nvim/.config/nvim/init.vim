" ~/.config/nvim/init.vim

" Plugins
call plug#begin('~/.vim/plugged')
"" QoL
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'majutsushi/tagbar'
Plug 'vim-scripts/loremipsum'
"" Themes & TUI
Plug 'chriskempson/base16-vim'
Plug 'rakr/vim-one'
Plug 'joshdick/onedark.vim'
Plug 'ghifarit53/tokyonight-vim'
Plug 'itchyny/lightline.vim'
"" Launguage Spessific
""" Python
Plug 'python-mode/python-mode'
Plug 'raimon49/requirements.txt.vim'
""" TOML
Plug 'cespare/vim-toml'
""" C, C++
Plug 'octol/vim-cpp-enhanced-highlight'
""" HTML + CSS + JS
Plug 'mattn/emmet-vim'
""" SQL
Plug 'alcesleo/vim-uppercase-sql'
""" Markdown
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'dhruvasagar/vim-table-mode'
call plug#end()

" Allow for 24-bit color
if (empty($TMUX))
  if (has("nvim"))
	let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    let base16colorspace=256
  endif
  if (has("termguicolors"))
    set termguicolors
    let base16colorspace=256
  endif
endif

" Styling
syntax on
set number
set cursorline
set title
set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)
set hidden

"" Lightline
set noshowmode
set laststatus=2

"" Colorscheme
""" Tokyo Night
let g:lightline = {'colorscheme' : 'tokyonight'}
let g:tokyonight_style = 'night' " night, storm
let g:tokyonight_enable_italic = 1
colorscheme tokyonight
""" One
"let g:lightline = {'colorscheme' : 'onedark'}
"let g:one_allow_italics = 1
"colorscheme onedark
""" Base16-dark
"colorscheme base16-onedark


" Plugin Configuration
"" Python
let g:pymode_options_colorcolumn = 0
let g:pymode_rope_lookup_project = 1

"" Markdown
let g:pandoc#syntax#codeblocks#embeds#langs = ['sh', 'bash', 'python', 'dockerfile']
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
"" Emmet
imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")

"" Leader '\' commands
au BufNewFile,BufRead *.py map <silent> <leader>b :TagbarOpenAutoClose<CR>
au BufNewFile,BufRead *.md map <silent> <leader>c :TOC<CR>
map <silent> <leader>e :Lex<CR>
map <expr> <silent> <leader>l ":Loremipsum " . input('Loremipsum: ') . "<CR>"

"" Show hidden characters
set listchars=nbsp:_,tab:>-,trail:🞄,extends:>,precedes:<
command Show set list!

"" Toggle Line80
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
set clipboard=unnamedplus
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
set expandtab

""" Tabs setup
au BufNewFile,BufRead *.py set
    \ tabstop=4
    \ softtabstop=4
    \ shiftwidth=4
    \ autoindent

au BufNewFile,BufRead *.html set
    \ tabstop=2
    \ softtabstop=2
    \ shiftwidth=2

au BufNewFile,BufRead *.css set
    \ tabstop=2
    \ softtabstop=2
    \ shiftwidth=2

"" Bad habit killer
""" Disable arrow keys in normal mode
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
