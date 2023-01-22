local M = {}

-- TODO: This is broken if cmp_nvim_lsp does not exist
-- Comes from the fact that the returned `M` does not exist.
local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not ok then
	return
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

M.setup = function()
	vim.diagnostic.config({
		virtual_text = true, -- disable virtual text
		update_in_insert = false,
		underline = true,
		severity_sort = true,
	})
end

local function lsp_keymaps(bufnr)
	local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename,          '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action,     '[C]ode [A]ction')
  nmap('gd',         vim.lsp.buf.definition,      '[G]oto [D]efinition')
  nmap('gD',         vim.lsp.buf.declaration,     '[G]oto [D]eclaration')
	nmap('gr',         vim.lsp.buf.references,      '[G]oto [R]eferences')
  nmap('gI',         vim.lsp.buf.implementation,  '[G]oto [I]mplementation')
  nmap('<leader>D',  vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('K',          vim.lsp.buf.hover,           'Hover Documentation')
  nmap('<C-k>',      vim.lsp.buf.signature_help,  'Signature Documentation')

  -- nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  -- nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  -- nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

	nmap("<leader>e", vim.diagnostic.open_float)
	nmap("<leader>q", vim.diagnostic.setloclist)
	nmap("<leader>lj", vim.diagnostic.goto_next)
	nmap("<leader>lk", vim.diagnostic.goto_prev)

  -- Create `:Format` for the local buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

M.on_attach = function(client, bufnr)
	if client.name == "tsserver" then
		client.server_capabilities.documentFormattingProvider = false
	end

	if client.name == "sumneko_lua" then
		client.server_capabilities.documentFormattingProvider = false
	end

	lsp_keymaps(bufnr)

	--local status_ok, illuminate = pcall(require, 'illuminate')
	--if not status_ok then
	--  return
	--end
	--illuminate.on_attach(client)
end

return M
