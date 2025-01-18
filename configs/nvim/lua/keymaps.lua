local opts = { noremap = true, silent = true }
local silent = { silent = true }
local noremap = { noremap = true }
local keymap = vim.api.nvim_set_keymap

-- <space> as a leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--																		[Editor]
-- quit with ctrl+q
keymap("n", "<C-q>", ":confirm qall<CR>", noremap)

-- suspend with ctrl+f
-- ctrl+z is enabled by default
keymap("n", "<C-f>", ":sus<cr>", noremap)

-- search results centered please
keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)
keymap("n", "*", "*zz", opts)
keymap("n", "#", "#zz", opts)
keymap("n", "g*", "g*zz", opts)

-- jump to the end of the pasted text
keymap("v", "y", "y`]", opts)
keymap("v", "p", "p`]", opts)
keymap("n", "p", "p`]", opts)

-- very magic by default
keymap("n", "?", "?\\v", noremap)
keymap("n", "/", "/\\v", noremap)
keymap("c", "%s/", "%sm/", noremap)

--																		[Navigation & Panes]
-- hump to start/end of the line using the home row keys
keymap("", "H", "^", {})
keymap("", "L", "$", {})

-- <leader><leader> toggles between buffers
keymap("n", "<leader><leader>", "<c-^>", noremap)

-- <leader>fe to open file explorer(netrw)
keymap("n", "<leader>fe", ":Lexp 15<cr>", opts)

-- resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

--																		[Editing]
-- ctrl+h to stop searching
keymap("n", "<C-h>", ":nohlsearch<cr>", noremap)

-- quick save
keymap("n", "<leader>w", ":w<cr>", {})

-- move text up and down
-- TODO: doesn't work, but should
keymap("n", "<A-j>", ":m .+1<cr>==", opts)
keymap("n", "<A-k>", ":m .-2<cr>==", opts)
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

--keymap("v", "<A-j>", ":m .+1<cr>==", opts)
--keymap("v", "<A-k>", ":m .-2<cr>==", opts)
keymap("x", "<A-j>", ":move '>+2<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- don't override yank buffer with replaced text when pasting in visual
keymap("v", "p", '"_dP', opts)

-- toggle comments on <C-/> for visual and normal mode
keymap("n", "", "<Cmd>set operatorfunc=CommentOperator<CR>g@l", noremap)
keymap("v", "", ":<C-u>call CommentOperator(visualmode())<CR>", noremap)
