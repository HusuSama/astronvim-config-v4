local utils = require "astrocore"
return {
    {
        "rcarriga/nvim-notify",
        opts = function(_, opts)
            opts.timeout = 300
            opts.stages = "slide"
        end
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        -- event = "VimEnter",
        -- cond = not vim.g.neovide,
        dependencies = { "MunifTanjim/nui.nvim" },
        opts = function(_, opts)
            return utils.extend_tbl(opts, {
                notify = {
                    enabled = false,
                },
                lsp = {
                    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                    hover = {
                        enabled = false,
                    },
                    signature = {
                        enabled = false
                    }
                },
                presets = {
                    bottom_search = false,                             -- use a classic bottom cmdline for search
                    command_palette = true,                            -- position the cmdline and popupmenu together
                    long_message_to_split = true,                      -- long messages will be sent to a split
                    inc_rename = utils.is_available "inc-rename.nvim", -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = false,                            -- add a border to hover docs and signature help
                },
            })
        end,
        init = function() vim.g.lsp_handlers_enabled = false end,
    },
    {
        "folke/edgy.nvim",
        optional = true,
        opts = function(_, opts)
            if not opts.bottom then opts.bottom = {} end
            table.insert(opts.bottom, {
                ft = "noice",
                size = { height = 0.4 },
                filter = function(_, win) return vim.api.nvim_win_get_config(win).relative == "" end,
            })
        end,
    },
    {
        "catppuccin/nvim",
        optional = true,
        opts = { integrations = { noice = true } },
    },
}
