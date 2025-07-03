-- local function enable_transparency()
--     vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
--     vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
--     vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
-- end

--[[
    {
      "navarasu/onedark.nvim",
      priority = 1000, -- make sure to load this before all the other start plugins
      config = function()
        require('onedark').setup {
          style = 'darker'
        }
        -- Enable theme
        require('onedark').load()
      end
    }
]]

return {
    "blazkowolf/gruber-darker.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    opts = {
        bold = false,
        italic = {
            strings = false,
        },
    },
    config = function()
        require('gruber-darker').setup {
            style = 'darker'
        }
        -- Enable theme
        require('gruber-darker').load()
    end
}

-- return { 
--     'Mofiqul/vscode.nvim',
--     lazy = false,
--     priority = 1000,
--     init = function()
--             vim.cmd("colorscheme vscode")
--     end
-- }

-- return {
--     "slugbyte/lackluster.nvim",
--     lazy = false,
--     priority = 1000,
--     init = function()
--         -- vim.cmd.colorscheme("lackluster")
--         vim.cmd.colorscheme("lackluster-hack") -- my favorite
--         -- vim.cmd.colorscheme("lackluster-mint")
--     end
-- }


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
--         vim.g.zenbones_darken_comments = 45
--         vim.cmd.colorscheme('zenbones')
--     end
-- }

-- return {
--     "metalelf0/black-metal-theme-neovim",
--     lazy = false,
--     priority = 1000,
--     config = function()
--         require("black-metal").setup({
--             -- optional configuration here
--             theme = "immortal",
--         })
--         require("black-metal").load()
--     end,
-- }
