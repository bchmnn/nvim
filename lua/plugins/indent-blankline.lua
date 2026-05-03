vim.pack.add({
	"https://github.com/lukas-reineke/indent-blankline.nvim",
})

require("ibl").setup({
	indent = {
		char = "│",
		smart_indent_cap = false,
	},
	whitespace = {
		remove_blankline_trail = false,
	},
	scope = {
		enabled = false,
	},
})

vim.opt.list = true
vim.opt.listchars = {
	tab = "│ ",
	trail = "·",
	lead = "·",
}
