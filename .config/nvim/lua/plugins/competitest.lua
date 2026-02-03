return {
	"xeluxee/competitest.nvim",
	-- enabled = false,
	dependencies = "MunifTanjim/nui.nvim",
	config = function()
		require("competitest").setup({
			received_problems_path = function(task, file_extension)
				local cwd = vim.fn.getcwd()
				local group = task.group
				local name = task.name

				-- 1. CLEAN UP GROUP (CONTEST) NAME
				group = group:gsub("^Codeforces %- ", "") -- Strip "Codeforces - " prefix

				-- Handle "Div. 3" -> "Div_3" (Replace dot+space with underscore)
				group = group:gsub("%.%s+", "_")

				-- Remove any remaining dots (e.g., if it was just "Div.")
				group = group:gsub("%.", "")

				-- Standard cleanup
				group = group:gsub("%s+", "_") -- Spaces to underscores
				group = group:gsub("[%(%)]", "") -- Remove parens

				-- 2. CLEAN UP PROBLEM NAME
				name = name:gsub("%.%s+", "_") -- "A. Problem" -> "A_Problem"
				name = name:gsub("%s+", "_") -- Spaces to underscores
				name = name:gsub("[%(%)]", "") -- Remove parens

				return string.format("%s/%s/%s.%s", cwd, group, name, file_extension)
			end,
		})
		local map = vim.api.nvim_set_keymap
		local opts = { noremap = true, silent = true }

		-- Show UI
		map("n", "<leader>ru", ":CompetiTest show_ui<CR>", opts)

		-- Run test cases
		map("n", "<leader>rr", ":CompetiTest run<CR>", opts)

		-- Add a new test case manually
		map("n", "<leader>ra", ":CompetiTest add_testcase<CR>", opts)

		-- Edit existing test cases
		map("n", "<leader>re", ":CompetiTest edit_testcase<CR>", opts)

		-- Download test cases (start the server)
		map("n", "<leader>rc", ":CompetiTest receive testcases<CR>", opts)

		-- Download test cases (start the server)
		map("n", "<leader>rp", ":CompetiTest receive problem<CR>", opts)
	end,
}
