local status_ok, ibl = pcall(require, "ibl")
if not status_ok then 
	vim.notify("indent-blankline not loaded")
	return 
end
-- vim.cmd[[highlight IndentBlanklineContextChar guifg=#6c6866 gui=nocombine]]

ibl.setup()
--ibl.setup({
--	space_char_blankline = " ",
--    show_current_context = true,
--    show_current_context_start = false,
--	char = "",
--	context_char = "┊",
--	show_trailing_blankline_indent = false,
--	buftype_exclude = { "terminal", "help", "telescope" },
--})
