return {
	"stevearc/oil.nvim",
	opts = {
        skip_confirm_for_simple_edits = true,
    },
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		{ "<leader>pv", "<cmd>Oil<cr>" },
	},
}
