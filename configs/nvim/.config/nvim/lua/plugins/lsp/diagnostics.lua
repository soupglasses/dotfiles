vim.lsp.handlers["textDocument"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  severity_sort = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  virtual_text = { spacing = 4, prefix = "●" },
})
