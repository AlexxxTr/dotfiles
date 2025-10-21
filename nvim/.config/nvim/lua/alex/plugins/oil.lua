return {
	"stevearc/oil.nvim",
	opts = {
		skip_confirm_for_simple_edits = true,
	},
	-- Optional dependencies
	-- dependencies = { { "echasnovski/mini.icons", opts = {} } },
	dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
	keys = {
		{ mode = "n", "<leader>pv", "<CMD>Oil<cr>", desc = "Open file explorer" },
	},
}
