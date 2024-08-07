local status_ok, kg = pcall(require, "kanagawa")
if not status_ok then 
	vim.notify("kanagawa not loaded")
	return 
end

kg.setup({
	commentStyle = { italic = false },
    keywordStyle = { italic = false },
	theme = "wave",
	background = {               -- map the value of 'background' option to a theme
        dark = "wave",           -- try "dragon" !
        light = "lotus"
    },
})

vim.cmd[[colorscheme kanagawa]]
