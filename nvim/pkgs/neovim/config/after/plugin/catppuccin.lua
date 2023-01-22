local ok, catppuccin = pcall(require, 'catppuccin')
if not ok then
  return
end

catppuccin.setup {
  flavour = 'mocha', -- mocha, macchiato, frappe, latte
  color_overrides = {
    latte = { base = '#ffffff' }
  }
}
vim.cmd.colorscheme 'catppuccin'
