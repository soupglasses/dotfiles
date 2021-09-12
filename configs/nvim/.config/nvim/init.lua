-- Install packer if not already installed
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- Recompile plugins when init.lua changes
vim.api.nvim_exec([[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]], false)


-- Packer setup
local use = require('packer').use
require('packer').startup(function()
  -- Package manager
  use 'wbthomason/packer.nvim'
  -- Theme inspired by VSCode TokyoNight
  use 'folke/tokyonight.nvim'
  -- Blazing fast statusline
  use {
    'hoob3rt/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  -- Git diffs in the sign column
  use 'airblade/vim-gitgutter'
  -- Add indentation guides
  use 'lukas-reineke/indent-blankline.nvim'
  -- Collection of configurations for the built-in LSP client
  use 'neovim/nvim-lspconfig'
  -- Easy install of language servers
  use 'kabouzeid/nvim-lspinstall'
  -- Auto completion plugin
  use 'hrsh7th/nvim-compe'
  -- Treesitter highlighting
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  -- Show the colors for color codes
  use 'norcalli/nvim-colorizer.lua'
  use 'thinca/vim-quickrun'
  -- Git blame
  use 'f-person/git-blame.nvim'
  -- Emmet
  use 'mattn/emmet-vim'
  -- Fsharp
  use {
    'ionide/Ionide-vim'
  }
  -- Nginx Highlight
  use 'chr4/nginx.vim'
  -- Ansible
  use 'pearofducks/ansible-vim'
end)

-- Colorscheme
vim.o.termguicolors = true
vim.g.tokyonight_style = 'night' -- night / storm
vim.g.tokyonight_sidebars = { "quickfix", "quickrun", "qf", "vista_kind", "terminal", "packer" }
vim.cmd 'colorscheme tokyonight'

-- Gitgutter
vim.g.gitgutter_map_keys = 0
vim.g.gitgutter_sign_priority = 1

-- Git blamer
vim.g.gitblame_enabled = 0
vim.g.gitblame_date_format = '%r'
vim.g.gitblame_message_template = '    <author> - <date> - <summary>'
vim.g.gitblame_highlight_group = "Question"
vim.cmd("command! Blame GitBlameToggle")

-- Indent blankline
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'man', 'help', 'nofile' }
vim.g.indent_blankline_filetype_exclude = { 'man', 'help' }
vim.g.indent_blankline_bufname_exclude = { 'man', 'help' }
vim.g.indent_blankline_show_trailing_blankline_indent = false

-- Web devicons
require'nvim-web-devicons'.setup {
  default = true;
}

-- Lualine
require('lualine').setup {
  options = {
    -- Fix for https://github.com/kabouzeid/nvim-lspinstall/issues/39
    disabled_filetypes = {'toggleterm', 'terminal'},
    section_separators = '',
    component_separators = '',
    theme = 'tokyonight'
  }
}

-- Treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  highlight = {
    enable = true
  },
}

-- Colorizer
require 'colorizer'.setup {
  'css',
  'scss',
  'sass',
  'javascript',
  html = {
    mode = 'foreground'
  }
}

vim.cmd [[
augroup filetypedetect
  au BufRead,BufNewFile Vagrantfile setfiletype ruby
augroup END
]]

-- Emmet
vim.g.user_emmet_mode = 'inv'
vim.g.user_emmet_expandabbr_key = '<C-y>,'
vim.g.user_emmet_expandword_key = '<C-y;'
vim.g.user_emmet_update_tag = '<C-y>u'
vim.g.user_emmet_togglecomment_key = '<C-y>/'
vim.g.user_emmet_codepretty_key = '<C-y>c'

-- QuickRun
vim.g.quickrun_config = {}
vim.api.nvim_set_keymap('n', '<F2>', ':QuickRun -mode n<CR>', { noremap=true, silent=true })
vim.api.nvim_set_keymap('v', '<F2>', ':QuickRun -mode v<CR>', { noremap=true, silent=true })

-- LSP
-- -- LSP Config
local nvim_lsp = require('lspconfig')
local lspconfig = require'lspconfig'
local on_attach = function(_client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap=true, silent=true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
end

local py_settings = {
  analysis = {
    autoSearchPaths = true,
    useLibraryCodeForTypes = true
  }
}
-- local py_handlers = {
--     ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
--         virtual_text = false,
--         signs = true,
--         underline = true,
--         update_in_insert = false
--     })
-- }

-- Configure lua language server for neovim development
local lua_settings = {
  Lua = {
    runtime = {
      -- LuaJIT in the case of Neovim
      version = 'LuaJIT',
      path = vim.split(package.path, ';'),
    },
    diagnostics = {
      -- Get the language server to recognize the `vim` global
      globals = {'vim'},
    },
    workspace = {
      -- Make the server aware of Neovim runtime files
      library = {
        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
        [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
      },
    },
  }
}

local yaml_settings = {
  filetypes = { "yaml", }
}

-- Fsharp config
vim.g["fsharp#fsautocomplete_command"] = { 'dotnet', 'fsautocomplete', '--background-service-enabled' }
vim.g["fsharp#lsp_auto_setup"] = 0

require'ionide'.setup{
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  }
}

-- -- LSPInstall
require'lspinstall'.setup()
-- Enable language servers
local servers = { "bash", "python", "lua" }
for _, server in ipairs(servers) do
  local config = {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
  }

  if server == "python" then
    config.settings = py_settings
  end
  if server == "lua" then
    config.settings = lua_settings
  end
  if server == "yaml" then
    config.settings = yaml_settings
  end
  nvim_lsp[server].setup(config)
end

-- -- LSP - Map :Format to vim.lsp.buf.formatting()
vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])

