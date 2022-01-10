-- Remap space to leader
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Add keyboard shortcut to clear current search
vim.api.nvim_set_keymap('n', '<leader>h', ':set hlsearch!<CR>', { noremap = true, silent = true })

-- Allow terminal mode to be exited with ESC
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true })

-- Make neovim recognize Vagrantfiles
vim.cmd [[
augroup filetypedetect
  au BufRead,BufNewFile Vagrantfile setfiletype ruby
augroup END
]]

-- Set column to 72 for git commits
vim.cmd "autocmd filetype gitcommit set colorcolumn=72"

-- Dirty hack to quickly run python code
vim.cmd "autocmd filetype python nnoremap <F3> :w <bar> :split term://python %<CR> i"

-- Make `Y` yank to the end of the line
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true })

-- Hide line numbers in terminal windows
vim.api.nvim_exec([[
  au BufEnter term://* setlocal nonumber
]], false)

-- Toggle a line at column 80
vim.api.nvim_exec([[
let g:line80=0
function! ToggleLine80()
  if g:line80
    set colorcolumn=0
    let g:line80=0
  else
    set colorcolumn=80
    let g:line80=1
  endif
endfunction
command Line80 :call ToggleLine80()
]], false)

-- Toggle a line at column 72
vim.api.nvim_exec([[
let g:line72=0
function! ToggleLine72()
  if g:line72
    set colorcolumn=0
    let g:line72=0
  else
    set colorcolumn=72
    let g:line72=1
  endif
endfunction
command Line72 :call ToggleLine72()
]], false)


