local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node

ls.config.set_config({
  history = true,
  updateevents = "TextChanged,TextChangedI",
})

require("luasnip/loaders/from_vscode").lazy_load()
