return {
	"mfussenegger/nvim-lint",
	events = { "BufReadPre", "BufNewFile" },
	config = function()
        require("lint").linters_by_ft = {
            javascript = { "eslint_d" },
            typescript = { "eslint_d", "cspell" },
            markdown = { "markdownlint-cli2" },
            ["*"] = { "cspell" },
        }

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			callback = function()
				-- try_lint without arguments runs the linters defined in `linters_by_ft`
				-- for the current filetype
				require("lint").try_lint()

				-- You can call `try_lint` with a linter name or a list of names to always
				-- run specific linters, independent of the `linters_by_ft` configuration
				require("lint").try_lint("cspell")
			end,
		})
	end,
	keys = {
		{
			"<leader>l",
			function()
				require("lint").try_lint()
				require("lint").try_lint("cspell")
			end,
			desc = "Lint the file (with spellcheck)",
		},
	},
}
