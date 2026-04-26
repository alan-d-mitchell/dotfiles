vim.filetype.add({
  extension = {
    hydra = "hydra",
    hir = "hydra",
  },
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.hydra", "*.hir" },
  callback = function()
    vim.cmd("syntax on")
    vim.bo.syntax = "hydra"
  end,
})
