-- Start packer
vim.cmd "packadd packer.nvim"

-- Auto compile packer on new changes in this file
vim.cmd "autocmd BufWritePost config.lua PackerCompile"

-- Setup packages
local use = require("packer").use
return require("packer").startup(function()
  -- Package manager
  use "wbthomason/packer.nvim"

  -- Colorscheme
  use "folke/tokyonight.nvim"

  -- Syntax parsing
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }

  -- Markdown syntax
  use {
    "vim-pandoc/vim-pandoc-syntax",
    config = function()
      vim.cmd [[
        augroup pandoc_syntax
          au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
        augroup END
      ]]
    end,
  }

  -- Core LSP
  use {
    "neovim/nvim-lspconfig",
    requires = {
      "williamboman/nvim-lsp-installer",
      "jose-elias-alvarez/null-ls.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
    },
  }

  -- LSP Snippets
  use "L3MON4D3/LuaSnip"

  -- LSP Completions
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind-nvim",
    },
  }

  -- LSP tag overview
  use "liuchengxu/vista.vim"

  -- Indentation Lines
  use "lukas-reineke/indent-blankline.nvim"
  -- Statusline
  use "nvim-lualine/lualine.nvim"

  -- Git
  use {
    "lewis6991/gitsigns.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
    },
  }

  -- Dashboard
  use {
    "goolord/alpha-nvim",
    requires = {
      'kyazdani42/nvim-web-devicons',
    },
  }

end)
