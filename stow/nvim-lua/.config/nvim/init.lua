
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
  -- Theme inspired by Atom
  use 'joshdick/onedark.vim'
  -- Git diffs in the sign column
  use 'airblade/vim-gitgutter'
  -- Add indentation guides
  use { 'lukas-reineke/indent-blankline.nvim', branch="lua" }
  -- Collection of configurations for the built-in LSP client
  use 'neovim/nvim-lspconfig'
  -- Easy install of language servers
  use 'kabouzeid/nvim-lspinstall'
  -- Treesitter highlighting
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
end)


-- Indent blankline
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }


-- Treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true
  }
}

-- LSPInstall
require'lspinstall'.setup()

-- LSP
local nvim_lsp = require('lspconfig')
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
-- -- Enable language servers
local servers = require'lspinstall'.installed_servers()
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end
-- -- Map :Format to vim.lsp.buf.formatting()
vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])


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


-- Colorscheme
vim.o.termguicolors = true
vim.g.onedark_terminal_italics = 2
vim.cmd 'colorscheme onedark'


-- Vim options
-- -- Global
vim.o.laststatus = 2          -- Always show the statusline
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
vim.o.title = true            -- Enable title
vim.o.titlestring = [[%t%( %M%)%( (%{expand("%:~:.:h")})%)%( %a%)]]
-- -- Window
vim.wo.number = true          -- Show line numbers
vim.wo.cursorline = true      -- Highlight current line
vim.wo.signcolumn='yes'       -- Always show the sign column
-- -- Buffer
vim.bo.expandtab = true       -- Convert tabs to spaces
vim.bo.shiftwidth = 4         -- Number of spaces to indicate a tab TODO
vim.bo.tabstop = 4            -- Number of spaces to insert for tab TODO
vim.bo.smartindent = true     -- Make indenting smart


-- Extras
-- -- Show hidden characters
vim.o.listchars = 'nbsp:_,tab:>-,trail:🞄,extends:>,precedes:<'
vim.cmd('command Show set list!')
-- -- Y yank until the end of line
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true })
