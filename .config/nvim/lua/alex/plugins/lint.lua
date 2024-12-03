return {
	"mfussenegger/nvim-lint",
	events = { "BufReadPre", "BufNewFile" },
	opts = {
		events = { "BufEnter", "BufWritePost", "InsertLeave" },
		linters_by_ft = {
			javascript = { "eslintd" },
			typescript = { "eslintd" },
			markdown = { "markdownlint-cli2" },
			["*"] = { "typos" },
		},
	},
	keys = {
		{
			"<leader>l",
			function()
				require("lint").try_lint()
			end,
		},
	},
}
