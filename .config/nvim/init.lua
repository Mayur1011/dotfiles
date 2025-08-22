require("core.options")
require("core.keymaps")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	require("plugins.neotree"),
	require("plugins.colortheme"),
	require("plugins.telescope"),
	require("plugins.indent-blankline"),
	require("plugins.whichkey"),
	require("plugins.vim-be-better"),
	require("plugins.treesitter"),
	require("plugins.nvim-cmp"),
	require("plugins.lsp.mason"),
	require("plugins.lsp.lspconfig"),
	require("plugins.autopairs"),
	require("plugins.colorizer"),
	require("plugins.flash"),
    require("plugins.nvim-surround"),
    require("plugins.copilot"),
    require("plugins.copilotchat"),
    require("plugins.tiny-inline-diagnostic")
})
