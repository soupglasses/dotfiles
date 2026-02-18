-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Do not copy to system clipboard automatically.
vim.opt.clipboard = ""

-- Have n lines of padding at top & bottom
vim.o.scrolloff = 3

-- Nicer title
vim.o.title = true -- Enable title
vim.o.titlestring = [[%t%( %M%)%( (%{expand("%:~:.:h")})%)%( %a%)]]

-- NBSP? No thanks.
vim.o.listchars = "nbsp:_,tab:>-,trail:🞄,extends:>,precedes:<"

-- File Spessific
vim.cmd("autocmd FileType html setlocal ts=2 sw=2 sts=2")
vim.cmd("autocmd FileType lua setlocal ts=4 sw=4 sts=4")
vim.cmd("autocmd FileType nix setlocal ts=2 sw=2 sts=2")
