local status_ok, cmp = pcall(require, "cmp")
if not status_ok then 
	vim.notify("nvim-cmp not loaded")
	return 
end

local function border(hl_name)
  return {
    { "┌", hl_name },
    { "─", hl_name },
    { "┐", hl_name },
    { "│", hl_name },
    { "┘", hl_name },
    { "─", hl_name },
    { "└", hl_name },
    { "│", hl_name },
  }
end

local cmp_window = require "cmp.utils.window"

cmp_window.info_ = cmp_window.info
cmp_window.info = function(self)
	local info = self:info_()
	info.scrollable = false
	return info
end

-- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
local intellij_completion = 
	function(fallback)
		if cmp.visible() then
			local entry = cmp.get_selected_entry()
			if not entry then
				cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
			else
				cmp.confirm()
			end
		else
			fallback()
		end
	end

local kind_icons = {
	Text = "",
	Method = "",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "ﴯ",
	Interface = "",
	Module = "",
	Property = "ﰠ",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = ""
}


local format = 
	function(entry, vim_item)
		vim_item.kind = kind_icons[vim_item.kind] or ""
		vim_item.menu = "" 
		return vim_item
	end

local options = {
	view = { entries = {name = 'custom', selection_order = 'near_cursor' } },
	window = {
		completion = {
			border = "none",
		},
		documentation = { border = "none" },
	},
	formatting = {
		fields = { "kind", "abbr" },
		format = format 
	},

	snippet = { expand = function(args) require("luasnip").lsp_expand(args.body) end },
	mapping = {
		['<Tab>'] = cmp.mapping(intellij_completion, {"i","s"}),
		['<S-Tab>'] = cmp.mapping.select_prev_item(),
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-n>'] = cmp.mapping.select_next_item(),
	},
	experimental = {
		ghost_text = { hl_group = 'SpecialKey' }
	},
	sources = {
		{ name = "nvim_lsp" },
    	{ name = "path" },
    	{ name = "spell" },
	},
}

cmp.setup(options)

-- plug in 'autopairs' to automatically add parenthesis for function/methods completions
cmp.event:on('confirm_done', require('nvim-autopairs.completion.cmp').on_confirm_done())
