vim.opt.termguicolors = true
vim.opt.background = "dark"

local palette_path = vim.fn.expand("~/.cache/iris/colors.json")

local function parse_rgb(hex, fallback)
    hex = (type(hex) == "string") and hex:gsub("^#", "") or ""
    if not hex:match("^%x%x%x%x%x%x$") then
        hex = fallback:gsub("^#", "")
    end
    return tonumber(hex:sub(1, 2), 16), tonumber(hex:sub(3, 4), 16), tonumber(hex:sub(5, 6), 16)
end

-- Pulls secondary UI surfaces (CursorLine, Floats) down to deep obsidian
local function make_dark_bg(hex, target_luma, desat, fallback)
    local r, g, b = parse_rgb(hex, fallback)
    local luma = 0.2126 * r + 0.7152 * g + 0.0722 * b
    r = r * (1 - desat) + luma * desat
    g = g * (1 - desat) + luma * desat
    b = b * (1 - desat) + luma * desat
    if luma > target_luma and luma > 0 then
        local scale = target_luma / luma
        r, g, b = r * scale, g * scale, b * scale
    end
    return string.format("#%02x%02x%02x", math.floor(r), math.floor(g), math.floor(b))
end

-- Boosts saturation (chroma) and enforces a minimum brightness floor so syntax colors pop
local function boost_vibrancy(hex, sat_mult, min_luma, max_luma, fallback)
    local r, g, b = parse_rgb(hex, fallback)
    local luma = 0.2126 * r + 0.7152 * g + 0.0722 * b

    local avg = (r + g + b) / 3
    r = avg + (r - avg) * sat_mult
    g = avg + (g - avg) * sat_mult
    b = avg + (b - avg) * sat_mult
    r = math.max(0, math.min(255, r))
    g = math.max(0, math.min(255, g))
    b = math.max(0, math.min(255, b))

    luma = 0.2126 * r + 0.7152 * g + 0.0722 * b
    if luma < min_luma then
        if luma < 5 then
            r, g, b, luma = 40, 45, 60, 46
        end
        local scale = min_luma / luma
        r = math.min(255, r * scale)
        g = math.min(255, g * scale)
        b = math.min(255, b * scale)
    elseif max_luma and luma > max_luma and luma > 0 then
        local scale = max_luma / luma
        r, g, b = r * scale, g * scale, b * scale
    end

    return string.format("#%02x%02x%02x", math.floor(r), math.floor(g), math.floor(b))
end

local function load_palette()
    local file = io.open(palette_path, "r")
    if not file then
        return {}
    end
    local content = file:read("*a")
    file:close()
    local ok, result = pcall(vim.json.decode, content)
    if not ok or type(result) ~= "table" then
        return {}
    end
    return result
end

local raw = load_palette()

-- Solid dark hexes ONLY for inverted text (Search/PmenuSel) and elevated popups/CursorLine
local SOLID_BG = make_dark_bg(raw.bg,      7,  0.45, "#08090d")
local SURFACE  = make_dark_bg(raw.surface, 13, 0.35, "#0e1017")
local FLOAT    = make_dark_bg(raw.surface, 18, 0.30, "#131620")
local VISUAL   = boost_vibrancy(raw.surface, 1.3, 36, 48, "#252b3f")

local c = {
    bg              = "NONE", -- Inherit Kitty's exact background
    solid_bg        = SOLID_BG,
    surface         = SURFACE,
    float           = FLOAT,
    visual          = VISUAL,
    fg              = boost_vibrancy(raw.fg,             1.20, 215, 245, "#E5E9F0"),
    dim             = boost_vibrancy(raw.dim,            1.15, 105, 135, "#7E889B"),
    accent          = boost_vibrancy(raw.accent,         1.65, 155, 225, "#8CAAEE"),

    red             = boost_vibrancy(raw.red,            1.70, 145, 220, "#FF6B81"),
    green           = boost_vibrancy(raw.green,          1.65, 160, 225, "#A6E3A1"),
    yellow          = boost_vibrancy(raw.yellow,         1.65, 170, 230, "#F9E2AF"),

    syntax_keyword  = boost_vibrancy(raw.syntax_keyword,  1.75, 155, 225, "#CBA6F7"),
    syntax_string   = boost_vibrancy(raw.syntax_string,   1.65, 160, 225, "#A6E3A1"),
    syntax_func     = boost_vibrancy(raw.syntax_func,     1.75, 160, 230, "#89B4FA"),
    syntax_type     = boost_vibrancy(raw.syntax_type,     1.70, 165, 230, "#94E2D5"),
    syntax_const    = boost_vibrancy(raw.syntax_const,    1.75, 160, 230, "#FAB387"),
    syntax_comment  = boost_vibrancy(raw.syntax_comment,  1.15, 100, 130, "#7E889B"),
    syntax_param    = boost_vibrancy(raw.syntax_param,    1.60, 165, 230, "#F5C2E7"),
    syntax_operator = boost_vibrancy(raw.syntax_operator, 1.65, 155, 225, "#89DCEB"),
}

