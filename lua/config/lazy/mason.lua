return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "j-hui/fidget.nvim",
        'saadparwaiz1/cmp_luasnip',
        'L3MON4D3/LuaSnip',
        'WhoIsSethDaniel/mason-tool-installer.nvim',
    },

    config = function()
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")

        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

        require("fidget").setup({})
        require("mason").setup()

        local options = {
            lua_ls = {
                settings = {
                    Lua = {
                        runtime = {
                            version = "LuaJIT"
                        },
                        diagnostics = {
                            globals = {
                                "vim"
                            }
                        },
                        workspace = {
                            checkThirdParty = false,
                            library = vim.api.nvim_get_runtime_file("", true)
                        },
                        telemetry = {
                            enable = false
                        }
                    }
                }
            },
            clangd = {},
            rust_analyzer = {},
            ts_ls = {},
            gopls = {},
            templ = {},
            ruff = {},
            pyright = {
                settings = {
                    python = {
                        analysis = {
                            autoSearchPaths = true,
                            diagnosticMode = 'workspace',
                            useLibraryCodeForTypes = true,
                        }
                    }
                },
            },
            html = {
                filetypes = { "html", "templ" }
            },
            tailwindcss = {
                filetypes = { "html", "templ", "astro", "javascript", "javascriptreact", "typescript", "typescriptreact", "react" },
                init_options = { userLanguages = { templ = "html" } },
            },
            jsonls = {},
            texlab = {},
            marksman = {},
            phpactor = {},
        }

        local servers = {}
        for name, _ in pairs(options) do
            table.insert(servers, name)
            local opts = options[name]
            opts[capabilities] = capabilities
            require("lspconfig")[name].setup(opts)
        end

        require("mason-lspconfig").setup({
            ensure_installed = servers,
            automatic_installation = true,
            automatic_enable = true,
        })

        require('mason-tool-installer').setup {
            ensure_installed = {
                "yamlfix",
                "black",
                "isort",
                "prettier",
                "prettierd",
                "mdformat",
            },
        }

        local luasnip = require('luasnip')

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'buffer' },
            })
        })

        vim.diagnostic.config({
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = true,
                header = "",
                prefix = "",
            },
        })
    end

}
