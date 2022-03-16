-- Fix for https://github.com/kovidgoyal/kitty/issues/4234
vim.cmd [[
  if $TERM == "xterm-kitty"
    try
      " undercurl support
      let &t_Cs = "\e[4:3m"
      let &t_Ce = "\e[4:0m"
    catch
    endtry
    " Change the cursor in different modes
    let &t_SI = "\e[5 q"
    let &t_SR = "\e[3 q"
    let &t_EI = "\e[1 q"
    " vim hardcodes background color erase even if the terminfo file does
    " not contain bce. This causes incorrect background rendering when
    " using a color theme with a background color.
    let &t_ut=''
  endif
]]

-- HACK: workaround for https://github.com/lukas-reineke/indent-blankline.nvim/issues/59
vim.wo.colorcolumn = "99999"

-- Make neovim recognize Vagrantfiles
vim.cmd [[
augroup filetypedetect
  au BufRead,BufNewFile Vagrantfile setfiletype ruby
augroup END
]]

-- Set column to 72 for git commits
vim.cmd "autocmd filetype gitcommit set colorcolumn=72"

-- Dirty hack to quickly run python code
vim.cmd "autocmd filetype python nnoremap <F3> :w <bar> :split term://python %<CR> i"

-- Hide line numbers in terminal windows
vim.api.nvim_exec([[
  au BufEnter term://* setlocal nonumber
]], false)

-- Toggle a line at column 80
vim.api.nvim_exec([[
let g:line80=0
function! ToggleLine80()
  if g:line80
    set colorcolumn=0
    let g:line80=0
  else
    set colorcolumn=80
    let g:line80=1
  endif
endfunction
command Line80 :call ToggleLine80()
]], false)

-- Toggle a line at column 72
vim.api.nvim_exec([[
let g:line72=0
function! ToggleLine72()
  if g:line72
    set colorcolumn=0
    let g:line72=0
  else
    set colorcolumn=72
    let g:line72=1
  endif
endfunction
command Line72 :call ToggleLine72()
]], false)
