require("config.lazy")
require("config.autocmds")
require("config.keymaps")
require("config.options")
require("config.lsp")

vim.cmd.colorscheme("iris")

local watcher = vim.uv.new_fs_event()
if watcher then
	watcher:start(
		vim.fn.expand("~/.cache/iris"),
		{},
		vim.schedule_wrap(function(err, filename)
			if not err and filename == "colors.json" then
				vim.cmd.colorscheme("iris")
			end
		end)
	)
end
