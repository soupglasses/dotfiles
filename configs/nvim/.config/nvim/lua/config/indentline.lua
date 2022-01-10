require("indent_blankline").setup {
  buftype_exclude = { "terminal", "man", "help", "nofile" },
  filetype_exclude = { "man", "help" },
  bufname_exclude = { "man", "help" },
  show_trailing_blankline_indent = false,
  use_treesitter = "v:true",
}
