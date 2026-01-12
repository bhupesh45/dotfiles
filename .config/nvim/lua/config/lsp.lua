local servers = {
    "lua_ls",
    "ts_ls",
    "vtsls",
    -- "biome",
    "html",
    "cssls",
    -- "pyright",
    "pylsp",
    "bashls",
    "clangd",
    "emmet_language_server",
    "jdtls",
    -- "java_language_server",
    "jsonls",
    "eslint",
    "gopls",
}

vim.lsp.enable(servers)

vim.diagnostic.config {
    -- virtual_lines = true,
    virtual_text = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = true,
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = "ErrorMsg",
            [vim.diagnostic.severity.WARN] = "WarningMsg",
        },
    },
}
