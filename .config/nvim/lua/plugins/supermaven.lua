return {
    "supermaven-inc/supermaven-nvim",
    config = function()
        require("supermaven-nvim").setup({
            disable_keymaps = true,
            color = {
                suggestion_color = "#ffffff",
                cterm = 244,
            },
            log_level = "info",
            disable_inline_completion = false,
            condition = function() return false end
        })

        -- Accept Supermaven suggestion automatically after snippet expansion
        local luasnip = require("luasnip")
        local suggestion = require("supermaven-nvim.completion_preview")

        -- Create an autocmd to hook after snippet expansion
        vim.api.nvim_create_autocmd("User", {
            pattern = "LuasnipInsertNodeEnter",
            callback = function()
                -- Try to accept the suggestion if available
                if suggestion.has_suggestion() then
                    vim.defer_fn(function()
                        suggestion.on_accept_suggestion()
                    end, 20) -- Slight delay to ensure snippet expansion completes
                end
            end,
        })
    end,
    dependencies = {
        "L3MON4D3/LuaSnip",
    }
}
