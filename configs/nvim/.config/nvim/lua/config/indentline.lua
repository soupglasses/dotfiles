require("indent_blankline").setup {
  buftype_exclude = { "terminal", "man", "help", "nofile" },
  filetype_exclude = { "man", "help" },
  bufname_exclude = { "man", "help" },
  -- show_first_indent_level = false,
  show_trailing_blankline_indent = false,
  -- use_treesitter = true, -- Currently broken
}
