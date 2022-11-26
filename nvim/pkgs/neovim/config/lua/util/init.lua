local M = {}

M.first_load = function()
  -- Ensures external dependencies are in check.
  -- Returns true if this was the first load, false otherwise.
  -- Only will return true at first call.
  if not pcall(require, 'packer') then
    local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    print('Downloading packer.nvim ...')
    print(vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path}))
    vim.cmd 'packadd packer.nvim'
    print('Done!')
    return true
  end
  return false
end

M.map = function(mode, lhs, rhs, opts)
  local options = { silent = true, noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

return M
