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
    },
  },
}
