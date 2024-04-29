vim.opt.list = true

vim.opt.listchars = {
    tab = "→ ",
    trail = "·",
    lead = "·",
}

vim.cmd[[highlight hi-WhitespaceIbl ctermfg=LightGray guifg=LightGray]]
vim.cmd[[match hi-TrailWhitespace /\s\+$/]]
vim.cmd[[highlight hi-TrailWhitespace ctermfg=LightGray guifg=LightGray]]
vim.cmd[[highlight Visual ctermbg=LightBlue guibg=LightBlue]]

return {
    'lukas-reineke/indent-blankline.nvim',
    main = "ibl",
    opts = {
        indent = {
            char = "│",
            smart_indent_cap = false,
            highlight = "hi-WhitespaceIbl",
        },
        whitespace = {
            remove_blankline_trail = false,
            highlight = "hi-WhitespaceIbl",
        },
        scope = {
            enabled = false,
        },
    },
}

