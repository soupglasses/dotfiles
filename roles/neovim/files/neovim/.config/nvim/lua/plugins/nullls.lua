return {
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources, {
        nls.builtins.formatting.shfmt.with({
          extra_args = { "-i", "2" }, -- -bn (binary ops on next line), -ci (indent switch cases)
        }),
      })
    end,
  },
}
