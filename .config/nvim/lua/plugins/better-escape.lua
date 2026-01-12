return {
    "max397574/better-escape.nvim",
    -- lazy = true,
    -- events = { "BufReadPre", "BufNewFile" },
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        require("better_escape").setup()
    end,
}
