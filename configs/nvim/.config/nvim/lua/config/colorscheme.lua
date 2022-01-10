vim.o.background = "dark"

vim.g.tokyonight_style = "night"
vim.g.tokyonight_sidebars = {
  "packer",
  "terminal",
  "vista_kind",
  "qf",
  "help",
}

-- HACK: workaround for https://github.com/lukas-reineke/indent-blankline.nvim/issues/59
vim.wo.colorcolumn = "99999"

require("tokyonight").colorscheme()
