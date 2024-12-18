return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		transparent = true,
		plugins = {
			all = package.loaded.lazy == nil or package.loaded.lazy == false,
			telescope = true,
		},
	},
}
