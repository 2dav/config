local status_ok, lualine = pcall(require, "lualine")
if not status_ok then 
	vim.notify("lualine not loaded")
	return 
end

local opts = {
	options = {
		icons_enabled = false,
    	component_separators = { left = "•", right = " •" },
    	section_separators = { left = "", right = "" },
    	disabled_filetypes = {},
    	always_divide_middle = false,
    	globalstatus = true,
    	theme = "powerline",
		-- theme = "tokyonight"
		-- theme = "kanagawa",
		-- theme = "gruvbox-material",
	},
	sections = {
		lualine_a = { "mode" },
    	lualine_b = {
			{ 
				"diagnostics",
				sources = { "nvim_diagnostic" },
				symbols = {error = '• ', warn = '• ', info = '• ', hint = '• '},
			}, 
			{ "filename", path = 1, symbols = { modified = "[+]", readonly = " " }}
		},
    	lualine_c = {},
    	lualine_x = { "encoding", "filetype", "branch" },
    	lualine_y = { "progress" },
    	lualine_z = { "location" },
  },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(opts.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
  table.insert(opts.sections.lualine_x, component)
end

ins_left {
	'lsp_progress',
	separators = {
		component = ' ',
		progress = ' | ',
		message = { pre = '', post = ''},
		percentage = { pre = '', post = '%% ' },
		title = { pre = '', post = ': ' },
		lsp_client_name = { pre = '[', post = ']' },
		spinner = { pre = '', post = '' },
	},
	display_components = { 'lsp_client_name', 'spinner', {'title', 'percentage', 'message'} },
	timer = { progress_enddelay = 500, spinner = 1000, lsp_client_name_enddelay = 1000 },
	spinner_symbols = { '🌑 ', '🌒 ', '🌓 ', '🌔 ', '🌕 ', '🌖 ', '🌗 ', '🌘 ' },
}

lualine.setup(opts)
