return {
    "VonHeikemen/lsp-zero.nvim",
    dependencies = {
        -- LSP Support
        { "neovim/nvim-lspconfig" },
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },

        -- Autocompletion
        { "hrsh7th/nvim-cmp" },
        { "hrsh7th/cmp-cmdline" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "saadparwaiz1/cmp_luasnip" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-nvim-lua" },

        -- Snippets
        { "L3MON4D3/LuaSnip" },
        { "rafamadriz/friendly-snippets" },
    },
    config = function()
        local lsp = require("lsp-zero")
        lsp.extend_lspconfig()

        lsp.on_attach(function(client, bufnr)
            lsp.default_keymaps({ buffer = bufnr })

            local opts = { buffer = bufnr, remap = false }

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
                vim.diagnostic.goto_next()
            end, opts)
            vim.keymap.set("n", "]d", function()
                vim.diagnostic.goto_prev()
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
        end)

        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
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
                "ruff_lsp",
            },
            handles = {
                lsp.default_setup,
                ts_ls = function()
                    require("lspconfig").ts_ls.setup({
                        settings = {
                            completions = {
                                completeFunctionCalls = true,
                            },
                        },
                    })
                end,
                lua_ls = function()
                    local lua_opts = lsp.nvim_lua_ls()
                    require("lspconfig").lua_ls.setup(lua_opts)
                end,
                pyright = function()
                    require("lspconfig").pyright.setup({
                        settings = {
                            pyright = {
                                disableOrganizeImports = true,
                            },
                            python = {
                                analysis = {
                                    ignore = { "*" },
                                },
                            },
                        },
                    })
                end,
                ruff_lsp = function()
                    require("lspconfig").ruff_lsp.setup({
                        on_attach = function(client, _)
                            if client.name == "ruff_lsp" then
                                client.server_capabilities.hoverProvider = false
                            end
                        end,
                    })
                end,
            },
        })

        lsp.setup_servers({
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
            "ruff_lsp",
        })

        local cmp = require("cmp")
        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            sources = {
                { name = "nvim_lsp" },
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<Tab>"] = nil,
                ["<S-Tag>"] = nil,
            }),
        })

        cmp.setup.cmdline("/", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" },
            },
        })

        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = "path" },
            }, {
                {
                    name = "cmdline",
                    option = {
                        ignore_cmds = { "Man", "!" },
                    },
                },
            }),
        })

        lsp.set_sign_icons({
            error = "E",
            warn = "W",
            hint = "H",
            info = "I",
        })

        lsp.setup()

        vim.diagnostic.config({
            virtual_text = true,
        })
    end,
}
