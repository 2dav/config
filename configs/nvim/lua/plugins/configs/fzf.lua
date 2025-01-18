local status_ok, fzf = pcall(require, "fzf-lua")
if not status_ok then 
	vim.notify("fzf-lua not loaded")
	return 
end

--vim.cmd[[
--set grepprg=rg\ --no-heading\ --vimgrep
--set grepformat=%f:%l:%c:%m
--
--let g:fzf_layout = { 'down': '~25%' }
--command! -bang -nargs=* Rg
--  \ call fzf#vim#grep(
--  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
--  \   <bang>0 ? fzf#vim#with_preview('up:60%')
--  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
--  \   <bang>0)
--
--function! s:list_cmd()
--  let base = fnamemodify(expand('%'), ':h:.:S')
--  return base == '.' ? 'fd --type file --follow' : printf('fd --type file --follow | proximity-sort %s', shellescape(expand('%')))
--endfunction
--
--command! -bang -nargs=? -complete=dir Files
--  \ call fzf#vim#files(<q-args>, {'source': s:list_cmd(),
--  \                               'options': '--tiebreak=index'}, <bang>0)
--]]

-- <C-p> to fzf over files 
-- keymap("", "<C-p>", ":Files<cr>", {})
-- <leader>; for fzf over buffers
-- keymap("n", "<leader>;", ":Buffers<cr>", {})
-- <leader>s for Rg search
-- keymap("n", "<leader>s", ":Rg<cr>", noremap)

fzf.setup({'max-perf'})

vim.keymap.set("n", "<c-P>", fzf.files, { desc = "Fzf Files" })
vim.keymap.set("n", "<leader>;", fzf.buffers, { desc = "Fzf Buffers" })
vim.keymap.set("n", "<leader>s", fzf.grep_project, { desc = "Fzf Rg" })
