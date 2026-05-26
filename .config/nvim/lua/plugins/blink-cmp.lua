return {
    "saghen/blink.cmp",
    event = "InsertEnter",
    dependencies = {
        "rafamadriz/friendly-snippets",
        -- Add LuaSnip so blink knows it exists
        { "L3MON4D3/LuaSnip", version = "v2.*" }, 
    },

    version = "*",

    opts = {
        keymap = { preset = "super-tab" },

        appearance = {
            nerd_font_variant = "mono",
        },

        -- 1. TELL BLINK TO USE LUASNIP
        snippets = { preset = "luasnip" },

        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
            min_keyword_length = function(ctx)
                if ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil then
                    return 2
                end
                return 0
            end,
        },

        completion = {
            menu = {
                border = "single",
                draw = {
                    columns = {
                        { "label", "label_description", gap = 1 },
                        { "kind_icon", gap = 1 },
                        { "kind" },
                    },
                },
            },
            accept = { auto_brackets = { enabled = true } },
            documentation = { auto_show = false, auto_show_delay_ms = 150, window = { border = "single" } },
        },
        signature = {
            enabled = false,
        },

        fuzzy = {
            implementation = "prefer_rust_with_warning",
            sorts = {
                "exact",
                "score",
                "sort_text",
            },
        },
    },
    opts_extend = { "sources.default" },
}
