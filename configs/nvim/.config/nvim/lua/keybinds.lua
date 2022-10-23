local function map_key(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Remap space to leader
map_key('', '<Space>', '<Nop>')
vim.g.mapleader = ' '

-- Keep visual selection after indenting
map_key('v', '<', '<gv')
map_key('v', '>', '>gv')

-- Move selected line / block of text in visual mode
map_key('x', '<M-j>', ':move \'>+1<CR>gv-gv')
map_key('x', '<M-k>', ':move \'<-2<CR>gv-gv')
map_key('n', '<M-j>', ':move +<CR>==')
map_key('n', '<M-k>', ':move -2<CR>==')

-- Clear search with <Esc>
map_key('', '<Esc>', ':nohlsearch<Esc>')
map_key('n', 'gw', '*N')
map_key('x', 'gw', '*N')

-- Emacs-like sol and eol
map_key('n', '<C-e>', '$')
map_key('n', '<C-a>', '0')
map_key('i', '<C-e>', '<Esc>A')
map_key('i', '<C-a>', '<Esc>I')
map_key('i', '<M-f>', '<S-Right>')
map_key('i', '<M-b>', '<S-left>')
map_key('i', '<M-p>', '<Up>')
map_key('i', '<M-n>', '<Down>')

-- Make `Y` yank to the end of the line
map_key('n', 'Y', 'y$')

-- Move around splits using Ctrl + {h,j,k,l}
map_key('n', '<C-h>', '<C-w>h')
map_key('n', '<C-j>', '<C-w>j')
map_key('n', '<C-k>', '<C-w>k')
map_key('n', '<C-l>', '<C-w>l')

-- Allow terminal mode to be exited with ESC
map_key('t', '<Esc>', '<C-\\><C-n>')

-- Vista tag-viewer
map_key('n', '<leader>m', ':Vista<CR>')
