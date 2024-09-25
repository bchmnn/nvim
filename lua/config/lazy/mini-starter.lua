return {
    { "goolord/alpha-nvim",     enabled = false },
    { "nvimdev/dashboard-nvim", enabled = false },

    {
        "echasnovski/mini.starter",
        event = "VimEnter",
        opts = {
            evaluate_single = true,
            header = "================================================",
            items = {
                { name = "New file",        action = "ene | startinsert",                   section = "" },
                { name = "Find file",       action = "Telescope find_files",                section = "" },
                { name = "Recent files",    action = "Telescope oldfiles",                  section = "" },
                { name = "Grep text",       action = "Telescope live_grep",                 section = "" },
                { name = "Session restore", action = [[lua require("persistence").load()]], section = "" },
                { name = "Lazy",            action = "Lazy",                                section = "" },
                { name = "Quit",            action = "qa",                                  section = "" },
            },
            footer = "\n================================================",
        }
    },
}
