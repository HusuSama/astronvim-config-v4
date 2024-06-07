local actions = require("telescope.actions")
return {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
        return require("astrocore").extend_tbl(opts, {
            defaults = {
                mappings = {
                    i = {
                        ["<C-n>"] = actions.move_selection_next,
                        ["<C-p>"] = actions.move_selection_previous,
                        ["<Tab>"] = actions.move_selection_next,
                        ["<S-Tab>"] = actions.move_selection_previous,
                        ["<C-Up>"] = actions.cycle_history_prev,
                        ["<C-Down>"] = actions.cycle_history_next,
                    }
                }
            }
        })
    end
}
