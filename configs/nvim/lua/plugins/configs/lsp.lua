local status_ok, lsp = pcall(require, "lspconfig")
if not status_ok then 
	vim.notify("lspconfig not loaded")
	return 
end

lsp.pyright.setup {}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
 
lsp.html.setup {
	capabilities = capabilities,
}
lsp.cssls.setup {
	capabilities = capabilities,
}
lsp.jsonls.setup {
	capabilities = capabilities,
}
lsp.emmet_language_server.setup {
	filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "pug", "typescriptreact" },
    capabilities = capabilities,
}

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
	local buf = ev.buf

	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(buf, ...) end
	local function buf_set_option(...) vim.api.nvim_buf_set_option(buf, ...) end

	local opts = { noremap=true, silent=true }

	buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
	buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	buf_set_keymap('n', '<space>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	buf_set_keymap('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
	buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
	buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
	buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts)
	buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.format()<CR>", opts)

	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
	buf_set_option("formatexpr", "v:lua.vim.lsp.formatexpr()")
	buf_set_option("tagfunc", "v:lua.vim.lsp.tagfunc")

  end,
})



-- LSP Diagnostics Options Setup 
local sign = function(opts)
	vim.fn.sign_define(opts.name, {
		texthl = opts.name,
		text = opts.text,
		numhl = ''
	})
end

sign({name = 'DiagnosticSignError', text = '❂'})
sign({name = 'DiagnosticSignWarn', text = '◉'})
sign({name = 'DiagnosticSignHint', text = '●'})
sign({name = 'DiagnosticSignInfo', text = '☀'})

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
        border ="none",
        source = 'always',
        --header = '',
        --prefix = '',
    },
})

