-- :help options
local options = {
--	[ Editor ]
	backup = false,				-- don't create backup files
	swapfile = false,			-- don't create swap file
	writebackup = false,		-- disable simultaneous editing 
	undofile = true,			-- permanent undo
	-- default encoding
	fileencoding = "utf-8",		
	encoding = "utf-8",
	syntax = "on",				-- enable custom syntax rules
	--[[ neat X clipboard integration
	,p will paste clipboard into buffer
	,c will copy selection into clipboard
	or just use system clipboard to 'y from vim and 'p into
	--]]
	clipboard = "unnamedplus",		
	signcolumn = "yes",			-- Prevent buffer moving when adding/deleting sign
	-- http://stackoverflow.com/questions/2158516/delay-before-o-opens-a-new-line
	timeoutlen = 300,
	updatetime = 300,			-- better experience for diagnostic messages
	inccommand = "split",
	-- proper search
	ignorecase = true,
	incsearch = true,
	smartcase = true,
	gdefault = true,
	-- sane splits
	splitright = true,
	splitbelow = true,
	wrap = false,				-- don't wrap long lines
	-- wide tabs
	shiftwidth = 4,
	softtabstop = 4,
	tabstop = 4,
	expandtab = false,
	smartcase = true,			-- smartcase
	smartindent = true,			-- smartident
	-- minimal number of screen lines to keep around the cursor
	scrolloff = 2,
	sidescrolloff = 2,
	--[[ wrapping options 
		"tc" wrap text and comments using textwidth
		"r" continue comments when pressing ENTER in I mode                                                 
		"q" enable formatting of comments with gq
		"n" detect lists for formatting
		"b" auto-wrap in insert mode, and do not wrap old long lines--]]
	formatoptions = "tcrqnb", 
	-- settings needed for .lvimrc
	exrc = true,
	secure = true,
	-- Treesitter folding 
	foldmethod = 'syntax',
	foldexpr = 'nvim_treesitter#foldexpr()',

--	[ GUI ] 
	mouse = "a",						-- enable mouse usage(all modes) in terminal
	showmode = false,					-- hide mode name from status line
	colorcolumn = "100",				
	-- line numbers
	relativenumber = true,				
	number = true,
	showcmd = true,						-- show partial command in status line
	showtabline = 0,					-- hide tabs
	-- current line
	cursorline = true,					-- highlight current line
	cursorlineopt = "number",			-- highlight only current line number
	cmdheight = 2,						-- more space in the neovim command line for messages	
	--[[ Completion
	     - menuone:  popup even when there's only one match
	     - noinsert: do not insert text until a selection is made
	     - noselect: do not select, force user to select one from the menu --]]
	completeopt = {"menuone", "noselect", "noinsert"},
	conceallevel = 0,					-- so that `` is visible in markdown files
	backspace = "indent,eol,start",		-- backspace over newlines
	-- https://github.com/vim/vim/issues/1735#issuecomment-383353563
	ttyfast = true,
	lazyredraw = true,
	synmaxcol = 200,
	-- spelling completions
	spell = true,
	spelllang = { 'en_us' },
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd('set nofoldenable')

-- netrw configuration
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netw_browse_split = 4
-- vim.g.netw_altw = 1
vim.g.netrw_winsize = 15
vim.cmd "let s:treedepthstring = '│ ' "

-- don't give |ins-completion-menu| messages
vim.opt.shortmess:append "c"

vim.cmd "filetype plugin indent on"

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
vim.opt.whichwrap:append "<>[]hl"

-- disable some builtin vim plugins, ~4% startup speedup
local default_plugins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "matchit",
  "tar",
  "tarPlugin",
  "rrhelper",
  "spellfile_plugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
  "tutor",
  "rplugin",
  "syntax",
  "synmenu",
  "optwin",
  "compiler",
  "bugreport",
  "ftplugin",
}

for _, plugin in pairs(default_plugins) do
  vim.g["loaded_" .. plugin] = 1
end

