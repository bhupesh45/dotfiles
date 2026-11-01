-- Generated automatically by iris
local M = {}

M.colors = {
	bg = "{bg}",
	fg = "{fg}",
	surface = "{surface}",
	dim = "{dim}",
	accent = "{accent}",
	red = "{red}",
	green = "{green}",
	yellow = "{yellow}",
	keyword = "{syntax_keyword}",
	string = "{syntax_string}",
	func = "{syntax_func}",
	type = "{syntax_type}",
	const = "{syntax_const}",
	comment = "{syntax_comment}",
	param = "{syntax_param}",
	operator = "{syntax_operator}",
}

function M.setup()
	vim.cmd("highlight clear")
	if vim.fn.exists("syntax_on") then
		vim.cmd("syntax reset")
	end
	vim.g.colors_name = "iris"

	local c = M.colors
	local hl = function(group, opts)
		vim.api.nvim_set_hl(0, group, opts)
	end

	-- Core UI
	hl("Normal", { fg = c.fg, bg = c.bg })
	hl("NormalFloat", { fg = c.fg, bg = c.surface })
	hl("FloatBorder", { fg = c.accent, bg = c.surface })
	hl("CursorLine", { bg = c.surface })
	hl("CursorLineNr", { fg = c.accent, bold = true })
	hl("LineNr", { fg = c.dim })
	hl("Visual", { fg = c.bg, bg = c.accent })
	hl("Search", { fg = c.bg, bg = c.yellow })
	hl("IncSearch", { fg = c.bg, bg = c.accent, bold = true })
	hl("StatusLine", { fg = c.fg, bg = c.surface })
	hl("StatusLineNC", { fg = c.dim, bg = c.bg })
	hl("WinSeparator", { fg = c.surface, bg = c.bg })
	hl("Pmenu", { fg = c.fg, bg = c.surface })
	hl("PmenuSel", { fg = c.bg, bg = c.accent, bold = true })

	-- Diagnostics & Git
	hl("DiagnosticError", { fg = c.red })
	hl("DiagnosticWarn", { fg = c.yellow })
	hl("DiagnosticInfo", { fg = c.accent })
	hl("DiagnosticHint", { fg = c.dim })
	hl("DiffAdd", { fg = c.green })
	hl("DiffChange", { fg = c.yellow })
	hl("DiffDelete", { fg = c.red })

	-- Syntax & Tree-sitter
	hl("Comment", { fg = c.comment, italic = true })
	hl("@comment", { link = "Comment" })
	hl("Keyword", { fg = c.keyword, bold = true })
	hl("@keyword", { link = "Keyword" })
	hl("@keyword.function", { fg = c.keyword, bold = true })
	hl("Statement", { fg = c.keyword })
	hl("Conditional", { fg = c.keyword })
	hl("Repeat", { fg = c.keyword })
	hl("String", { fg = c.string })
	hl("@string", { link = "String" })
	hl("Function", { fg = c.func, bold = true })
	hl("@function", { link = "Function" })
	hl("@function.call", { fg = c.func })
	hl("@method", { fg = c.func })
	hl("Type", { fg = c.type })
	hl("@type", { link = "Type" })
	hl("@type.builtin", { fg = c.type, italic = true })
	hl("Constant", { fg = c.const })
	hl("@constant", { link = "Constant" })
	hl("@constant.builtin", { fg = c.const, bold = true })
	hl("Number", { fg = c.const })
	hl("Boolean", { fg = c.const, bold = true })
	hl("Identifier", { fg = c.fg })
	hl("@variable", { fg = c.fg })
	hl("@variable.parameter", { fg = c.param, italic = true })
	hl("@parameter", { fg = c.param, italic = true })
	hl("Operator", { fg = c.operator })
	hl("@operator", { link = "Operator" })
	hl("Delimiter", { fg = c.dim })
	hl("@punctuation.bracket", { fg = c.dim })
end

return M
