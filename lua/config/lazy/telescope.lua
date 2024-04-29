return {
	'nvim-telescope/telescope.nvim',

	tag = '0.1.6',

	dependencies = {
		'nvim-lua/plenary.nvim'
	},

	config = function()
		require('telescope').setup({})
		local builtin = require('telescope.builtin')

		local git_files_with_fallback = function()
			local status, err = pcall(function()
				builtin.git_files({
					prompt_title = "Git Files (<leader>p for Find Files)"
				})
			end)
			if not status then
				builtin.find_files({
					prompt_title = "Find Files (Fallback)"
				})
			end
		end

		vim.keymap.set('n', '<leader>p', builtin.find_files)
		vim.keymap.set('n', '<leader><leader>', git_files_with_fallback)
		vim.keymap.set('n', '<C-p>', git_files_with_fallback)
		vim.keymap.set('n', '<leader>g', builtin.live_grep)

	end
}
