-- Load plugins
require "plugins"

-- Load basics
require "config.treesitter"

-- Load LSPs
require "config.lsp"
require "config.lsp.snippets"
require "config.lsp.completions"

-- Load theme based
require "config.tokyonight"
require "config.lualine"
require "config.indentline"

-- Load extra features
require "config.alpha"
require "config.gitsigns"
require "config.editorconfig"
require "config.vista"

-- Load preferences
require "settings"
require "keybinds"
require "extras"
