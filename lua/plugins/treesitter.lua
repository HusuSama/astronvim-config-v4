return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- add more things to the ensure_installed table protecting against community packs modifying it
    opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
      -- "lua"
      "lua", "python", "go", "rust", "markdown", "yaml", "toml"
    })
    local object
    object = {
      move = {
        goto_next_start = {
          ["<A-j>"] = { query = "@function.outer", desc = "Next function start" },
        },
        goto_previous_start = {
          ["<A-k>"] = { query = "@function.outer", desc = "Previous function start" },
        },
      },
    }
    return require("astrocore").extend_tbl(opts, {
      highlight = {
        enable = true,
        disable = false,
      },
      -- textobjects = object,
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>",
          node_incremental = "<CR>",
          node_decremental = "<BS>"
        }
      },
    })
  end,
}
