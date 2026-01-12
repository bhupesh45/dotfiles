return {
    "saghen/blink.cmp",
    event = "InsertEnter",
    -- optional: provides snippets for the snippet source
    dependencies = "rafamadriz/friendly-snippets",

    version = "*",

    opts = {
        keymap = { preset = "super-tab" },

        appearance = {
            nerd_font_variant = "mono",
        },

        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
            min_keyword_length = function(ctx)
                -- only applies when typing a command, doesn't apply to arguments
                if ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil then
                    return 2
                end
                return 0
            end,
        },

        -- Enable border and disable auto show for cmdline
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
            -- window = {
            --     show_documentation = false,
            -- },
        },

        fuzzy = {
            implementation = "prefer_rust_with_warning",
            sorts = {
                "exact",
                -- defaults
                "score",
                "sort_text",
            },
        },
    },
    opts_extend = { "sources.default" },
}
