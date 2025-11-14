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
        local fzf = require("fzf-lua")
        fzf.setup(opts)
        vim.keymap.set("n", "<leader>r", ":FzfLua resume<cr>")
        vim.keymap.set("n", "<leader>g", ":FzfLua grep_project resume=true<cr>")
        vim.keymap.set("n", "<leader><leader>", ":FzfLua files resume=true<cr>")
        vim.keymap.set("n", "<leader>f", ":FzfLua git_files resume=true<cr>")

        local items = {}

        local function fzf_insert()
            fzf.fzf_exec(items, {
                prompt = "Insert> ",
                actions = {
                    ["default"] = function(selected)
                        if not selected or #selected == 0 then
                            return
                        end
                        vim.api.nvim_put({ selected[1] }, "c", true, true)
                    end,
                },
            })
        end

        vim.keymap.set("n", "<leader>pp", fzf_insert)
    end,
}
