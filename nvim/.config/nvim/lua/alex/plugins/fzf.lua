return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons" },
	command = "FzfLua",
	opts = {
		files = {
			previewer = "bat",
            cwd_prompt = false,
		},
		keymap = {
			fzf = {
				["ctrl-d"] = "preview-page-down",
				["ctrl-u"] = "preview-page-up",
				["ctrl-q"] = "select-all+accept",
			},
		},
		ui_select = function(fzf_opts, items)
			return vim.tbl_deep_extend("force", fzf_opts, {
				prompt = " ",
				winopts = {
					title = " " .. vim.trim((fzf_opts.prompt or "Select"):gsub("%s*:%s*$", "")) .. " ",
					title_pos = "center",
				},
			}, fzf_opts.kind == "codeaction" and {
				winopts = {
					layout = "vertical",
					-- height is number of items minus 15 lines for the preview, with a max of 80% screen height
					height = math.floor(math.min(vim.o.lines * 0.8 - 16, #items + 4) + 0.5) + 16,
					width = 0.5,
					preview = not vim.tbl_isempty(vim.lsp.get_clients({ bufnr = 0, name = "vtsls" })) and {
						layout = "vertical",
						vertical = "down:15,border-top",
						hidden = "hidden",
					} or {
						layout = "vertical",
						vertical = "down:15,border-top",
					},
				},
			} or {
				winopts = {
					width = 0.5,
					-- height is number of items, with a max of 80% screen height
					height = math.floor(math.min(vim.o.lines * 0.8, #items + 4) + 0.5),
				},
			})
		end,
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
		{ "<leader>gc", "<cmd>FzfLua git_commits<cr>", desc = "Git Commits" },
		{ "<leader>gcf", "<cmd>FzfLua git_bcommits<cr>", desc = "Git Commits" },
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
