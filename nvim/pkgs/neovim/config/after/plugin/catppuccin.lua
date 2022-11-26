local ok, catppuccin = pcall(require, 'catppuccin')
if not ok then
  return
end

-- flavours => mocha, macchiato, frappe, latte
catppuccin.setup { flavour = 'latte', transparent_background = true }
vim.api.nvim_command 'colorscheme catppuccin'
