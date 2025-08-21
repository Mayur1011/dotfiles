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
--         }
--     },
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
--         vim.cmd.colorscheme("emperor")
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
--     "mellow-theme/mellow.nvim",
--     config = function ()
--         vim.cmd.colorscheme('mellow')
--     end
-- }

-- return {
--     "vague2k/vague.nvim",
--     config = function()
--         require("vague").setup({
--             disable_background = true, -- disables background color (for transparency)
--             disable_float_background = true, -- makes floating windows transparent too
--         })
--
--         vim.cmd("colorscheme vague")
--
--         -- Optional: clear background for Normal and Float explicitly
--         vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
--         vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
--         vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
--         vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
--         vim.api.nvim_set_hl(0, "VertSplit", { bg = "none" })
--         vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
--     end
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


-- return {
--     "p00f/alabaster.nvim",
--     lazy = false,
--     priority = 1000,
--     config = function()
--         -- require("alabaster").setup({
--         --     disable_background = true, -- disables background color (for transparency)
--         --     disable_float_background = true, -- makes floating windows transparent too
--         -- })
--         vim.cmd("colorscheme alabaster")
--
--         -- Optional: clear background for Normal and Float explicitly
--         -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
--         -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
--         -- vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
--         -- vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
--         -- vim.api.nvim_set_hl(0, "VertSplit", { bg = "none" })
--         -- vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
--     end
-- }

return {
    "gmr458/cold.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("cold").setup({
            disable_background = true, -- disables background color (for transparency)
            disable_float_background = true, -- makes floating windows transparent too
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
--     "webhooked/kanso.nvim",
--     lazy = false,
--     priority = 1000,
--
--     config = function()
--         require('kanso').setup({
--             bold = true,                 -- enable bold fonts
--             italics = true,             -- enable italics
--             compile = false,             -- enable compiling the colorscheme
--             undercurl = true,            -- enable undercurls
--             commentStyle = { italic = true },
--             functionStyle = {},
--             keywordStyle = { italic = true},
--             statementStyle = {},
--             typeStyle = {},
--             transparent = true,         -- do not set background color
--             dimInactive = true,         -- dim inactive window `:h hl-NormalNC`
--             terminalColors = true,       -- define vim.g.terminal_color_{0,17}
--             colors = {                   -- add/modify theme and palette colors
--                 palette = {},
--                 theme = { zen = {}, pearl = {}, ink = {}, all = {} },
--             },
--             overrides = function(colors) -- add/modify highlights
--                 return {}
--             end,
--             theme = "zen",              -- Load "zen" theme
--             background = {               -- map the value of 'background' option to a theme
--                 dark = "zen",           -- try "ink" !
--                 light = "pearl"         -- try "mist" !
--             },
--         })
--
--         vim.cmd("colorscheme kanso-zen")
--
--         -- Optional: clear background for Normal and Float explicitly
--         vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
--         vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
--         vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
--         vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
--         vim.api.nvim_set_hl(0, "VertSplit", { bg = "none" })
--         vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
--     end
-- }
