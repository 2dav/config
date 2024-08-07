local present, rooter = pcall(require, "nvim-rooter")
if not present then
	vim.notify("nvim-rooter.lua not loaded")
	return
end

local opts = {
	rooter_patterns = { '.git', '.hg', '.svn', 'Cargo.toml', 'Makefile', 'build.zig', '.vcxproj' },
	trigger_patterns = { '*' },
	manual = false,
}

rooter.setup(opts)

