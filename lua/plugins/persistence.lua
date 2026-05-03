vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }

vim.pack.add({
	"https://github.com/folke/persistence.nvim",
})

require("persistence").setup({})

vim.keymap.set("n", "<leader>s", function()
	require("persistence").load()
end)

vim.api.nvim_create_user_command("SessionSave", require("persistence").save, {})
vim.api.nvim_create_user_command("SessionLoad", require("persistence").load, {})
vim.api.nvim_create_user_command("SessionList", require("persistence").select, {})
