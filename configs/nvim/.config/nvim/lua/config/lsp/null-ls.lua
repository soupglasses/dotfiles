local M = {}

local formattable_types = { "text", "sh", "zsh", "bash", "json", "yaml", "markdown", "conf", "python" }

function M.setup(options)
  local nls = require("null-ls")
  nls.setup {
    debounce = 150,
    save_after_format = false,
    sources = {
      nls.builtins.formatting.trim_whitespace.with {
        filetypes = formattable_types,
      },
      nls.builtins.formatting.trim_newlines.with {
        filetypes = formattable_types,
      },
      nls.builtins.formatting.isort,
      nls.builtins.diagnostics.pylint,
    },
    on_attach = options.on_attach,
    capabilities = options.capabilities,
  }
end

function M.has_formatter(ft)
  local sources = require("null-ls.sources")
  local available = sources.get_available(ft, "NULL_LS_FORMATTING")
  return #available > 0
end

return M
