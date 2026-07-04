return {
    "mason-org/mason.nvim",
    lazy = false,

    dependencies = {
        "mason-org/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    },

    config = function()
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")

        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        mason_lspconfig.setup({
            automatic_enable = false,

            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "zls",
            },
        })

    end,
}
