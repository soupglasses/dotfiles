require('catppuccin').setup({
  flavour = "latte", -- mocha, macchiato, frappe, latte
  transparent_background = true,
  color_overrides = {
    latte = { base = "#ffffff" },
  },
})
vim.api.nvim_command "colorscheme catppuccin"
