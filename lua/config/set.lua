vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.colorcolumn = "80"

vim.opt.signcolumn = "yes"

vim.cmd [[hi SignColumn ctermbg=NONE guibg=NONE]]
vim.cmd [[hi Comment ctermfg=LightGray guifg=LightGray]]

vim.g.netrw_keepdir = 0
vim.g.netrw_altv = 1

vim.opt.termguicolors = true

vim.filetype.add({ extension = { templ = "templ" } })
