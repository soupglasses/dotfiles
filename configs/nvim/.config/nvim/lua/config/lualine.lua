local config = {
  options = {
    icons_enabled = false,
    -- Fix for https://github.com/kabouzeid/nvim-lspinstall/issues/39
    disabled_filetypes = {"toggleterm", "terminal"},
    section_separators = "",
    component_separators = "",
    theme = "tokyonight",
  },
}

require("lualine").setup(config)
