return {
  {
    "williamboman/mason-lspconfig.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "tailwindcss" })
    end,
  },
  {
    "luckasRanarison/tailwind-tools.nvim",
    optional = true,
    event = "LspAttach",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
}
