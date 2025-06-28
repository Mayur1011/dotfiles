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

-- return { 
--     'killitar/obscure.nvim',
-- 	lazy = false,
--     priority = 1000,
--     init = function()
--         vim.cmd("colorscheme obscure")
--     end
-- }
	
-- return { 
--     'Mofiqul/vscode.nvim',
--     lazy = false,
--     priority = 1000,
--     init = function()
--             vim.cmd("colorscheme vscode")
--     end
-- }


-- return {
--     "ring0-rootkit/ring0-dark.nvim",
--     priority = 1000, -- Make sure to load this before all the other start plugins.
--     init = function()
--         vim.cmd.colorscheme("ring0dark")
--     end,
-- }

return {
    "slugbyte/lackluster.nvim",
    lazy = false,
    priority = 1000,
    init = function()
        -- vim.cmd.colorscheme("lackluster")
        vim.cmd.colorscheme("lackluster-hack") -- my favorite
        -- vim.cmd.colorscheme("lackluster-mint")
    end
} 

