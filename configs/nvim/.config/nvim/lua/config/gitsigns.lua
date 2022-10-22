vim.cmd "command! Blame Gitsigns toggle_current_line_blame"

require("gitsigns").setup {

  signcolumn = true,
  numhl = false,
  linehl = false,
  word_diff = false,
  current_line_blame = false,

  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '+', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '!', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },

  keymaps = {
    -- Default keymap options
    noremap = true,

    ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'"},
    ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'"},

    ['n <leader>gs'] = '<cmd>Gitsigns stage_hunk<CR>',
    ['v <leader>gs'] = ':Gitsigns stage_hunk<CR>',
    ['n <leader>gu'] = '<cmd>Gitsigns undo_stage_hunk<CR>',
    ['n <leader>gr'] = '<cmd>Gitsigns reset_hunk<CR>',
    ['v <leader>gr'] = ':Gitsigns reset_hunk<CR>',
    ['n <leader>gR'] = '<cmd>Gitsigns reset_buffer<CR>',
    ['n <leader>gp'] = '<cmd>Gitsigns preview_hunk<CR>',
    ['n <leader>gb'] = '<cmd>lua require"gitsigns".blame_line{full=true}<CR>',
    ['n <leader>gS'] = '<cmd>Gitsigns stage_buffer<CR>',
    ['n <leader>gU'] = '<cmd>Gitsigns reset_buffer_index<CR>',

    -- Text objects
    ['o ih'] = ':<C-U>Gitsigns select_hunk<CR>',
    ['x ih'] = ':<C-U>Gitsigns select_hunk<CR>'
  },
}
