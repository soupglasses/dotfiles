local config = {
  options = {
    -- Fix for https://github.com/kabouzeid/nvim-lspinstall/issues/39
    disabled_filetypes = {"toggleterm", "terminal"},
    section_separators = "",
    component_separators = "",
    theme = "tokyonight",
  },
}

-- Attempt to load a matching lualine theme
local name = vim.g.colors_name or ""
local ok, _ = pcall(require, "lualine.themes." .. name)
if ok then
  config.options.theme = name
end
require("lualine").setup(config)
