vim.g.catppuccin_flavour = "latte" -- latte, frappe, macchiato, mocha

require("catppuccin").setup({
  transparent_background = true,
})

vim.cmd [[colorscheme catppuccin]]
