vim.o.completeopt = "menuone,noselect"

local cmp = require("cmp")

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), {"i", "c"}),
    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
  },
  sources = {
    { name = "nvim_lua" },
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "luasnip" },
    { name = "buffer", keyword_length = 4 },
    { name = "treesitter" },
    { name = "emoji" },
  },
  formatting = {
    format = require("lspkind").cmp_format({
      with_text = true,
      menu = {
        nvim_lua = "[API]",
        nvim_lsp = "[LSP]",
        path = "[Path]",
        luasnip = "[Snippet]",
        buffer = "[Buffer]",
        treesitter = "[TS]",
        emoji = "[Emoji]",
      },
    }),
  },
})
