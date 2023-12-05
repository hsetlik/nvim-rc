vim.g.mapleader = " "
local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>")
keymap.set("n", "<leader>nh", ":nohl<CR>")
keymap.set("n", "x", '"_x')
keymap.set("n", "<leader>sv", ":vsplit<CR>") -- split window vertically
keymap.set("n", "<leader>sx", ":close<CR>") -- close split window


