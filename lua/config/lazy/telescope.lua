return {
    'nvim-telescope/telescope.nvim',

    tag = '0.1.6',

    dependencies = {
        'nvim-lua/plenary.nvim'
    },

    config = function()
        require('telescope').setup({})
        local builtin = require('telescope.builtin')

        local git_files_with_fallback = function()
            local status, _ = pcall(function()
                builtin.git_files({
                    git_command = {
                        "git",
                        "-c",
                        "core.quotepath=false",
                        "ls-files",
                        "--exclude-standard",
                        "--cached",
                        "--others"
                    },
                    prompt_title = "Git Files (<leader>p for Find Files)"
                })
            end)
            if not status then
                builtin.find_files({
                    prompt_title = "Find Files (Fallback)"
                })
            end
        end

        local find_files
        find_files = function(opts, no_ignore)
            opts = opts or {}
            no_ignore = vim.F.if_nil(no_ignore, false)
            opts.attach_mappings = function(_, map)
                map({ "n", "i" }, "<C-h>", function(prompt_bufnr)
                    local prompt = require("telescope.actions.state").get_current_line()
                    require("telescope.actions").close(prompt_bufnr)
                    no_ignore = not no_ignore
                    find_files({ default_text = prompt }, no_ignore)
                end)
                return true
            end

            if no_ignore then
                opts.no_ignore = true
                opts.hidden = true
                opts.prompt_title = "Find Files <ALL>"
                require("telescope.builtin").find_files(opts)
            else
                opts.prompt_title = "Find Files"
                require("telescope.builtin").find_files(opts)
            end
        end

        vim.keymap.set('n', '<leader>p', find_files)
        vim.keymap.set('n', '<leader><leader>', git_files_with_fallback)
        vim.keymap.set('n', '<C-p>', git_files_with_fallback)
        vim.keymap.set('n', '<leader>g', builtin.live_grep)
        vim.keymap.set('n', '<leader>d', builtin.diagnostics)
    end
}
