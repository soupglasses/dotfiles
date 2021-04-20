
-- Install packer if not already installed
local packer_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(packer_path)) > 0 then
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
  use 'wbthomason/packer.nvim'       -- Package manager
  use 'joshdick/onedark.vim'         -- Theme inspired by Atom
  use 'airblade/vim-gitgutter'       -- Git diffs in the sign column
end)

-- Colorscheme
vim.o.termguicolors = true
vim.g.onedark_terminal_italics = 2
vim.cmd 'colorscheme onedark'


-- Options Global
vim.o.laststatus = 2          -- Always show the statusline
vim.o.hlsearch = true         -- Highlight all matches
vim.o.incsearch = true        -- Show incremental matches
vim.o.inccommand = "nosplit"  -- Incremental live completion
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


-- Options Window
vim.wo.number = true          -- Show line numbers
vim.wo.cursorline = true      -- Highlight current line
vim.wo.signcolumn='yes'       -- Always show the sign column

-- Options Buffer
vim.bo.expandtab = true       -- Convert tabs to spaces
vim.bo.shiftwidth = 4         -- Number of spaces to indicate a tab TODO
vim.bo.tabstop = 4            -- Number of spaces to insert for tab TODO
vim.bo.smartindent = true     -- Make indenting smart
