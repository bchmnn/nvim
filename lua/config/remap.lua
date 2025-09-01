vim.g.mapleader = " "

vim.keymap.set('v', '<C-c>', '"+y', { remap = true })
vim.keymap.set('i', '<C-v>', '<C-r>+', { remap = true })

vim.keymap.set({ 'n', 'i', 'v' }, '<C-s>', function()
    vim.api.nvim_command('write')
end)

vim.keymap.set('n', '<Tab>', ':tabnext<CR>', { remap = true })
vim.keymap.set('n', '<S-Tab>', ':tabprev<CR>', { remap = true })

vim.keymap.set('n', '<C-Left>', ':vertical resize -10<CR>', { remap = true })
vim.keymap.set('n', '<C-Right>', ':vertical resize +10<CR>', { remap = true })
vim.keymap.set('n', '<C-Up>', ':resize -5<CR>', { remap = true })
vim.keymap.set('n', '<C-Down>', ':resize +5<CR>', { remap = true })

vim.keymap.set('n', '<leader>/', '<C-/>', { remap = true })
vim.keymap.set('v', '<leader>/', '<C-/>', { remap = true })

vim.keymap.set('n', '<leader>b', function()
    local file = vim.api.nvim_buf_get_name(0)
    local r = unpack(vim.api.nvim_win_get_cursor(0))

    local cmd = {
        string.format("git --no-pager blame -l -L %d,%d %s", r, r, file),
        "grep -Pio '[\\w]+'",
        "head -n1",
        "xargs git --no-pager show -s",
    }
    vim.api.nvim_command("!(" .. table.concat(cmd, " | ") .. ")")
end)

vim.keymap.set('n', '<leader>pc', function()
    local filepath = vim.fn.expand('%')
    vim.fn.setreg('+', filepath) -- write to clippoard
end, { noremap = true, silent = true })
