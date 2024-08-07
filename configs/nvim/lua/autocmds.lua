local cmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- autocommand that reloads neovim whenever you save the plugins/init.lua
vim.cmd [[
	augroup packer_user_config
		autocmd!
		autocmd BufWritePost */plugins/init.lua source <afile> | PackerSync
	augroup end
]]

-- prevent accidental writes to buffers that shouldn't be edited
cmd("BufRead", {
	pattern = "*.orig",
	command = "set readonly"
})
cmd("BufRead", {
	pattern = "*.pacnew",
	command = "set readonly"
})

-- leave paste mode when leaving insert mode
cmd("InsertLeave", {
	pattern = "*",
	command = "set nopaste"
})

-- jump to last edit position when opening a file
vim.cmd[[ au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]]

-- highlight on yank
cmd('TextYankPost', {
	pattern = '*',
	group = augroup('YankHighlight', { clear = true }),
	callback = function() vim.highlight.on_yank({timeout = 600}) end,
})

-- don't list quickfix buffers
cmd("FileType", {
	pattern = "qf",
	callback = function() vim.opt_local.buflisted = false end,
})

-- disable statusline in dashboard
cmd("FileType", {
	pattern = "alpha",
	callback = function() vim.opt.laststatus = 0 end,
})
cmd("BufUnload", {
	buffer = 0,
	callback = function() vim.opt.laststatus = 3 end,
})

-- don't fold on open
cmd("BufReadPost", {
	pattern = "*", 
	command = "normal zR"
})
cmd("FileReadPost", {
	pattern = "*", 
	command = "normal zR"
})

-- format on save for rust code
cmd("BufWritePre", {
	pattern ="*.rs",
	callback = function() vim.lsp.buf.format(nil, 200) end,
})

-- don't show netrw on startup
vim.cmd [[
	augroup goodbye_netrw
	  au!
	  autocmd VimEnter * silent! au! FileExplorer *
	augroup END
]]

