return {
    "mfussenegger/nvim-lint",
    config = function()
        local lint = require("lint")

        -- Configure linters by filetype
        lint.linters_by_ft = {
            python = {
                -- "pylint",
                "ruff",
                -- "mypy",
            },
            shell = {
                "shellcheck",
                "shellharden",
            }
        }

        -- Trigger linting on specific events
        vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
            callback = function()
                lint.try_lint()
            end,
        })
    end
}
