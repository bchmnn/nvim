return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "j-hui/fidget.nvim",
        'saadparwaiz1/cmp_luasnip',
        'L3MON4D3/LuaSnip',
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

        local servers = {
            lua_ls = {
                capabilities = capabilities,
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
            nixd = {
                capabilities = capabilities,
            },
            clangd = {
                capabilities = capabilities,
            },
            rust_analyzer = {
                capabilities = capabilities,
            },
            tsserver = {
                capabilities = capabilities,
            },
            gopls = {
                capabilities = capabilities,
            },
            templ = {
                capabilities = capabilities,
            },
            ruff = { -- python
                capabilities = capabilities,
            },
            pyright = {
                capabilities = capabilities,
                settings = {
                    python = {
                        autoSearchPaths = true,
                        diagnosticMode = "openFilesOnly",
                        useLibraryCodeForTypes = true
                    }
                },
            },
            html = {
                capabilities = capabilities,
                filetypes = { "html", "templ" }
            },
            tailwindcss = {
                capabilities = capabilities,
                filetypes = { "templ", "astro", "javascript", "typescript", "react" },
                init_options = { userLanguages = { templ = "html" } },
            },
            jsonls = {
                capabilities = capabilities,
            },
        }

        for server_name, opts in pairs(servers) do
            require('lspconfig')[server_name].setup(opts)
        end

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
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}
