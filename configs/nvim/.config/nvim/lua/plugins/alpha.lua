local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

local function footer()
  local version = vim.version()
  local print_version = "v" .. version.major .. "." .. version.minor .. "." .. version.patch
  local datetime = os.date("%Y/%m/%d %H:%M:%S")

  return print_version .. ' ' .. datetime
end

local banner = {
  [[                           _)            ]],
  [[ __ \    _ \   _ \ \ \   /  |  __ `__ \  ]],
  [[ |   |   __/  (   | \ \ /   |  |   |   | ]],
  [[_|  _| \___| \___/   \_/   _| _|  _|  _| ]],
}

dashboard.section.header.val = banner

dashboard.section.buttons.val = {
  dashboard.button('e', ' New file', ':enew<CR>'),
  dashboard.button('f', ' Find file', ':NvimTreeOpen<CR>'),
  dashboard.button('s', ' Settings', ':e $MYVIMRC<CR>'),
  dashboard.button('u', ' Update plugins', ':PackerUpdate<CR>'),
  dashboard.button('q', ' Quit', ':qa<CR>'),
}

dashboard.section.footer.val = footer()

alpha.setup(dashboard.config)
