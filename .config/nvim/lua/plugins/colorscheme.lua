-- return {
--     "Skardyy/makurai-nvim",
--     lazy = false,
--     priority = 1000,
--     config = function()
--         -- you don't have to call setup
--         require("makurai").setup {
--             transparent = false, -- removes the bg color
--         }
--
--         require("makurai").modify("dark", {
--             line = "#4493F8",
--             LineNr = "#FFFFFF",
--             cursor = "#2F334D",
--         })
--
--         vim.cmd.colorscheme "makurai_dark"
--     end,
-- }

-- return {
--     "sainnhe/sonokai",
--     lazy = false,
--     priority = 1000,
--     config = function()
--         -- require("sonokai").setup {}
--         vim.g.sonokai_style = "shusia"
--         vim.g.sonokai_enable_italic = true
--         vim.cmd.colorscheme "sonokai"
--     end,
-- }

-- return {
--     "tiagovla/tokyodark.nvim",
--     opts = {
--         -- custom options here
--     },
--     config = function(_, opts)
--         require("tokyodark").setup(opts) -- calling setup is optional
--         vim.cmd [[colorscheme tokyodark]]
--     end,
-- }

return {
    "loctvl842/monokai-pro.nvim",
    config = function()
        require("monokai-pro").setup {
            transparent_background = false,
            terminal_colors = true,
            devicons = true, -- highlight the icons of `nvim-web-devicons`
            styles = {
                comment = { italic = true },
                keyword = { italic = true }, -- any other keyword
                type = { italic = true }, -- (preferred) int, long, char, etc
                storageclass = { italic = true }, -- static, register, volatile, etc
                structure = { italic = true }, -- struct, union, enum, etc
                parameter = { italic = true }, -- parameter pass in function
                annotation = { italic = true },
                tag_attribute = { italic = true }, -- attribute of tag in reactjs
            },
            filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
            -- Enable this will disable filter option
            day_night = {
                enable = false, -- turn off by default
                day_filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
                night_filter = "spectrum", -- classic | octagon | pro | machine | ristretto | spectrum
            },
            inc_search = "background", -- underline | background
            background_clear = {
                "float_win",
                "toggleterm",
                "telescope",
                -- "which-key",
                "renamer",
                "notify",
                -- "nvim-tree",
                -- "neo-tree",
                -- "bufferline", -- better used if background of `neo-tree` or `nvim-tree` is cleared
            }, -- "float_win", "toggleterm", "telescope", "which-key", "renamer", "neo-tree", "nvim-tree", "bufferline"
            plugins = {
                bufferline = {
                    underline_selected = false,
                    underline_visible = false,
                },
                indent_blankline = {
                    context_highlight = "default", -- default | pro
                    context_start_underline = false,
                },
            },
            overrideScheme = function(cs, p, config, hp)
                local cs_override = {}
                local calc_bg = hp.blend(p.background, 0.5, "#000000")

                cs_override.editor = {
                    background = calc_bg,
                }
                return cs_override
            end,
        }
        vim.cmd.colorscheme "monokai-pro"
    end,
}

-- return {
--     "loctvl842/monokai-pro.nvim",
--     lazy = false,
--     priority = 1000,
--     override = function(c)
--         local hp = require "monokai-pro.color_helper"
--         local common_fg = hp.lighten(c.sideBar.foreground, 30)
--         return {
--             SnacksPicker = { bg = c.editor.background, fg = common_fg },
--             SnacksPickerBorder = { bg = c.editor.background, fg = c.tab.unfocusedActiveBorder },
--             SnacksPickerTree = { fg = c.editorLineNumber.foreground },
--             NonText = { fg = c.base.dimmed3 }, -- not sure if this should be broken into all hl groups importing NonText
--         }
--     end,
--     config = function()
--         require("monokai-pro").setup {
--             transparent_background = false,
--             terminal_colors = true,
--             devicons = true, -- highlight the icons of `nvim-web-devicons`
--             styles = {
--                 comment = { italic = true },
--                 keyword = { italic = true }, -- any other keyword
--                 type = { italic = true }, -- (preferred) int, long, char, etc
--                 storageclass = { italic = true }, -- static, register, volatile, etc
--                 structure = { italic = true }, -- struct, union, enum, etc
--                 parameter = { italic = true }, -- parameter pass in function
--                 annotation = { italic = true },
--                 tag_attribute = { italic = true }, -- attribute of tag in reactjs
--             },
--             filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
--             -- Enable this will disable filter option
--             day_night = {
--                 enable = false, -- turn off by default
--                 day_filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
--                 night_filter = "spectrum", -- classic | octagon | pro | machine | ristretto | spectrum
--             },
--             inc_search = "background", -- underline | background
--             background_clear = {
--                 -- "float_win",
--                 "toggleterm",
--                 "telescope",
--                 "snacks",
--                 -- "which-key",
--                 "renamer",
--                 "notify",
--                 -- "nvim-tree",
--                 -- "neo-tree",
--                 -- "bufferline", -- better used if background of `neo-tree` or `nvim-tree` is cleared
--             }, -- "float_win", "toggleterm", "telescope", "which-key", "renamer", "neo-tree", "nvim-tree", "bufferline"
--             plugins = {
--                 bufferline = {
--                     underline_selected = false,
--                     underline_visible = false,
--                 },
--                 indent_blankline = {
--                     context_highlight = "pro", -- default | pro
--                     context_start_underline = false,
--                 },
--             },
--             ------@param c Colorscheme
--             ---override = function(c) end,
--             ------@param cs Colorscheme
--             ------@param p ColorschemeOptions
--             ------@param Config MonokaiProOptions
--             ------@param hp Helper
--             ---override = function(cs: Colorscheme, p: ColorschemeOptions, Config: MonokaiProOptions, hp: Helper) end,
--         }
--
--         vim.cmd.colorscheme "monokai-pro"
--     end,
-- }
