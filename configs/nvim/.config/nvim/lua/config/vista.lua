vim.g.vista_icon_indent = '["▸ ", ""]'
vim.g.vista_default_executive = 'ctags'
vim.g.vista_sidebar_width = 40
--vim.g.vista_stay_on_open = false
vim.g.vista_blink = {2, 300}

vim.cmd [[let g:vista#renderer#enable_icon = 0]]

-- If we exit the last buffer, auto-close vista.
vim.cmd [[autocmd BufEnter * if (winnr("$") == 1 && &filetype == "vista") | q | endif]]
