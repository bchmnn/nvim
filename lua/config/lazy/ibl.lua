return {
    'lukas-reineke/indent-blankline.nvim',
    main = "ibl",
    opts = {
        indent = {
            char = "│",
            smart_indent_cap = false,
        },
        whitespace = {
            remove_blankline_trail = false,
        },
        scope = {
            enabled = false,
        },
    },
    init = function()
        vim.opt.list = true
        vim.opt.listchars = {
            tab = "│ ",
            trail = "·",
            lead = "·",
        }
    end
}
