vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<leader>so", ":source<CR>") -- source
keymap.set("n", "<leader>u", ":w<CR>") -- write, basically to update buffer
keymap.set("n", "<leader>fq", ":q!<CR>") -- force quit no write
keymap.set("n", "<leader>wq", ":wq<CR>") -- write quit
keymap.set("n", "<leader>fb", "gg+=G") -- format tab and indenting

-- split windows
keymap.set("n", "<leader>sw", "<C-w>v") -- split window
keymap.set("n", "<leader>se", "<C-w>=") -- make splits equal size
keymap.set("n", "<leader>sc", "<cmd>close<CR>") -- close split

-- tabs
keymap.set("n", "<leader>tn", "<cmd>tabnew<CR>") -- open new tab
keymap.set("n", "<leader>cct", "<cmd>tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tf", "<cmd>tabn<CR>") -- go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>") -- go to prev tab
keymap.set("n", "<leader>tb", "<cmd>tabnew %<CR>") -- open new tab with current text
