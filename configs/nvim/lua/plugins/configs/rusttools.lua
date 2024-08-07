local status_ok, rt = pcall(require, "rust-tools")
if not status_ok then 
	vim.notify("rust-tools.nvim not loaded")
	return 
end

local on_attach = function(client, buf)
	client.server_capabilities.semanticTokensProvider = nil

	-- Get signatures (and _only_ signatures) when in argument lists.
	require("lsp_signature").on_attach({
		doc_lines = 0,
		handler_opts = { border = "none" },
    })

	-- separate highlight group for unsafe keyword, are there any better way? 
	vim.cmd[[syn keyword rustUnsafe unsafe]]
	vim.cmd[[syn keyword rustAsync async]]
	vim.cmd[[syn keyword rustAwait await]]
end

-- rt.config.options.server.capabilities.textDocument.semanticTokens = vim.NIL
-- rt.config.options.server.capabilities.workspace.semanticTokens = vim.NIL

capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem = {
	documentationFormat = { "markdown", "plaintext" },
	snippetSupport = false,
	preselectSupport = true,
	insertReplaceSupport = true,
	labelDetailsSupport = true,
	deprecatedSupport = true,
	commitCharactersSupport = true,
	tagSupport = { valueSet = { 1 } },
	resolveSupport = {
		properties = {
			"documentation",
	   		"detail",
	   		"additionalTextEdits",
		},
	},
}

local opts = {
	tools = { -- rust-tools options
		reload_workspace_from_cargo_toml = true,
    	inlay_hints = {
			only_current_line = false,
			show_parameter_hints = false,

			-- prefix for parameter hints
			parameter_hints_prefix = "",

			-- prefix for all the other hints (type, chaining)
			other_hints_prefix = "",

			-- The color of the hints
			highlight = "SpecialKey",
    	},
    	-- options same as lsp hover / vim.lsp.util.open_floating_preview()
    	hover_actions = {
			-- the border that is used for the hover window
    	  	-- see vim.api.nvim_open_win()
    	  	border = {
    	  	  { "╭", "FloatBorder" },
    	  	  { "─", "FloatBorder" },
    	  	  { "╮", "FloatBorder" },
    	  	  { "│", "FloatBorder" },
    	  	  { "╯", "FloatBorder" },
    	  	  { "─", "FloatBorder" },
    	  	  { "╰", "FloatBorder" },
    	  	  { "│", "FloatBorder" },
			},
    	},
	},

	-- all the opts to send to nvim-lspconfig
	-- these override the defaults set by rust-tools.nvim
	-- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
	server = {
		on_attach = on_attach,
		capabilities = capabilities,
        ["rust-analyzer"] = {
            checkOnSave = { command = "clippy" },
        }
	},
}

rt.setup(opts)
