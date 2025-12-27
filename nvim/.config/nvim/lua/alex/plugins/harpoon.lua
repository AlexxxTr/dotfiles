return {
	"theprimeagen/harpoon",
	branch = "harpoon2",
	lazy = true,
	keys = { "<C-e>", "<leader>a", "<C-h>", "<C-j>", "<C-k>", "<C-l>" },
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup({})

		vim.keymap.set("n", "<C-e>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Open harpoon window" })

		vim.keymap.set("n", "<leader>a", function()
			harpoon:list():add()
		end)

		vim.keymap.set("n", "<C-h>", function()
			harpoon:list():select(1)
		end)
		vim.keymap.set("n", "<C-j>", function()
			harpoon:list():select(2)
		end)
		vim.keymap.set("n", "<C-k>", function()
			harpoon:list():select(3)
		end)
		vim.keymap.set("n", "<C-l>", function()
			harpoon:list():select(4)
		end)
	end,
}
