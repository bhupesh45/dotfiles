return {
    "stevearc/conform.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        default_format_opts = {
            timeout_ms = 500,
            async = false, -- not recommended to change
            quiet = false, -- not recommended to change
            lsp_format = "fallback", -- not recommended to change
        },
        formatters_by_ft = {
            lua = { "stylua" },
            -- Conform will run multiple formatters sequentially
            python = { "isort", "black" },
            -- You can customize some of the format options for the filetype (:help conform.format)
            rust = { "rustfmt", lsp_format = "fallback" },
            -- Conform will run the first available formatter
            javascript = { "prettierd", "prettier", stop_after_first = true },
            -- typescript = { "biomejs", "prettierd", "prettier", stop_after_first = true },
            typescript = { "biome" },
            javascriptreact = { "prettierd", "prettier", stop_after_first = true },
            -- typescriptreact = { "biomejs", "prettierd", "prettier", stop_after_first = true },
            typescriptreact = { "biome" },
            svelte = { "prettierd" },
            css = { "prettierd" },
            html = { "prettierd" },
            htmldjango = { "djlint" },
            json = { "prettierd" },
            yaml = { "prettierd" },
            markdown = { "prettierd" },
            graphql = { "prettierd" },
            java = { "google-java-format" },
        },
        formatters = {
            injected = { options = { ignore_errors = true } },
            -- # Example of using dprint only when a dprint.json file is present
            -- dprint = {
            --   condition = function(ctx)
            --     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
            --   end,
            -- },
            --
            -- # Example of using shfmt with extra args
            -- shfmt = {
            --   prepend_args = { "-i", "2", "-ci" },
            -- },
        },
    },
    keys = {
        {
            "<leader>fm",
            function()
                require("conform").format { timeout_ms = 500, async = true, lsp_fallback = true }
            end,
            mode = { "n", "v" },
            desc = "Format Buffer",
        },
    },
}
