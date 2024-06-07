return {
  "stevearc/aerial.nvim",
  opts = function(_, opts)
    return require("astrocore").extend_tbl(opts, {
    	disable_max_lines = 10000,
    	disable_max_size = 2000000,
    })
  end,
}
