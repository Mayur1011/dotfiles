-- local function enable_transparency()
--     vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
--     vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
--     vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
-- end


-- return {
--     "blazkowolf/gruber-darker.nvim",
--     priority = 1000,
--     opts = {
--         -- bold = false,
--         -- italic = {
--         --     strings = false,
--         -- },
--         editor = {
--             transparent_background = true
--         } },
--     config = function()
--         require('gruber-darker').setup({
--             style = 'darker',
--             telescope = true,          -- Telescope plugin
--             telescope_borders = false, -- Telescope borders
--         })
--         require('gruber-darker').load()
--         vim.api.nvim_set_hl(0, "Normal", { bg = "none"})
--         vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
--         vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
--         vim.api.nvim_set_hl(0, "VertSplit", { bg = "none" })
--         vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
--     end
-- }

-- return {
--     'Mofiqul/vscode.nvim',
--     lazy = false,
--     priority = 1000,
--     init = function()
--         require("vscode").setup({
--             disable_background = true, -- disables background color (for transparency)
--             disable_float_background = true, -- makes floating windows transparent too
--         })
--         vim.cmd("colorscheme vscode")
--         vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
--         vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
--         vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
--         vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
--         vim.api.nvim_set_hl(0, "VertSplit", { bg = "none" })
--         vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
--     end
-- }

-- return {
--     "slugbyte/lackluster.nvim",
--     lazy = false,
--     priority = 1000,
--     init = function()
--         require("lackluster").setup({
--             disable_background = true, -- disables background color (for transparency)
--             disable_float_background = true, -- makes floating windows transparent too
--         })
--
--         -- vim.cmd.colorscheme("lackluster")
--         vim.cmd.colorscheme("lackluster-hack") -- my favorite
--         -- vim.cmd.colorscheme("lackluster-mint")
--
--         -- Optional: clear background for Normal and Float explicitly
--         vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
--         vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
--         vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
--         vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
--         vim.api.nvim_set_hl(0, "VertSplit", { bg = "none" })
--         vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
--
--     end
-- }

-- return {
--     "metalelf0/black-metal-theme-neovim",
--     lazy = false,
--     priority = 1000,
--     config = function()
--         require("black-metal").setup({
--             -- optional configuration here
--             theme = "emperor",
--             disable_background = true, -- disables background color (for transparency)
--             disable_float_background = true, -- makes floating windows transparent too
--         })
--         -- require("black-metal").load()
--
--         -- vim.cmd.colorscheme("emperor")
--         vim.cmd.colorscheme("gorgoroth")
--
--         -- Optional: clear background for Normal and Float explicitly
--         vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
--         vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
--         vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
--         vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
--         vim.api.nvim_set_hl(0, "VertSplit", { bg = "none" })
--         vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
--
--     end,
-- }

-- return {
--     "rose-pine/neovim",
--     name = "rose-pine",
--     -- priority = 1000,
--     config = function()
--         require("rose-pine").setup({
--             variant = "main",      -- auto, main, moon, or dawn
--             dark_variant = "main", -- main, moon, or dawn
--             dim_inactive_windows = false,
--             disable_background = true,
--             disable_nc_background = false,
--             disable_float_background = false,
--             extend_background_behind_borders = false,
--             styles = {
--                 bold = true,
--                 italic = false,
--                 transparency = true,
--             },
--             highlight_groups = {
--                 ColorColumn = { bg = "#1C1C21" },
--                 Normal = { bg = "none" },                      -- Main background remains transparent
--                 Pmenu = { bg = "", fg = "#e0def4" },           -- Completion menu background
--                 PmenuSel = { bg = "#4a465d", fg = "#f8f5f2" }, -- Highlighted completion item
--                 PmenuSbar = { bg = "#191724" },                -- Scrollbar background
--                 PmenuThumb = { bg = "#9ccfd8" },               -- Scrollbar thumb
--             },
--             enable = {
--                 terminal = false,
--                 legacy_highlights = false, -- Improve compatibility for previous versions of Neovim
--                 migrations = true,         -- Handle deprecated options automatically
--             },
--
--         })
--
--         -- HACK: set this on the color you want to be persistent
--         -- when quit and reopening nvim
--         vim.cmd("colorscheme rose-pine")
--     end
-- }

return {
    "gmr458/cold.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("cold").setup({
            disable_background = false, -- disables background color (for transparency)
            disable_float_background = false, -- makes floating windows transparent too
        })
        vim.cmd("colorscheme cold")

        -- Optional: clear background for Normal and Float explicitly
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
        vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
        vim.api.nvim_set_hl(0, "VertSplit", { bg = "none" })
        vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
    end
}

-- return {
--     "zenbones-theme/zenbones.nvim",
--     -- Optionally install Lush. Allows for more configuration or extending the colorscheme
--     -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
--     -- In Vim, compat mode is turned on as Lush only works in Neovim.
--     dependencies = "rktjmp/lush.nvim",
--     lazy = false,
--     priority = 1000,
--     -- you can set set configuration options here
--     config = function()
--         -- require("zenbones").setup({
--         --     disable_background = true, -- disables background color (for transparency)
--         --     disable_float_background = true, -- makes floating windows transparent too
--         -- })
--         vim.g.zenbones_darken_comments = 45
--         -- vim.cmd.colorscheme('neobones')
--         vim.cmd.colorscheme('zenwritten')
--         -- Optional: clear background for Normal and Float explicitly
--         vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
--         vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
--         vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
--         vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
--         vim.api.nvim_set_hl(0, "VertSplit", { bg = "none" })
--         vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
--     end
-- }

