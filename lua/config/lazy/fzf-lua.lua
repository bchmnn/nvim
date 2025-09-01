return {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- or if using mini.icons/mini.nvim
    -- dependencies = { "nvim-mini/mini.icons" },
    config = function()
        local opts = {
            "hide",
            winopts = {
                fullscreen = true,
                preview = {
                    vertical = "down:65%",
                    layout = "vertical",
                },
            },
        }
        require("fzf-lua").setup(opts)
        vim.keymap.set('n', '<leader>r', ':FzfLua resume<cr>')
        vim.keymap.set('n', '<leader>g', ':FzfLua grep_project resume=true<cr>')
        vim.keymap.set('n', '<leader><leader>', ':FzfLua files resume=true<cr>')
        vim.keymap.set('n', '<leader>f', ':FzfLua git_files resume=true<cr>')
    end,
}
