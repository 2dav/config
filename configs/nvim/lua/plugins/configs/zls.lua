local status_ok, lsp = pcall(require, "lspconfig")
if not status_ok then 
	vim.notify("zls not loaded")
	return 
end

local status_ok, cmp = pcall(require, "cmp_nvim_lsp")
if not status_ok then 
	vim.notify("zls:cmp_nvim_lsp not loaded")
	return 
end

capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = cmp.default_capabilities(capabilities)

lsp.zls.setup({ capabilities = capabilities })
