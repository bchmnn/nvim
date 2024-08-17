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
            json = { { "prettier", "prettierd" } },
            css = { { "prettier", "prettierd" } },
            javascript = { { "prettier", "prettierd" } },
            typescript = { { "prettier", "prettierd" } },
            javascriptreact = { { "prettier", "prettierd" } },
            typescriptreact = { { "prettier", "prettierd" } },
            markdown = { "mdformat" },
        },
    },
}
