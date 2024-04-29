vim.g.mapleader = " "

vim.keymap.set('n', '<leader>e', vim.cmd.Ex)

vim.keymap.set('v', '<C-c>', '"+y', { remap = true })
vim.keymap.set('i', '<C-v>', '<C-r>+', { remap = true })

vim.keymap.set({'n', 'i', 'v'}, '<C-s>', function()
    vim.api.nvim_command('write')
end)

vim.keymap.set('n', '<Tab>', ':tabnext<CR>', { remap = true })
vim.keymap.set('n', '<S-Tab>', ':tabprev<CR>', { remap = true })

-- TODO maybe a more suffisticated solution exists?
vim.api.nvim_exec([[ au BufRead,BufNewFile *.y set filetype=lex ]], false)
