-- Global Options
vim.o.undofile = true        -- Persistent undo history
vim.o.laststatus = 2         -- Always show the statusline
vim.o.showmode = false       -- Hide the `-- INSERT --` prompt
vim.o.hlsearch = true        -- Highlight all matches
vim.o.incsearch = true       -- Show incremental matches
vim.o.inccommand = 'nosplit' -- Incremental live completion
vim.o.hidden = true          -- Do not save when switching buffers
vim.o.mouse = 'a'            -- Enable mouse mode
vim.o.breakindent = true     -- Allow for cleanly wrapped indentation
vim.o.ignorecase = true      -- By default ignore case on search
vim.o.smartcase = true       -- Make search case sensetive on capital in search
vim.o.updatetime = 300       -- Speed up update times for plugins
vim.o.splitbelow = true      -- Vertical splits below the current window
vim.o.splitright = true      -- Horizontal splits to the right of current window
vim.o.title = true           -- Enable title
vim.o.scrolloff = 7          -- Have 5 lines of padding at top & bottom
vim.o.titlestring = [[%t%( %M%)%( (%{expand("%:~:.:h")})%)%( %a%)]]
vim.o.listchars = "nbsp:_,tab:>-,trail:🞄,extends:>,precedes:<"

-- Window Spessific
vim.wo.number = true     -- Show line numbers
vim.wo.cursorline = true -- Highlight current line
vim.wo.signcolumn='yes'  -- Always show the sign column

-- Buffer Spessific
vim.bo.expandtab = true   -- Convert tabs to spaces
vim.bo.shiftwidth = 4     -- Number of spaces to indicate a tab
vim.bo.tabstop = 4        -- Number of spaces to insert for tab
vim.bo.softtabstop = 4    -- Number of spaces for soft tabs
vim.bo.smartindent = true -- Make indenting smart

-- File Spessific
vim.cmd "autocmd FileType html setlocal ts=2 sw=2 sts=2"
vim.cmd "autocmd FileType lua setlocal ts=2 sw=2 sts=2"
vim.cmd "autocmd FileType nix setlocal ts=2 sw=2 sts=2"

-- Other Options
vim.cmd "set iskeyword+=-"        -- Treat dash-seperated words as whole words
vim.cmd "command Show set list!"  -- Show hidden characters
