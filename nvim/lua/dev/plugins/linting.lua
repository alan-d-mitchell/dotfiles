return {
    "mfussenegger/nvim-lint",
    event = {
        "BufReadPre",
        "BufNewFile"
    },
    config = function()
        local lint = require("lint")

        lint.linters_by_ft = {
            rust = { "clippy" },
            lua = { "luacheck" },
            c = { "clangtidy" },
            python = { "ruff" }
        }

        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
            callback = function()
                lint.try_lint()
            end,
        })
    end,
}
