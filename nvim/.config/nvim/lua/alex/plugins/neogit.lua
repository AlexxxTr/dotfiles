return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
		"nvim-telescope/telescope.nvim",
	},
	opts = {},
	keys = {
		{ "<leader>gs", "<cmd>Neogit<cr>" },
	},
}
