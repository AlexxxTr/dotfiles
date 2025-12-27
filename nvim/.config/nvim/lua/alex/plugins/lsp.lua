local lsp_servers = {
	"ts_ls",
	"clangd",
	"cssls",
	"lua_ls",
	"rust_analyzer",
	"angularls",
	"eslint",
	"svelte",
	"html",
	"gopls",
	"pyright",
	"ruff",
	"ansiblels",
	"docker_compose_language_service",
    "dockerls",
	"bashls",
	"tinymist",
	"jsonls",
	"yamlls",
}

local function retrieve_server_setup()
	local basic_server_setup = {}

	for _, server in ipairs(lsp_servers) do
		basic_server_setup[server] = {}
	end

	basic_server_setup["lua_ls"] = {
		settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
				},
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = {
						vim.env.VIMRUNTIME,
					},
				},
			},
		},
	}

	basic_server_setup["yamlls"] = {
		settings = {
			yaml = {
				validate = true,
				format = { enable = true },
				hover = true,
				completion = true,
				schemaStore = {
					enabled = true,
					url = "https://www.schemastore.org/api/json/catalog.json",
				},
			},
		},
	}

	-- basic_server_setup["jsonls"] = {
	--     settings = {
	--         json = {
	--             validate = { enable = true },
	--             schemas = require("schemastore").json.schemas(),
	--             format = { enable = true },
	--         },
	--     },
	-- }

	return basic_server_setup
end

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		-- { "b0o/schemastore.nvim" }, -- Disabled until I find a way to fix this again
		{
			"saghen/blink.cmp",
			dependencies = {
				"rafamadriz/friendly-snippets",
				"giuxtaposition/blink-cmp-copilot",
			},
			version = "1.*",
			opts = {
				keymap = { preset = "default" },
				completion = {
					accept = {
						auto_brackets = {
							enabled = false,
						},
					},
					menu = {
						draw = {
							treesitter = { "LSP" },
						},
					},
					documentation = {
						auto_show = true,
						window = {
							border = "rounded",
						},
					},
				},
				appearance = {
					use_nvim_cmp_as_default = false,
					nerd_font_variant = "mono",
				},
				sources = {
					default = { "lsp", "path", "snippets", "buffer", "copilot" },
					per_filetype = {
						sql = { "lsp", "dadbod", "snippets", "buffer", "copilot" },
					},
					providers = {
						copilot = {
							name = "copilot",
							module = "blink-cmp-copilot",
							-- kind = "Copilot",
							score_offset = 100,
							async = true,
						},
						dadbod = {
							name = "Dadbod",
							module = "vim_dadbod_completion.blink",
						},
					},
				},

				signature = { enabled = true },
			},
			opts_extend = { "sources.default" },
		},
		{
			"williamboman/mason.nvim",
			opts = {
				ui = {
					border = "rounded",
				},
			},
			keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
			build = ":MasonUpdate",
		},
		{
			"williamboman/mason-lspconfig.nvim",
			opts = {
				automatic_enable = false,
				ensure_installed = lsp_servers,
			},
		},
	},
	opts = {
		servers = retrieve_server_setup(),
	},
	config = function(_, opts)
		for server, config in pairs(opts.servers) do
			-- passing config.capabilities to blink.cmp merges with the capabilities in your
			-- `opts[server].capabilities, if you've defined it
			config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
			vim.lsp.config(server, config)
			vim.lsp.enable(server)
		end

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

				local opts = { buffer = ev.buf }

				vim.keymap.set("n", "gd", function()
					vim.lsp.buf.definition()
				end, opts)
				vim.keymap.set("n", "K", function()
					vim.lsp.buf.hover()
				end, opts)
				vim.keymap.set("n", "<leader>vws", function()
					vim.lsp.buf.workspace_symbol()
				end, opts)
				vim.keymap.set("n", "<leader>vd", function()
					vim.diagnostic.open_float()
				end, opts)
				vim.keymap.set("n", "[d", function()
					vim.diagnostic.jump({ count = 1, float = false })
				end, opts)
				vim.keymap.set("n", "]d", function()
					vim.diagnostic.jump({ count = -1, float = false })
				end, opts)
				vim.keymap.set("n", "<leader>vca", function()
					vim.lsp.buf.code_action()
				end, opts)
				vim.keymap.set("n", "<leader>vrr", function()
					vim.lsp.buf.references()
				end, opts)
				vim.keymap.set("n", "<leader>vrn", function()
					vim.lsp.buf.rename()
				end, opts)
				vim.keymap.set("i", "<C-h>", function()
					vim.lsp.buf.signature_help()
				end, opts)
			end,
		})

		vim.diagnostic.config({
			virtual_text = true,
			float = { border = "rounded" },
		})
	end,
}
