return {
    "AckslD/nvim-neoclip.lua",
    opts = function(_, opts)
        return require("astrocore").extend_tbl(opts, {
            keys = {
                telescope = {
                    i = {
                        select = '<cr>',
                        paste = '<cr>',
                        paste_behind = '<cr>',
                        replay = '<c-q>', -- replay a macro
                        delete = '<c-d>', -- delete an entry
                        edit = '<c-e>',   -- edit an entry
                        custom = {},
                    },
                    n = {
                        select = "<cr>",
                        paste = "<cr>",
                        paste_behind = "<cr>",
                        replay = "q",
                        delete = "d",
                        edit = "e",
                        cutome = {},
                    },
                }
            }
        })
    end
}
