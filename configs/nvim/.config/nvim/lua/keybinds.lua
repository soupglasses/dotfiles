local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Remap space to leader
map('', '<Space>', '<Nop>')
vim.g.mapleader = ' '

-- Add keyboard shortcut to clear current search
map('n', '<leader>c', ':nohl<CR>')

-- Make `Y` yank to the end of the line
map('n', 'Y', 'y$')

-- Move around splits using Ctrl + {h,j,k,l}
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- Open a Terminal window with Ctrl + T
map('n', '<C-t>', ':Term<CR>', { noremap = true })

-- Allow terminal mode to be exited with ESC
map('t', '<Esc>', '<C-\\><C-n>')

-- Vista tag-viewer
map('n', '<leader>m', ':Vista<CR>')
