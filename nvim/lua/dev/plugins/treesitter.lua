return {
    "nvim-treesitter/nvim-treesitter",
    event = {
        "BufReadPre",
        "BufNewFile"
    },
    build = ":TSUpdate", 
    config = function()
        local treesitter = require("nvim-treesitter.configs")
        
        treesitter.setup({
            highlight = {
                enable = true,
                disable = {
                    "hydra"
                }
            },

            indent = {
                enable = true
            },

            ensure_installed = {
                "rust",
                "zig",
                "c",
                "lua",
                "vim",
                "toml",
            },

            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space",
                    node_incremental = "<C-space>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
        })
    end
}
