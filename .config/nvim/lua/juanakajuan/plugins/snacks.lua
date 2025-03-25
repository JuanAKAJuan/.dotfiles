return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		dashboard = { enabled = true },
		indent = {
			enabled = true,
			animate = {
				enabled = false,
			},
		},
	},
	keys = {},
}
