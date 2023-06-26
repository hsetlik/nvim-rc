vim.g.mapleader = " "
local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>")
keymap.set("n", "<leader>nh", ":nohl<CR>")
keymap.set("n", "x", '"_x')
keymap.set("n", "<leader>sv", ":vsplit<CR>") -- split window vertically
keymap.set("n", "<leader>sx", ":close<CR>") -- close split window

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>") -- toggle file explorer

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags

-- neovim-tasks (mostly cmake stuff)
keymap.set("n", "<leader>cg", "<cmd>Task start cmake_kits configure<cr>") -- configure current project
keymap.set("n", "<leader>cm", "<cmd>Task set_module_param cmake_kits build_type<cr>") -- set build mode
keymap.set("n", "<leader>cx", "<cmd>Task cancel<cr>") -- cancel the current task
keymap.set("n", "<leader>ct", "<cmd>Task set_module_param cmake_kits target<cr>") -- set build target
keymap.set("n", "<leader>cr", "<cmd>Task start cmake_kits run<cr>") -- run current
keymap.set("n", "<leader>cb", "<cmd>Task start cmake_kits build<cr>") -- build current

-- git
keymap.set("n", "<leader>gc", "<cmd>Neogit commit<cr>") -- open the commit popup
keymap.set("n", "<leader>gb", "<cmd>Neogit branch<cr>") -- open the branch popup
keymap.set("n", "<leader>gm", "<cmd>Neogit merge<cr>") -- open the merge popup
keymap.set("n", "<leader>gp", "<cmd>Neogit pull<cr>") -- open the pull popup
keymap.set("n", "<leader>gP", "<cmd>Neogit push<cr>") -- open the push popup
keymap.set("n", "<leader>gs", "<cmd>Neogit <cr>") -- open the status popup