-- -- LSP Compe
vim.o.completeopt = "menuone,noselect"
require'compe'.setup {
  enabled = true;
  autocomplete = false;
  debug = false;
  min_length = 1;
  preselect = false;
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = false;
    ultisnips = false;
  };
}
-- -- Set up default shortcuts
  local opts = { silent=true, expr=true }
  vim.api.nvim_buf_set_keymap(bufnr, 'i', '<C-CR>', 'compe#complete()', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'i', '<CR>', 'compe#confirm("<CR>")', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'i', '<C-e>', 'compe#close("<C-e>")', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'i', '<C-f>', 'compe#scroll({ "delta": +4 })', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'i', '<C-d>', 'compe#scroll({ "delta": -4 })', opts)

-- -- Navigate completion menu
  local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
  end

  local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
      return true
    else
      return false
    end
  end
  _G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
      return t "<C-n>"
    elseif check_back_space() then
      return t "<Tab>"
    else
      return vim.fn['compe#complete']()
    end
  end
  _G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
      return t "<C-p>"
    else
      return t "<S-Tab>"
    end
  end

  vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
  vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
  vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
  vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})


-- Configuration
-- -- Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- -- Clear search
vim.api.nvim_set_keymap('n', '<Leader>h', ':set hlsearch!<CR>', { noremap = true, silent = true })
-- -- Switch buffers
vim.api.nvim_set_keymap('n', '<C-l>', ':bnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-h>', ':bprevious<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>q', ':Bdelete<CR>', { noremap = true })
-- -- ALT+{h,j,k,l} to navigate windows
vim.api.nvim_set_keymap('t', '<A-h>', '<C-\\><C-N><C-w>h', { noremap = true })
vim.api.nvim_set_keymap('t', '<A-j>', '<C-\\><C-N><C-w>j', { noremap = true })
vim.api.nvim_set_keymap('t', '<A-k>', '<C-\\><C-N><C-w>k', { noremap = true })
vim.api.nvim_set_keymap('t', '<A-l>', '<C-\\><C-N><C-w>l', { noremap = true })
vim.api.nvim_set_keymap('i', '<A-h>', '<C-\\><C-N><C-w>h', { noremap = true })
vim.api.nvim_set_keymap('i', '<A-j>', '<C-\\><C-N><C-w>j', { noremap = true })
vim.api.nvim_set_keymap('i', '<A-k>', '<C-\\><C-N><C-w>k', { noremap = true })
vim.api.nvim_set_keymap('i', '<A-l>', '<C-\\><C-N><C-w>l', { noremap = true })
vim.api.nvim_set_keymap('n', '<A-h>', '<C-w>h', { noremap = true })
vim.api.nvim_set_keymap('n', '<A-j>', '<C-w>j', { noremap = true })
vim.api.nvim_set_keymap('n', '<A-k>', '<C-w>k', { noremap = true })
vim.api.nvim_set_keymap('n', '<A-l>', '<C-w>l', { noremap = true })
-- -- Terminal allow ESC to exit
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true })

-- Vim options
-- -- Global
vim.o.undofile = true         -- Persistent undo history
vim.o.laststatus = 2          -- Always show the statusline
vim.o.showmode = false        -- Disable the `-- INSERT --`
vim.o.hlsearch = true         -- Highlight all matches
vim.o.incsearch = true        -- Show incremental matches
vim.o.inccommand = 'nosplit'  -- Incremental live completion
vim.o.hidden = true           -- Do not save when switching buffers
vim.o.mouse = 'a'             -- Enable mouse mode
vim.o.breakindent = true      -- Allow for cleanly wrapped indentation
vim.o.ignorecase = true       -- By default ignore case on search
vim.o.smartcase = true        -- Make search case sensetive on capital in search
vim.o.updatetime = 300        -- Speed up update times for plugins
vim.o.splitbelow = true       -- Vertical splits below the current window
vim.o.splitright = true       -- Horizontal splits to the right of current window
vim.o.title = true            -- Enable title
vim.o.titlestring = [[%t%( %M%)%( (%{expand("%:~:.:h")})%)%( %a%)]]
vim.o.scrolloff = 7           -- Have 5 lines of padding at top & bottom
-- -- Window
vim.wo.number = true          -- Show line numbers
vim.wo.cursorline = true      -- Highlight current line
vim.wo.signcolumn='yes'       -- Always show the sign column
-- -- Buffer
vim.bo.expandtab = true       -- Convert tabs to spaces
vim.bo.shiftwidth = 4         -- Number of spaces to indicate a tab
vim.bo.tabstop = 4            -- Number of spaces to insert for tab
vim.bo.softtabstop = 4        -- Number of spaces for soft tabs
vim.bo.smartindent = true     -- Make indenting smart

vim.cmd "autocmd FileType html setlocal ts=2 sw=2 sts=2"
vim.cmd "autocmd FileType lua setlocal ts=2 sw=2 sts=2"


-- HACK: work-around for https://github.com/lukas-reineke/indent-blankline.nvim/issues/59
vim.wo.colorcolumn = "99999"

-- Extras
-- -- Toggle Line80
vim.api.nvim_exec([[
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
]], false)
-- -- Set Colorcolumn for git commits
vim.cmd("autocmd filetype gitcommit set colorcolumn=72")
-- -- Run python code
vim.cmd("autocmd filetype python nnoremap <F3> :w <bar> :vsplit term://python %<CR> i")
-- -- Show hidden characters
vim.o.listchars = 'nbsp:_,tab:>-,trail:🞄,extends:>,precedes:<'
vim.cmd('command Show set list!')
-- -- Y yank until the end of line
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true })
-- -- Hide line numbers in terminal windows
vim.api.nvim_exec([[
  au BufEnter term://* setlocal nonumber
]], false)
