local status_ok, tsc = pcall(require, "nvim-treesitter.configs")
local parser_config_ok, pc = pcall(require, "nvim-treesitter.parsers")
if not status_ok then 
	vim.notify("nvim-treesitter not loaded")
	return 
end

if not parser_config_ok then 
	vim.notify("nvim-treesitter.parser not loaded")
	return 
end


pc.get_parser_configs().mql5 = {
	install_info = {
		url = "/home/zood/Documents/Projects/other/repo/tree-sitter-mql5",
    	files = {"src/parser.c"},
    	generate_requires_npm = false,
    	requires_generate_from_grammar = true, -- if folder contains pre-generated src/parser.c
	},
	-- filetype = "mqh",
}

tsc.setup({
	ensure_installed = { 
		"lua", "toml", "c", "cpp", "python", "zig",
		"markdown", "html", "css", "javascript", 
		"fish", "bash", "yaml"
	},
	auto_install = true,
  	highlight = {
  	  enable = true,
	  disable = { "rust" },
  	  additional_vim_regex_highlighting = true,
  	},
	-- matchup = { 
	-- 	enable = true,
	-- 	include_match_words = true,
	-- },
})

