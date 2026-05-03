vim.pack.add({
	"https://github.com/bchmnn/Comment.nvim",
})

require("Comment").setup({
	padding = true,
	sticky = true,
	ignore = nil,
	toggler = {
		line = "<C-/>",
	},
	opleader = {
		line = "<C-/>",
		block = "<C-.>",
	},
})
