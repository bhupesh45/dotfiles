return {
    "mfussenegger/nvim-lint",
    lazy = false,
    events = { "BufReadPre", "BufNewFile" },
    config = function()
        local lint = require "lint"

        lint.linters_by_ft = {
            javascript = { "eslint" },
            -- javascript = { "biomejs" },
            -- typescript = { "biomejs" },
            typescript = { "eslint" },
            javascriptreact = { "eslint" },
            -- javascriptreact = { "biomejs" },
            -- typescriptreact = { "biomejs" },
            typescriptreact = { "eslint" },
            svelte = { "eslint_d" },
            -- python = { "flake8" },
            -- python = { "pylint" },
            -- java = { "checkstyle" },
        }

        local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "TextChanged"}, {
            group = lint_augroup,
            callback = function()
                lint.try_lint()
            end,
        })

        vim.keymap.set("n", "<leader>l", function()
            lint.try_lint()
        end, { desc = "Trigger linting for current file" })
    end,
}
