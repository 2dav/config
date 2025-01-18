local status_ok, nn = pcall(require, "notebook-navigator")
if not status_ok then 
	vim.notify("NotebookNavigator.nvim not loaded")
	return 
end
local status_ok, mp = pcall(require, "mini.hipatterns")
if not status_ok then 
	vim.notify("mini.hipatterns not loaded")
	return 
end
local status_ok, ma = pcall(require, "mini.ai")
if not status_ok then 
	vim.notify("mini.ai not loaded")
	return 
end

nn.setup({ syntax_highlight = true })
mp.setup({ highlighters = { cells = nn.minihipatterns_spec }})
ma.setup({ custom_textobjects = { h = nn.miniai_spec }})

local opts = { noremap = true, silent = true }
local silent = { silent = true }
local noremap = { noremap = true }
local keymap = vim.api.nvim_set_keymap

vim.keymap.set('n', '<leader>x', function() nn.run_and_move() end, { desc = 'Evaluate cell under cursor' })
vim.keymap.set('n', ']h', function() nn.move_cell("d") end, { desc = 'Move cell down' })
vim.keymap.set('n', '[h', function() nn.move_cell("u") end, { desc = 'Move cell up' })

