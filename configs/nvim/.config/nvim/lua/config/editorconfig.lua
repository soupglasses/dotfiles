vim.g.EditorConfig_exclude_patterns = "['fugitive://.*', 'alpha://.*', 'vista://.*' 'scp://.*']"
vim.cmd [[
  au FileType gitcommit let b:EditorConfig_disable = 1
]]
