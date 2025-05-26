return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons" },
    command = "FzfLua",
	opts = {
		files = {
			previewer = "bat",
		},
		keymap = {
			fzf = {
				["ctrl-d"] = "preview-page-down",
				["ctrl-u"] = "preview-page-up",
				["ctrl-q"] = "select-all+accept",
			},
		},
	},
	keys = {
		{ "<c-j>", "<c-j>", ft = "fzf", mode = "t", nowait = true },
		{ "<c-k>", "<c-k>", ft = "fzf", mode = "t", nowait = true },
		{
			"<leader>,",
			"<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>",
			desc = "Switch Buffer",
		},
		{ "<leader>:", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
		-- find
		{ "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find Files" },
		{ "<leader>fb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
		{ "<leader>fg", "<cmd>FzfLua git_files<cr>", desc = "Find Files (git-files)" },
		{ "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent" },
		{ "<leader>fs", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "File symbols" },
		-- search
		{ '<leader>s"', "<cmd>FzfLua registers<cr>", desc = "Registers" },
		{ "<leader>sg", "<cmd>FzfLua live_grep<cr>", desc = "Live Grep" },
		{ "<leader>sa", "<cmd>FzfLua autocmds<cr>", desc = "Auto Commands" },
		{ "<leader>sb", "<cmd>FzfLua grep_curbuf<cr>", desc = "Buffer" },
		{ "<leader>sc", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
		{ "<leader>sC", "<cmd>FzfLua commands<cr>", desc = "Commands" },
		{ "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>", desc = "Document Diagnostics" },
		{ "<leader>sD", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Workspace Diagnostics" },
		{ "<leader>sh", "<cmd>FzfLua help_tags<cr>", desc = "Help Pages" },
		{ "<leader>sH", "<cmd>FzfLua highlights<cr>", desc = "Search Highlight Groups" },
		{ "<leader>sj", "<cmd>FzfLua jumps<cr>", desc = "Jumplist" },
		{ "<leader>sk", "<cmd>FzfLua keymaps<cr>", desc = "Key Maps" },
		{ "<leader>sl", "<cmd>FzfLua loclist<cr>", desc = "Location List" },
		{ "<leader>sM", "<cmd>FzfLua man_pages<cr>", desc = "Man Pages" },
		{ "<leader>sm", "<cmd>FzfLua marks<cr>", desc = "Jump to Mark" },
		{ "<leader>sR", "<cmd>FzfLua resume<cr>", desc = "Resume" },
		{ "<leader>sq", "<cmd>FzfLua quickfix<cr>", desc = "Quickfix List" },
	},
}