local function hi(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
end

local function fg(color)
    return { fg = color }
end

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
end

-- Editor: bg = "NONE" lets Kitty's exact background and blur show through seamlessly
local editor = {
    Normal       = { fg = c.fg, bg = "NONE" },
    NormalNC     = { fg = c.fg, bg = "NONE" },
    NormalFloat  = { fg = c.fg, bg = FLOAT },
    FloatBorder  = { fg = c.accent, bg = FLOAT },
    FloatTitle   = { fg = SOLID_BG, bg = c.accent, bold = true },
    EndOfBuffer  = { fg = SOLID_BG, bg = "NONE" },
    SignColumn   = { bg = "NONE" },
    LineNr       = { fg = c.dim, bg = "NONE" },
    CursorLine   = { bg = SURFACE },
    CursorLineNr = { fg = c.accent, bold = true, bg = SURFACE },
    ColorColumn  = { bg = SURFACE },
    Visual       = { bg = VISUAL },
    Search       = { fg = SOLID_BG, bg = c.yellow, bold = true },
    IncSearch    = { fg = SOLID_BG, bg = c.accent, bold = true },
    CurSearch    = { fg = SOLID_BG, bg = c.accent, bold = true },
    MatchParen   = { fg = c.accent, bg = VISUAL, bold = true },
    WinSeparator = { fg = VISUAL, bg = "NONE" },
    VertSplit    = { fg = VISUAL, bg = "NONE" },
    Folded       = { fg = c.dim, bg = SURFACE },
    FoldColumn   = { fg = c.dim, bg = "NONE" },
    NonText      = { fg = c.dim, bg = "NONE" },
    SpecialKey   = { fg = c.dim, bg = "NONE" },
    Whitespace   = { fg = VISUAL, bg = "NONE" },
}

for group, opts in pairs(editor) do
    hi(group, opts)
end

hi("Pmenu",      { fg = c.fg, bg = FLOAT })
hi("PmenuSel",   { fg = SOLID_BG, bg = c.accent, bold = true })
hi("PmenuSbar",  { bg = SURFACE })
hi("PmenuThumb", { bg = c.accent })

hi("StatusLine",   { fg = c.fg, bg = "NONE" })
hi("StatusLineNC", { fg = c.dim, bg = "NONE" })

hi("TabLine",     { fg = c.dim, bg = "NONE" })
hi("TabLineSel",  { fg = c.accent, bg = SURFACE, bold = true })
hi("TabLineFill", { bg = "NONE" })

hi("Title",      { fg = c.accent, bold = true })
hi("Directory",  fg(c.syntax_func))
hi("Question",   fg(c.green))
hi("WarningMsg", fg(c.yellow))
hi("ErrorMsg",   fg(c.red))
hi("ModeMsg",    fg(c.accent))

local syntax = {
    Comment      = { fg = c.syntax_comment, italic = true },
    Constant     = fg(c.syntax_const),
    String       = fg(c.syntax_string),
    Character    = fg(c.syntax_string),
    Number       = fg(c.syntax_const),
    Boolean      = { fg = c.syntax_const, bold = true },
    Float        = fg(c.syntax_const),
    Identifier   = fg(c.syntax_param),
    Function     = { fg = c.syntax_func, bold = true },
    Statement    = fg(c.syntax_keyword),
    Conditional  = { fg = c.syntax_keyword, bold = true },
    Repeat       = { fg = c.syntax_keyword, bold = true },
    Label        = fg(c.syntax_keyword),
    Keyword      = { fg = c.syntax_keyword, bold = true },
    Operator     = fg(c.syntax_operator),
    Exception    = fg(c.red),
    PreProc      = fg(c.syntax_operator),
    Include      = fg(c.syntax_keyword),
    Define       = fg(c.syntax_operator),
    Macro        = fg(c.syntax_func),
    Type         = { fg = c.syntax_type, bold = true },
    StorageClass = fg(c.syntax_keyword),
    Structure    = fg(c.syntax_type),
    Typedef      = fg(c.syntax_type),
    Special      = fg(c.syntax_operator),
    Todo         = { fg = SOLID_BG, bg = c.yellow, bold = true },
    Error        = { fg = c.red, bold = true },
    Underlined   = { fg = c.accent, underline = true },
}

for group, opts in pairs(syntax) do
    hi(group, opts)
end

local treesitter = {
    ["@comment"]               = { fg = c.syntax_comment, italic = true },
    ["@string"]                = fg(c.syntax_string),
    ["@string.escape"]         = { fg = c.syntax_operator, bold = true },
    ["@character"]             = fg(c.syntax_string),
    ["@number"]                = fg(c.syntax_const),
    ["@boolean"]               = { fg = c.syntax_const, bold = true },
    ["@constant"]              = fg(c.syntax_const),
    ["@constant.builtin"]      = { fg = c.syntax_const, bold = true },
    ["@variable"]              = fg(c.fg),
    ["@variable.parameter"]    = { fg = c.syntax_param, italic = true },
    ["@variable.builtin"]      = { fg = c.red, italic = true },
    ["@variable.member"]       = fg(c.syntax_param),
    ["@function"]              = { fg = c.syntax_func, bold = true },
    ["@function.call"]         = fg(c.syntax_func),
    ["@function.builtin"]      = { fg = c.syntax_type, bold = true },
    ["@method"]                = fg(c.syntax_func),
    ["@method.call"]           = fg(c.syntax_func),
    ["@constructor"]           = fg(c.syntax_type),
    ["@type"]                  = fg(c.syntax_type),
    ["@type.builtin"]          = { fg = c.syntax_type, italic = true },
    ["@keyword"]               = { fg = c.syntax_keyword, bold = true },
    ["@keyword.function"]      = { fg = c.syntax_keyword, bold = true },
    ["@keyword.return"]        = { fg = c.red, bold = true },
    ["@keyword.conditional"]   = { fg = c.syntax_keyword, bold = true },
    ["@keyword.repeat"]        = { fg = c.syntax_keyword, bold = true },
    ["@keyword.operator"]      = { fg = c.syntax_operator, bold = true },
    ["@conditional"]           = { fg = c.syntax_keyword, bold = true },
    ["@repeat"]                = { fg = c.syntax_keyword, bold = true },
    ["@operator"]              = fg(c.syntax_operator),
    ["@punctuation"]           = fg(c.syntax_operator),
    ["@punctuation.bracket"]   = fg(c.dim),
    ["@punctuation.delimiter"] = fg(c.dim),
    ["@property"]              = fg(c.syntax_param),
    ["@field"]                 = fg(c.syntax_param),
    ["@tag"]                   = fg(c.syntax_keyword),
    ["@attribute"]             = fg(c.syntax_type),
}

for group, opts in pairs(treesitter) do
    hi(group, opts)
end

hi("@lsp.type.function",  { link = "@function" })
hi("@lsp.type.method",    { link = "@method" })
hi("@lsp.type.Parameter", { link = "@variable.parameter" })
hi("@lsp.type.parameter", { link = "@variable.parameter" })
hi("@lsp.type.variable",  {})
hi("@lsp.type.property",  { link = "@property" })
hi("@lsp.type.keyword",   { link = "@keyword" })
hi("@lsp.type.type",      { link = "@type" })

hi("DiagnosticError", { fg = c.red })
hi("DiagnosticWarn",  { fg = c.yellow })
hi("DiagnosticInfo",  { fg = c.syntax_func })
hi("DiagnosticHint",  { fg = c.green })
hi("LspInlayHint",    { fg = c.dim, bg = SURFACE, italic = true })

hi("DiagnosticUnderlineError", { undercurl = true, sp = c.red })
hi("DiagnosticUnderlineWarn",  { undercurl = true, sp = c.yellow })
hi("DiagnosticUnderlineInfo",  { undercurl = true, sp = c.syntax_func })
hi("DiagnosticUnderlineHint",  { undercurl = true, sp = c.green })

hi("DiffAdd",    { fg = c.green, bg = "NONE" })
hi("DiffChange", { fg = c.yellow, bg = "NONE" })
hi("DiffDelete", { fg = c.red, bg = "NONE" })
hi("DiffText",   { fg = c.accent, bg = SURFACE })

hi("GitSignsAdd",    { fg = c.green, bg = "NONE" })
hi("GitSignsChange", { fg = c.yellow, bg = "NONE" })
hi("GitSignsDelete", { fg = c.red, bg = "NONE" })

hi("TelescopeNormal",       { fg = c.fg, bg = "NONE" })
hi("TelescopeBorder",       { fg = c.accent, bg = "NONE" })
hi("TelescopeSelection",    { fg = c.fg, bg = SURFACE, bold = true })
hi("TelescopeMatching",     { fg = c.accent, bold = true })
hi("TelescopePromptTitle",  { fg = SOLID_BG, bg = c.accent, bold = true })
hi("TelescopeResultsTitle", { fg = c.green, bg = "NONE" })

hi("CmpNormal",             { fg = c.fg, bg = FLOAT })
hi("CmpBorder",             { fg = c.accent, bg = FLOAT })
hi("BlinkCmpMenu",          { fg = c.fg, bg = FLOAT })
hi("BlinkCmpMenuBorder",    { fg = c.accent, bg = FLOAT })
hi("BlinkCmpMenuSelection", { fg = SOLID_BG, bg = c.accent, bold = true })
hi("BlinkCmpDoc",           { fg = c.fg, bg = SURFACE })
hi("BlinkCmpDocBorder",     { fg = c.dim, bg = SURFACE })
hi("BlinkCmpGhostText",     { fg = c.dim, italic = true })

hi("NotifyERRORBorder", fg(c.red))
hi("NotifyWARNBorder",  fg(c.yellow))
hi("NotifyINFOBorder",  fg(c.syntax_func))
hi("NotifyDEBUGBorder", fg(c.dim))
hi("NotifyTRACEBorder", fg(c.syntax_keyword))

vim.g.colors_name = "iris"
