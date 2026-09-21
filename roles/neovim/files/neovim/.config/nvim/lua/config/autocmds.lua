-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Make neovim recognize Vagrantfiles
vim.cmd([[
augroup filetypedetect
  au BufRead,BufNewFile Vagrantfile setfiletype ruby
augroup END
]])

-- Make neovim recognize SystemD service files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.service*",
  callback = function()
    vim.bo.filetype = "systemd"
  end,
})

-- Make neovim recognize yrl (yecc) and xrl (leex) files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.yrl",
  callback = function()
    vim.bo.filetype = "erlang.yrl"
  end,
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.xrl",
  callback = function()
    vim.bo.filetype = "erlang.xrl"
  end,
})

-- Set column to 72 for git commits
vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  callback = function()
    vim.wo.colorcolumn = "72"
  end,
})

-- Line function for setting colorcolumn
function Line(pos)
  pos = pos or ""
  if vim.api.nvim_get_option_value("colorcolumn", { scope = "local" }) == tostring(pos) then
    pos = "" -- When reusing the same value, unset the colorcolumn instead.
  end
  vim.api.nvim_set_option_value("colorcolumn", tostring(pos), { scope = "local" })
end

-- Create user commands
vim.api.nvim_create_user_command("Line", function(opts)
  Line(tonumber(opts.args))
end, { nargs = "?" })

vim.api.nvim_create_user_command("Line80", function()
  Line(80)
end, {})
