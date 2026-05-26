return {
	"L3MON4D3/LuaSnip",

	event = "InsertEnter",

	version = "v2.*",

	dependencies = {
		"rafamadriz/friendly-snippets",
	},

	config = function()
		local ls = require("luasnip")

		-- Recommended config
		ls.config.set_config({
			history = true,

			updateevents = "TextChanged,TextChangedI",

			enable_autosnippets = true,
		})

		-- VSCode snippets
		require("luasnip.loaders.from_vscode").lazy_load()

		-- Your custom snippets
		require("luasnip.loaders.from_lua").load({
			paths = { "./lua/snippets" },
		})

		-- Jump forward
		vim.keymap.set({ "i", "s" }, "<C-L>", function()
			if ls.jumpable(1) then
				ls.jump(1)
			end
		end, { silent = true })

		-- Jump backward
		vim.keymap.set({ "i", "s" }, "<C-J>", function()
			if ls.jumpable(-1) then
				ls.jump(-1)
			end
		end, { silent = true })
	end,
}
