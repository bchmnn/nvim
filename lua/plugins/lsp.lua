require("lib")

vim.pack.add({
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/hrsh7th/cmp-nvim-lsp",
	"https://github.com/hrsh7th/cmp-buffer",
	"https://github.com/hrsh7th/nvim-cmp",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/mfussenegger/nvim-lint",
})

require("mason").setup({})

local servers = {
	bashls = {},
	clangd = {},
	gopls = {},
	html = {
		filetypes = { "html", "templ" },
	},
	jdtls = {},
	jsonls = {},
	lua_ls = {
		settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
				},
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					checkThirdParty = false,
					library = vim.api.nvim_get_runtime_file("", true),
				},
				telemetry = {
					enable = false,
				},
			},
		},
	},
	marksman = {},
	nil_ls = {},
	phpactor = {},
	pyright = {
		settings = {
			python = {
				analysis = {
					autoSearchPaths = true,
					diagnosticMode = "workspace",
					useLibraryCodeForTypes = true,
				},
			},
		},
	},
	rust_analyzer = {},
	tailwindcss = {
		filetypes = {
			"html",
			"templ",
			"astro",
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"react",
		},
		init_options = {
			userLanguages = {
				templ = "html",
			},
		},
	},
	templ = {},
	texlab = {},
	tinymist = {},
	ts_ls = {},
	zls = {},
}

local formatters = {
	css = { "prettier", "prettierd", stop_after_first = true },
	javascript = { "prettier", "prettierd", stop_after_first = true },
	javascriptreact = { "prettier", "prettierd", stop_after_first = true },
	json = { "prettier", "prettierd", stop_after_first = true },
	lua = { "stylua" },
	-- for inline math latex support
	-- needs to install mdformat-myst in $HOME/.local/share/nvim/mason/packages/mdformat/venv
	markdown = { "mdformat" },
	nix = { "alejandra" },
	python = { "isort", "black" },
	sh = { "shfmt" },
	tex = { "tex-fmt" },
	typescript = { "prettier", "prettierd", stop_after_first = true },
	typescriptreact = { "prettier", "prettierd", stop_after_first = true },
	typst = { "typstyle" },
	xml = { "xmlformatter" },
	yaml = { "yamlfix" },
}

local linters = {
	python = {
		-- "pylint",
		"ruff",
		-- "mypy",
	},
	shell = {
		"shellcheck",
		"shellharden",
	},
	javascript = {
		"eslint",
	},
	javascriptreact = {
		"eslint",
	},
	typescript = {
		"eslint",
	},
	typescriptreact = {
		"eslint",
	},
}

local server_names = {}

for name, opts in pairs(servers) do
	table.insert(server_names, name)
	vim.lsp.config[name] = opts
end

local tool_names = utils.flatten_list_values(formatters)
vim.list_extend(tool_names, utils.flatten_list_values(linters))

-- does vim.lsp.enable and bridges nvim-config - mason lsp names
require("mason-lspconfig").setup({
	ensure_installed = server_names,
})

require("mason-tool-installer").setup({
	ensure_installed = tool_names,
})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
		["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	}),

	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "buffer" },
	}),
})

require("conform").setup({
	formatters_by_ft = formatters,
})

vim.keymap.set({ "n", "v", "i" }, "<C-f>", function()
	require("conform").format({
		timeout_ms = 3000,
		lsp_format = "fallback",
	})
end, {})

local lint = require("lint")

lint.linters_by_ft = linters

vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
	callback = function()
		lint.try_lint()
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(e)
		local opts = { buffer = e.buf }
		-- stylua: ignore start
		vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
		vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
		vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
		vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
		vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
		vim.keymap.set("n", "<C-.>", function() vim.lsp.buf.code_action() end, opts)
		vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
		vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
		vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
		vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
		vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
		-- stylua: ignore end
	end,
})
