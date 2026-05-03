vim.pack.add({
	"https://github.com/Mofiqul/vscode.nvim",
})

require("vscode").setup({
	italic_comments = true,
	underline_links = true,
})

vim.opt.background = "light"
vim.cmd.colorscheme("vscode")
