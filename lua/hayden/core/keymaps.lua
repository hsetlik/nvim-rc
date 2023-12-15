vim.g.mapleader = " "
local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>")
keymap.set("n", "<leader>nh", ":nohl<CR>") -- clear highlighting/vim search
keymap.set("n", "x", '"_x')
keymap.set("n", "<leader>sv", ":vsplit<CR>") -- split window vertically
keymap.set("n", "<leader>sx", ":close<CR>") -- close split window

keymap.set("n", "<leader>x", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>xo", ":tabonly<CR>") -- close all tabs except the current one
keymap.set("n", "<leader>-", ":-tabnext<CR>") -- view previous tab
keymap.set("n", "<leader>=", ":tabnext<CR>") -- view next tab
