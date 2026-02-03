return {
	"A7lavinraj/assistant.nvim",
    enabled = false,
	branch = "stable",
	lazy = false,
	keys = {
		{ "<leader>a", "<cmd>Assistant<cr>", desc = "Assistant.nvim" },
	},
	opts = {
		ui = {
			border = "single",
			diff_mode = true,
			title_components_separator = "",
		},
	},
}
