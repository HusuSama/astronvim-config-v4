return {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
        return require("astrocore").extend_tbl(opts, {
            window = {
                width = 50,
            }
        })
    end
}
