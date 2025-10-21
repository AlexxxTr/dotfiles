return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    opts = {
            ensure_installed = {
                "vimdoc",
                "javascript",
                "typescript",
                "c",
                "lua",
                "rust"
            },

            sync_install = true,
            auto_isntall = true,

            hightlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            }
    },
}
