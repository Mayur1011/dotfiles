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

--[[
return { 
    'killitar/obscure.nvim',
	lazy = false,
    priority = 1000,
    init = function()
        vim.cmd("colorscheme obscure")
    end
}
]]
	
return { 
    'Mofiqul/vscode.nvim',
    lazy = false,
    priority = 1000,
    init = function()
            vim.cmd("colorscheme vscode")
    end
}

--[[
    {
        'ishan9299/modus-theme-vim',
		lazy = false,
	    	priority = 1000,
	    	init = function()
			vim.cmd.colorscheme("modus-vivendi")
	    	end
    } 
]]

--[[
	{
	    "slugbyte/lackluster.nvim",
	    lazy = false,
	    priority = 1000,
	    init = function()
		-- vim.cmd.colorscheme("lackluster")
		vim.cmd.colorscheme("lackluster-hack") -- my favorite
		-- vim.cmd.colorscheme("lackluster-mint")
	    end
    } 
]]

