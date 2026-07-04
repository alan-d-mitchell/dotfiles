vim.filetype.add({
    extension = {
        hydra = "hydra",
        hir = "hydra",
        mir = "mir",
    },
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = { "*.hydra", "*.hir" },
    callback = function()
        vim.cmd("syntax on")
        vim.bo.syntax = "hydra"
    end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = "*.mir",
    callback = function()
        vim.cmd("syntax on")
        vim.bo.syntax = "mir"
    end,
})
