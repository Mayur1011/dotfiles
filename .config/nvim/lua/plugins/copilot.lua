-- return {
--     "zbirenbaum/copilot-cmp",
--     event = "InsertEnter",
--     config = function () require("copilot_cmp").setup() end,
--
--     dependencies = {
--         "zbirenbaum/copilot.lua",
--         cmd = "Copilot",
--         config = function()
--             require("copilot").setup({
--                 panel = { enabled = false },
--             })
--         end,
--     },
-- }

return {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ':Copilot auth',
    event = "InsertEnter",
    config = function()
        require("copilot").setup({
          suggestion = {
            auto_trigger = true,
            debounce = 100,
            keymap = {
              accept = "<C-l>",
            },
          }
        })
    end
}
