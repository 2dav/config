local plugins = {
	-- optimizer
	["lewis6991/impatient.nvim"] = {},
	-- plugin manager
	["wbthomason/packer.nvim"] = {},

	--																			[Vim Enchancements]
	-- lua functions
	["nvim-lua/plenary.nvim"] = { module = "plenary" },

	-- popup API
	["nvim-lua/popup.nvim"] = {},

	-- enchanced easymotion+sneak
	["ggandor/leap.nvim"] = {
		config = function() require('leap').add_default_mappings() end,
	},

	-- fuzzy finder
	["junegunn/fzf"] = { dir = "/usr/share/fzf" },
	["junegunn/fzf.vim"] = {
		after = "fzf",
		config = function() require("plugins.configs.fzf") end,
	},

	-- auto insert pairing parenthesis, works with nvim-cmp too
	["windwp/nvim-autopairs"] = { config = function() require("nvim-autopairs").setup() end },

	-- toggle comments
	["terrortylor/nvim-comment"] = {
		config = function() require("nvim_comment").setup({
			comment_empty = false,
			marker_padding = false,
			create_mappings = false,
		}) end,
	},

	--																			[GUI]
	-- base16 color schemes
	["RRethy/nvim-base16"] = { 
		after = "nvim-treesitter",
		config = function() require("plugins.configs.themes.base16") end 
	},
	
	-- tokyonight theme
	--["folke/tokyonight.nvim"] = {
	-- 	after = "nvim-treesitter",
	--	config = function() require("plugins.configs.themes.tokyonight") end 
	--},
	-- kanagawa theme
	-- ["rebelot/kanagawa.nvim"] = {
	--  	after = "nvim-treesitter",
	-- 	config = function() require("plugins.configs.themes.kanagawa") end 
	-- },

	-- gruvbox-material theme
	--["sainnhe/gruvbox-material"] = {
	-- 	after = "nvim-treesitter",
	--	config = function() require("plugins.configs.themes.gruvbox_material") end 
	--},

	-- statusline
	["nvim-lualine/lualine.nvim"] = {
		requires = { {"arkav/lualine-lsp-progress"} },
		after = "nvim-base16",
		-- after = "tokyonight.nvim",
		-- after = "kanagawa.nvim",
		-- after = "gruvbox-material",
		config = function() require ("plugins.configs.lualine") end,
	},

	-- syntax highlighting
	["nvim-treesitter/nvim-treesitter"] = {
		setup = function () require("utils.lazy_load").on_file_open "nvim-treesitter" end,
		cmd = require("utils.lazy_load").treesitter_cmds,
		run = ":TSUpdate",
		config = function() require("plugins.configs.treesitter") end,
	},

	--																			[Dev]
	-- LSP supports 
	["neovim/nvim-lspconfig"] = {
		opt = true,
		setup = function() require("utils.lazy_load").on_file_open "nvim-lspconfig" end,
		config = function() require("plugins.configs.lsp") end,
	},

	-- show function signature from LSP
	["ray-x/lsp_signature.nvim"] = {
		opt = true,
		after = "nvim-lspconfig",
	},

	-- Completion framework
	["hrsh7th/nvim-cmp"] = { 
		after = "nvim-lspconfig",
		config = function() require("plugins.configs.cmp") end },
	["hrsh7th/cmp-nvim-lsp"] = { after = "nvim-cmp" },
	["hrsh7th/cmp-buffer"] = { after = "cmp-nvim-lsp" },
	["hrsh7th/cmp-path"] = { after = "cmp-buffer" },
	["f3fora/cmp-spell"] = { after = "cmp-path" },
	["L3MON4D3/LuaSnip"] = { after = "nvim-cmp" },

	-- handy 'Cargo.toml' utils
	["Saecki/crates.nvim"] = {
		after = "nvim-cmp",
		event = { "BufRead Cargo.toml" },
		requires = { "nvim-lua/plenary.nvim" },
		config = function() require("crates").setup() end,
	},

	-- 'cd' to project root on open
	["notjedi/nvim-rooter.lua"] = {
		setup = function() require("utils.lazy_load").on_file_open "nvim-rooter.lua" end,
		config = function() require("plugins.configs.rooter") end,
	},

	--																			[Languages]
	-- Rust
	["simrat39/rust-tools.nvim"] = {
		after = "nvim-lspconfig",
		config = function() require("plugins.configs.rusttools") end,
	},
	["rust-lang/rust.vim"] = {},
	
	-- Zig
	["ziglang/zig.vim"] = {
		after = "cmp-nvim-lsp",
		config = function() require("plugins.configs.zls") end,
	},

	--																			[Syntactic langs]
	["iamcco/markdown-preview.nvim"] = {
		run = "cd app && npm install", 
		setup = function() vim.g.mkdp_filetypes = { "markdown" } end, 
		ft = { "markdown" },
	}
}

local fn = vim.fn

-- automatically install packer
local package_path = fn.stdpath "config" .. "/pack"
local install_path = package_path .. "/packer/start/packer.nvim"
vim.notify(install_path)
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system {
		"git",
  		"clone",
  		"--depth",
  		"1",
  		"https://github.com/wbthomason/packer.nvim",
  		install_path,
  	}
  	print "Installing packer, close and reopen Neovim..."
  	vim.cmd [[packadd packer.nvim]]
end

-- use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	vim.notify("require(packer) fail")
	return
end

-- have packer use a popup window
packer.init {
	auto_clean = true,
	compile_on_sync = true,
	package_root  = package_path,
	display = {
		working_sym = "ﲊ",
    	error_sym = "✗ ",
    	done_sym = " ",
    	removed_sym = " ",
    	moved_sym = "",
		open_fn = function()
			return require("packer.util").float { border = "single" }
		end,
	},
	git = {
		clone_timeout = 5000,
		subcommands = { update = "pull --rebase" },
	},
}

-- install plugins 
packer.startup(function(use)
	for key, plugin in pairs(plugins) do
		if type(key) == "string" and not plugin[1] then plugin[1] = key end
		use(plugin)
	end
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
