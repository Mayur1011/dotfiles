vim.wo.number = true
vim.o.relativenumber = true
vim.o.clipboard = 'unnamedplus'
vim.o.wrap = false
vim.o.linebreak = true
vim.o.mouse = 'a' -- Enable mouse mode
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.o.scrolloff = 5
vim.opt.termguicolors = true
vim.o.undofile = true -- Save undo history (default: false)
-- vim.o.background = "dark"
vim.opt.showmode = false


vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
    pattern = "*",
    callback = function()
        vim.highlight.on_yank()
    end,
    desc = "Highlight yanked text"
})
