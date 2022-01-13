-- Start packer
vim.cmd "packadd packer.nvim"

-- Auto compile packer on new changes in this file
vim.cmd "autocmd BufWritePost plugins.lua PackerCompile"

-- Setup packages
local use = require("packer").use
return require("packer").startup(function()
  -- Package manager
  use "wbthomason/packer.nvim"

  -- Colorscheme
  use {
    "folke/tokyonight.nvim",
    config = function()
      require("config.colorscheme")
    end,
  }

  -- Syntax parsing
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    requires = {
    --  "nvim-treesitter/nvim-treesitter-refactor",
    --  "nvim-treesitter/nvim-treesitter-textobjects",
    --  "RRethy/nvim-treesitter-textsubjects",
    },
    config = function()
      require("config.treesitter")
    end,
  }

  -- Spellchecking
  use {
    'lewis6991/spellsitter.nvim',
    config = function()
      require('spellsitter').setup()
    end
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
    config = function()
      require("config.lsp")
    end,
  }

  -- LSP Snippets
  use {
    "L3MON4D3/LuaSnip",
    config = function()
      require("config.lsp.snippets")
    end,
  }

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
    config = function()
      require("config.lsp.completion")
    end,
  }

  -- Indentation Lines
  use {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("config.indentline")
    end,
  }

  -- Statusline
  use {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("config.lualine")
    end,
  }

  -- Git
  use {
    "lewis6991/gitsigns.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("config.git_signs")
    end,
  }
end)
