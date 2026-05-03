vim.pack.add({
	{
		src = "https://github.com/nvim-neo-tree/neo-tree.nvim",
		version = vim.version.range("3"),
	},
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/MunifTanjim/nui.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
})

require("neo-tree").setup({
	sources = { "filesystem", "buffers", "git_status", "document_symbols" },
	open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
	filesystem = {
		bind_to_cwd = false,
		follow_current_file = { enabled = true },
		use_libuv_file_watcher = true,
		window = {
			mappings = {
				["<C-Return>"] = "system_open",
				["<C-o>"] = "xdg_open_with",
			},
		},
	},
	commands = {
		system_open = function(state)
			local node = state.tree:get_node()
			if node then
				local path = node:get_id()
				vim.fn.jobstart({ "xdg-open", path }, { detach = true })
			end
		end,
		xdg_open_with = function(state)
			local node = state.tree:get_node()
			if node then
				local path = node:get_id()
				vim.fn.jobstart({ "gtk-open-with", path }, { detach = true })
			end
		end,
	},
	default_component_configs = {
		indent = {
			with_expanders = true,
			expander_collapsed = "",
			expander_expanded = "",
			expander_highlight = "NeoTreeExpander",
		},
	},
})

vim.keymap.set("n", "<leader>e", function()
	require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
end)
