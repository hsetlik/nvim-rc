return {
	"tpope/vim-fugitive",
	config = function()
		local keymap = vim.keymap -- for conciseness
		keymap.set("n", "<leader>gA", "<cmd>:Git add -A<cr>", { desc = "Stage all changes in current repo" })
		keymap.set("n", "<leader>gs", "<cmd>:Git<cr>", { desc = "View GUI panel with git stuff" })
		keymap.set("n", "<leader>gc", "<cmd>:Git commit<cr>", { desc = "Open commit dialog" })
		keymap.set("n", "<leader>gp", "<cmd>:Git push<cr>", { desc = "Open push dialog" })
		keymap.set("n", "<leader>gd", "<cmd>:Gdiffsplit<cr>", { desc = "Open diff view for current file" })
	end,
}
