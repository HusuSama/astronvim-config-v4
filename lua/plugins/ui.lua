return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        opts = {
            integrations = {
                alpha = true,
                aerial = true,
                dap = { enabled = true, enable_ui = true },
                mason = true,
                neotree = true,
                notify = true,
                nvimtree = true,
                semantic_tokens = true,
                symbols_outline = true,
                telescope = true,
                ts_rainbow = false,
                which_key = true,
                treesitter = true,
                gitsigns = true,
                cmp = true,
            },
            no_italic = true,
            no_underline = true,
            styles = {
                comments = {},
                conditionals = {},
                loops = {},
                functions = {},
                keywords = {},
                strings = {},
                variables = {},
                numbers = {},
                booleans = {},
                properties = {},
                types = {},
                operators = {},
            },
        },
    },
    {
        "nvim-telescope/telescope.nvim",
        optional = true,
        opts = {
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
        },
    },
    {
        "folke/zen-mode.nvim",
        opts = function(_, opts)
            return require("astrocore").extend_tbl(opts, {
                plugins = {
                    options = {
                        relativenumber = true,
                    },
                    --     on_open = function(win)
                    --         require("indent_blankline").init()
                    --     end,
                }
            })
        end
    },
    {
        "folke/tokyonight.nvim",
        opts = function(_, opts)
            return require("astrocore").extend_tbl(opts, {
                styles = {
                    comments = { italic = false },
                    keywords = { italic = false }
                }
            })
        end
    },
}
