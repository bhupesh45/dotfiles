return {
	"nvim-lualine/lualine.nvim",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		options = {
			icons_enabled = true,
			theme = "auto",
			component_separators = { left = "|", right = "|" },
			section_separators = { left = "", right = "" },
			disabled_filetypes = {
				statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" },
				winbar = {},
			},
			ignore_focus = {},
			always_divide_middle = true,
			always_show_tabline = true,
			globalstatus = true,
			refresh = {
				statusline = 100,
				tabline = 100,
				winbar = 100,
			},
		},
		sections = {
			lualine_a = {
				-- Explicitly declare BOTH left and right to keep the inner curve
				{ "mode", separator = { left = "", right = "" }, padding = 1 },
			},
			lualine_b = { "branch", "diff", "diagnostics" },
			lualine_c = { "filename" },
			lualine_x = {
				"encoding",
				"fileformat",
				"filetype",
				{
					require("noice").api.statusline.mode.get,
					cond = require("noice").api.statusline.mode.has,
					color = { fg = "#ff9e64" },
				},
			},
			lualine_y = { "progress" },
			lualine_z = {
				-- Explicitly declare BOTH left and right to cap the end perfectly
				{ "location", separator = { left = "", right = "" }, padding = 1 },
			},
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { "filename" },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {},
		winbar = {},
		inactive_winbar = {},
		extensions = {},
	},
}
