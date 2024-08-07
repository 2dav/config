vim.cmd[[
" Important!!
if has('termguicolors')
	set termguicolors
endif

" For dark version.
set background=dark
let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_better_performance = 1

" don't use "italic" style for comments
let g:gruvbox_material_disable_italic_comment = 1
let g:gruvbox_material_enable_italic = 0

colorscheme gruvbox-material
]]

---- brighter comments
--vim.api.nvim_set_hl(0, 'Comment', { fg = scheme.base09 })
---- highlight current param in signature
--vim.api.nvim_set_hl(0, 'LspSignatureActiveParameter', { fg = scheme.base05, bg = scheme.base03, bold = true })
---- brighter current line number on numbers column
---- vim.api.nvim_set_hl(0, 'CursorLineNr', { bg = "#252525" })
--
---- lighter sign/number column to contrast with the bg
--vim.api.nvim_set_hl(0, 'SignColumn', { bg = scheme.base01 })
--vim.api.nvim_set_hl(0, 'LineNr', { bg = scheme.base01, fg = scheme.base03 })
--
---- lighter floating windows bg
--vim.api.nvim_set_hl(0, 'NormalFloat', { bg = scheme.base01 })
--
---- Diagnostics hint badge on the number line
--vim.api.nvim_set_hl(0, 'DiagnosticSignHint', { fg = scheme.base0C, bg = scheme.base01 })
--vim.api.nvim_set_hl(0, 'DiagnosticSignWarn', { fg = scheme.base0E, bg = scheme.base01 })
--vim.api.nvim_set_hl(0, 'DiagnosticSignError', { fg = scheme.base08, bg = scheme.base01 })
---- vim.api.nvim_set_hl(0, 'DiagnosticSignInfo', { fg = scheme.base08, bg = scheme.base01 })
--
---- rust-lang `unsafe` keyword highlighting
--vim.api.nvim_set_hl(0, 'rustUnsafe', { fg = scheme.base08 })
--
--vim.api.nvim_set_hl(0, 'Identifier', { fg = scheme.base05 })
--
--vim.cmd [[
--highlight link rustAsync Keyword
--highlight link rustAwait Keyword
--]]
