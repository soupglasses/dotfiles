vim.o.background = "dark"

vim.g.tokyonight_style = "night"
vim.g.tokyonight_sidebars = {
  "packer",
  "terminal",
  "vista_kind",
  "qf",
  "help",
}
vim.g.tokyonight_dark_sidebar = true

-- HACK: workaround for https://github.com/lukas-reineke/indent-blankline.nvim/issues/59
vim.wo.colorcolumn = "99999"

require("tokyonight").colorscheme()

-- Make command window and line-numbers have a dark background
vim.cmd [[highlight MsgArea guibg=#16161e]]
