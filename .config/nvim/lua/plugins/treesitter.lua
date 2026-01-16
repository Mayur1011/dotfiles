-- return {
--   "nvim-treesitter/nvim-treesitter",
--   build = ":TSUpdate",
--   lazy = false, -- 👈 force load at startup (important)
--   opts = {
--     highlight = { enable = true },
--     indent = { enable = true },
--     autotag = { enable = true },
--     ensure_installed = {
--       "json", "javascript", "typescript", "svelte", "tsx",
--       "php", "html", "css", "markdown", "markdown_inline",
--       "bash", "lua", "vim", "vimdoc", "c",
--       "dockerfile", "gitignore", "go",
--     },
--     auto_install = false,
--   },
-- }

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.config")
    configs.setup({
      -- enable syntax highlighting
      highlight = {
        enable = true,
      },
      -- enable indentation
      indent = { enable = true },
      -- enable autotagging (w/ nvim-ts-autotag plugin)
      autotag = { enable = true },
      -- ensure these language parsers are installed
      ensure_installed = {
        "json",
        "javascript",
        "typescript",
        "svelte",
        "tsx",
        "php",
        "html",
        "css",
        "markdown",
        "markdown_inline",
        "bash",
        "lua",
        "vim",
        "vimdoc",
        "c",
        "dockerfile",
        "gitignore",
        "go"
      },
      -- auto install above language parsers
      auto_install = false,
    })
  end
}
