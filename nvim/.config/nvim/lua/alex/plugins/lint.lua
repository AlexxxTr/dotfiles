return {
	"mfussenegger/nvim-lint",
	events = { "BufReadPre", "BufNewFile", "InsertLeave" },
	config = function()
        require("lint").linters_by_ft = {
            javascript = { "eslint_d" },
            typescript = { "eslint_d", "cspell" },
            markdown = { "markdownlint-cli2" },
            sh = { "shellcheck" },
            ["*"] = { "cspell" },
        }

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			callback = function()
				-- try_lint without arguments runs the linters defined in `linters_by_ft`
				-- for the current filetype
				require("lint").try_lint()
			end,
		})
	end,
	keys = {
		{
			"<leader>l",
			function()
				require("lint").try_lint()
			end,
			desc = "Lint the file (with spellcheck)",
		},
	},
}
