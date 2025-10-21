return {
	"pwntester/octo.nvim",
	cmd = { "Octo" },
	event = { { event = "BufReadCmd", pattern = "octo://*" } },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		enable_builtin = true,
		default_to_projects_v2 = false,
		default_merge_method = "rebase",
		picker = "fzf-lua",
		picker_config = {
			use_emojis = true,
		},
	},
	keys = {
		{ "<leader>o", "<cmd>Octo actions<cr>" },
		{ "<leader>gi", "<cmd>Octo issue list<CR>", desc = "List Issues (Octo)" },
		{ "<leader>gI", "<cmd>Octo issue search<CR>", desc = "Search Issues (Octo)" },
		{ "<leader>gp", "<cmd>Octo pr list<CR>", desc = "List PRs (Octo)" },
		{ "<leader>gP", "<cmd>Octo pr search<CR>", desc = "Search PRs (Octo)" },
		{ "<leader>gr", "<cmd>Octo repo list<CR>", desc = "List Repos (Octo)" },
		{ "<leader>gS", "<cmd>Octo search<CR>", desc = "Search (Octo)" },

		{ "@", "@<C-x><C-o>", mode = "i", ft = "octo", silent = true },
		{ "#", "#<C-x><C-o>", mode = "i", ft = "octo", silent = true },
	},
}
