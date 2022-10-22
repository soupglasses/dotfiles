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

-- Keep visual selection after indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Move selected line / block of text in visual mode
map('x', 'K', ':move \'<-2<CR>gv-gv')
map('x', 'J', ':move \'>+1<CR>gv-gv')
map('n', '<A-k>', ':move -2<CR>==')
map('n', '<A-j>', ':move +<CR>==')

-- Toggle highlights
map('n', "<Leader>h", ":set hlsearch!<CR>")

-- Emacs-like sol and eol
map('n', '<C-e>', '$')
map('n', '<C-a>', '0')
map('i', '<C-e>', '<Esc>A')
map('i', '<C-a>', '<Esc>I')
map('i', '<M-f>', '<S-Right>')
map('i', '<M-b>', '<S-left>')
map('i', '<M-p>', '<Up>')
map('i', '<M-n>', '<Down>')

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
