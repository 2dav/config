local status_ok, base16 = pcall(require, "base16-colorscheme")
if not status_ok then 
	vim.notify("base16.nvim not loaded")
	return 
end

-- show all highlight groups
-- :so $VIMRUNTIME/syntax/hitest.vim

base16.setup()

vim.cmd [[ colorscheme base16-gruvbox-dark-hard ]]

scheme = base16.colors

-- brighter comments
vim.api.nvim_set_hl(0, 'Comment', { fg = scheme.base09 })

-- highlight current param in signature
vim.api.nvim_set_hl(0, 'LspSignatureActiveParameter', { fg = scheme.base05, bg = scheme.base03, bold = true })

-- lighter sign/number column to contrast with the bg
vim.api.nvim_set_hl(0, 'SignColumn', { bg = scheme.base01 })
vim.api.nvim_set_hl(0, 'LineNr', { bg = scheme.base01, fg = scheme.base03 })

-- lighter floating windows bg
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = scheme.base01 })

-- Diagnostics hint badge on the number line
vim.api.nvim_set_hl(0, 'DiagnosticSignHint', { fg = scheme.base0C, bg = scheme.base01 })
vim.api.nvim_set_hl(0, 'DiagnosticSignWarn', { fg = scheme.base0E, bg = scheme.base01 })
vim.api.nvim_set_hl(0, 'DiagnosticSignError', { fg = scheme.base08, bg = scheme.base01 })
-- vim.api.nvim_set_hl(0, 'DiagnosticSignInfo', { fg = scheme.base08, bg = scheme.base01 })

-- rust-lang `unsafe` keyword highlighting
vim.api.nvim_set_hl(0, 'rustUnsafe', { fg = scheme.base08 })

vim.api.nvim_set_hl(0, 'Identifier', { fg = scheme.base05 })

vim.cmd [[
	highlight link rustAsync Keyword
	highlight link rustAwait Keyword
]]
