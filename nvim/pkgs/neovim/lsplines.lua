require('lsp_lines').setup({})

-- Disable virtual_text since it's redundant.
vim.diagnostic.config({
  virtual_text = false,
})
