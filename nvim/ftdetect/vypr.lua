vim.filetype.add({
  extension = {
    vypr = "vypr",
  },
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.vypr" },
  callback = function()
    vim.cmd("syntax on")
    vim.bo.syntax = "vypr"
  end,
})
