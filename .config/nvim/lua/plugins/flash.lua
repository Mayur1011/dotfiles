return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {},
  -- stylua: ignore
  keys = {
    { "zk",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
  },
}
