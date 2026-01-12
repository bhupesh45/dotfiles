return {
    "hrsh7th/nvim-cmp",
    enabled=false,
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        {
            "garymjr/nvim-snippets",
            opts = {
                friendly_snippets = true,
            },
            dependencies = { "rafamadriz/friendly-snippets" },
        },
        "onsails/lspkind.nvim",
    },
    config = function()
        local cmp = require "cmp"
        local lspkind = require "lspkind"
        local cmp_autopairs = require "nvim-autopairs.completion.cmp"
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

        local options = {
            auto_brackets = {}, -- configure any filetype to auto add brackets
            completion = {
                completeopt = "menu,menuone,noinsert" .. (true and "" or ",noselect"),
            },
            snippet = {
                -- REQUIRED - you must specify a snippet engine
                expand = function(args)
                    vim.snippet.expand(args.body)
                end,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            formatting = {
                format = lspkind.cmp_format {
                    mode = "symbol_text", -- Show icons with text
                    maxwidth = 50, -- Truncate long entries
                    ellipsis_char = "...", -- Show ellipsis for truncated text
                    before = function(entry, vim_item)
                        -- Customize display
                        vim_item.menu = ({
                            nvim_lsp = "[LSP]",
                            luasnip = "[Snippet]",
                            buffer = "[Buffer]",
                            path = "[Path]",
                        })[entry.source.name]
                        return vim_item
                    end,
                },
            },
            mapping = cmp.mapping.preset.insert {
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
                ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm { select = true }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            },
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "snippets" },
                { name = "path" },
                -- { name = "luasnip" }, -- For luasnip users.
            }, {
                { name = "buffer" },
            }),
        }

        -- options = vim.tbl_deep_extend("force", options, require "nvchad.cmp")
        require("cmp").setup(options)
    end,
}
