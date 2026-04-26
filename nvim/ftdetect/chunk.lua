vim.filetype.add({
  extension = {
    chunk = "chunk",
  },
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.chunk" },
  callback = function()
    vim.cmd("syntax on")
    vim.bo.syntax = "chunk"
  end,
})
