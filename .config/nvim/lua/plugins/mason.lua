return {
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
        lazy = false,
        build = ":MasonUpdate",
        opts_extend = { "ensure_installed" },
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
            ensure_installed = {
                "shfmt", -- bash formatter
                "prettier", -- prettier formatter
                "prettierd", -- prettierd formatter
                "stylua", -- lua formatter
                "isort", -- python formatter
                "black", -- python formatter
                "pylint", -- python linter
                "eslint_d", -- js linter
            },
        },
    },
    -- {
    --     "williamboman/mason-lspconfig.nvim",
    --     event = { "BufReadPost", "BufNewFile" },
    --     opts = {
    --         ensure_installed = {
    --             "jsonls",
    --             "eslint",
    --             "bashls",
    --             "clangd",
    --             -- "cssls",
    --             -- "html",
    --             "emmet_language_server",
    --             "lua_ls",
    --             -- "pyright",
    --             "pylsp",
    --             "vtsls",
    --             -- "ts_ls",
    --             "jdtls",
    --             -- "harper_ls",
    --         },
    --     },
    --     automatic_enable = true,
    --     config = function()
    --         require("mason-lspconfig").setup {
    --             handlers = {
    --                 -- Configuration for java
    --                 jdtls = function()
    --                     require("java").setup {
    --                         -- Your custom jdtls settings goes here
    --                     }
    --
    --                     require("lspconfig").jdtls.setup {
    --                         -- Your custom nvim-java configuration goes here
    --                     }
    --                 end,
    --             },
    --         }
    --     end,
    -- },
    --     {
    --         "neovim/nvim-lspconfig",
    --         event = { "BufReadPost", "BufNewFile" },
    --         config = function()
    --             local lspconfig = require "lspconfig"
    --             -- local capabilities = require("cmp_nvim_lsp").default_capabilities()
    --             local capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
    --             local servers = {
    --                 "lua_ls",
    --                 -- "ts_ls",
    --                 -- "vtsls",
    --                 "html",
    --                 "cssls",
    --                 -- "pyright",
    --                 "pylsp",
    --                 "bashls",
    --                 "clangd",
    --                 "emmet_language_server",
    --                 "jdtls",
    --                 "jsonls",
    --                 "eslint",
    --             }
    --             local on_attach = function(_, bufnr)
    --                 local opts = { buffer = bufnr, silent = true }
    --             end
    --
    --             for _, lsp in ipairs(servers) do
    --                 lspconfig[lsp].setup {
    --                     capabilities = capabilities,
    --                     on_attach = on_attach,
    --                 }
    --             end
    --
    --             lspconfig.pylsp.setup {
    --                 settings = {
    --                     pylsp = {
    --                         plugins = {
    --                             pycodestyle = { enabled = false },
    --                             flake8 = { enabled = true, ignore = { "E501" } },
    --                         },
    --                     },
    --                 },
    --             }
    --
    --             lspconfig.jdtls.setup {
    --                 settings = {
    --                     java = {
    --                         inlayHints = {
    --                             parameterNames = {
    --                                 enabled = "all",
    --                             },
    --                         },
    --                     },
    --                 },
    --             }
    --
    --             lspconfig.lua_ls.setup {
    --                 settings = {
    --                     Lua = {
    --                         hint = {
    --                             enable = true,
    --                         },
    --                     },
    --                 },
    --             }
    --         end,
    --         keys = {
    --             { "gd", vim.lsp.buf.definition, desc = "Got to Definition" },
    --             { "K", vim.lsp.buf.hover, desc = "Hover" },
    --             { mode = { "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, desc = "Code Actions" },
    --         },
    --     },
}
