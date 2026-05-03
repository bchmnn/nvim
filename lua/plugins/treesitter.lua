vim.pack.add({
	"https://github.com/nvim-treesitter/nvim-treesitter",
})

require("nvim-treesitter").install({
	"c",
	"go",
	"html",
	"javascript",
	"latex",
	"lua",
	"markdown",
	"markdown_inline",
	"nix",
	"python",
	"query",
	"rust",
	"templ",
	"typescript",
	"vim",
	"vimdoc",
})

vim.filetype.add({
	extension = {
		y = "lex",
		templ = "templ",
	},
})

vim.treesitter.language.register("python", "sage")

vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"c",
		"go",
		"html",
		"javascript",
		"javascriptreact",
		"latex",
		"lua",
		"markdown",
		"nix",
		"python",
		"rust",
		"templ",
		"typescript",
		"typescriptreact",
	},
	callback = function(ev)
		vim.schedule(function() end)
		vim.treesitter.start(ev.buf)
	end,
})
