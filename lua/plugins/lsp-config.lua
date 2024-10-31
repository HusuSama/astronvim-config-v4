return {
  "AstroNvim/astrolsp",
  optional = true,
  opts = {
    config = {
      basedpyright = {
        settings = {
          basedpyright = {
            disableOrganizeImports = true,
            analysis = {
              ignore = { "*" },
            },
          },
        },
      },
      -- ruff = {
      --   trace = "messages",
      --   init_options = {
      --     settings = {
      --       logLevel = "debug",
      --     },
      --   },
      -- },
    },
  },
}
