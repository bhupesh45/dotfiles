return {
	"L3MON4D3/LuaSnip",
	event = "InsertEnter",
	dependencies = { "rafamadriz/friendly-snippets" },
	config = function()
		local ls = require("luasnip")

		-- Load "friendly-snippets" (generic stuff)
		require("luasnip.loaders.from_vscode").lazy_load()

		-- Load YOUR custom lua snippets from lua/snippets/*.lua
		require("luasnip.loaders.from_lua").load({ paths = "./lua/snippets" })

		-- Keymaps for jumping inside snippets
		-- Jump forward: Ctrl-L
		vim.keymap.set({ "i", "s" }, "<C-L>", function()
			ls.jump(1)
		end, { silent = true })
		-- Jump backward: Ctrl-J
		vim.keymap.set({ "i", "s" }, "<C-J>", function()
			ls.jump(-1)
		end, { silent = true })
	end,
}
