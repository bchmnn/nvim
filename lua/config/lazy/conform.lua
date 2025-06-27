return {
    'stevearc/conform.nvim',
    keys = {
        {
            "<C-f>",
            function()
                require("conform").format({
                    timeout_ms = 3000,
                    lsp_format = "fallback",
                })
            end,
            mode = { "n", "v" },
            desc = "Format Injected Langs",
        },
    },
    opts = {
        formatters_by_ft = {
            yaml = { "yamlfix" },
            python = { "isort", "black" },
            json = { "prettier", "prettierd", stop_after_first = true },
            css = { "prettier", "prettierd", stop_after_first = true },
            javascript = { "prettier", "prettierd", stop_after_first = true },
            typescript = { "prettier", "prettierd", stop_after_first = true },
            javascriptreact = { "prettier", "prettierd", stop_after_first = true },
            typescriptreact = { "prettier", "prettierd", stop_after_first = true },
            -- for inline math latex support
            -- needs to install mdformat-myst in $HOME/.local/share/nvim/mason/packages/mdformat/venv
            markdown = { "mdformat" },
            php = { "php_cs_fixer", env = { PHP_CS_FIXER_IGNORE_ENV = "1" } },
        },
        formatters = {
            php_cs_fixer = { env = { PHP_CS_FIXER_IGNORE_ENV = "1" } },
        },
    },
}
