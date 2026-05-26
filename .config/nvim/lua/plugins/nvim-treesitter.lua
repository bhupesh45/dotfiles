return {
	"nvim-treesitter/nvim-treesitter",

	version = false,
	build = ":TSUpdate",

	event = { "BufReadPost", "BufNewFile" },

	lazy = vim.fn.argc(-1) == 0,

	config = function()
		require("nvim-treesitter.configs").setup({
			highlight = {
				enable = true,
			},

			-- Disable TS indent for C/C++
			indent = {
				enable = true,
				disable = { "c", "cpp" },
			},

			auto_install = true,

			ensure_installed = {
				"bash",
				"c",
				"cpp",
				"diff",
				"html",
				"javascript",
				"jsdoc",
				"json",
				"jsonc",
				"lua",
				"luadoc",
				"luap",
				"markdown",
				"markdown_inline",
				"printf",
				"python",
				"query",
				"regex",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"xml",
				"yaml",
				"java",
			},

			incremental_selection = {
				enable = true,

				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},

			textobjects = {
				move = {
					enable = true,

					goto_next_start = {
						["]f"] = "@function.outer",
						["]c"] = "@class.outer",
						["]a"] = "@parameter.inner",
					},

					goto_next_end = {
						["]F"] = "@function.outer",
						["]C"] = "@class.outer",
						["]A"] = "@parameter.inner",
					},

					goto_previous_start = {
						["[f"] = "@function.outer",
						["[c"] = "@class.outer",
						["[a"] = "@parameter.inner",
					},

					goto_previous_end = {
						["[F"] = "@function.outer",
						["[C"] = "@class.outer",
						["[A"] = "@parameter.inner",
					},
				},
			},
		})

		-- Proper C/C++ indentation
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "c", "cpp" },

			callback = function()
				vim.opt_local.smartindent = true
				vim.opt_local.cindent = true

				vim.opt_local.expandtab = true
				vim.opt_local.shiftwidth = 4
				vim.opt_local.tabstop = 4
				vim.opt_local.softtabstop = 4
			end,
		})
	end,
}
