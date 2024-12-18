return {
	"mfussenegger/nvim-dap",
	opts = {},
	dependencies = {
		{
			"rcarriga/nvim-dap-ui",
			opts = {},
			dependencies = { "nvim-neotest/nvim-nio" },
			keys = {
				{
					"<leader>du",
					function()
						require("dapui").toggle()
					end,
				},
			},
		},
	},
	keys = {
		{
			"<leader>dt",
			function()
				require("dap").toggle_breakpoint()
			end,
		},
		{
			"<leader>dc",
			function()
				require("dap").continue()
			end,
		},
		{
			"<leader>ds",
			function()
				require("dap").step_over()
			end,
		},
		{
			"<leader>di",
			function()
				require("dap").step_into()
			end,
		},
		{
			"<leader>do",
			function()
				require("dap").step_out()
			end,
		},
		{
			"<leader>dl",
			function()
				require("dap").run_last()
			end,
		},
	},
}
