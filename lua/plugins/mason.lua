-- customize mason plugins
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        "jsonls", "marksman", "sqlls", "taplo", "yamlls",
      })
      -- local lspconfig = require("lspconfig")
      -- local mason_reg = require("mason-registry")
      -- local vue_language_path = mason_reg.get_package("vue-language-server"):get_install_path() ..
      --     "/node_modules/@vue/language-server"
      -- require("mason-lspconfig").setup_handlers({
      --   function(server_name)
      --     lspconfig.tsserver.setup({
      --       init_options = {
      --         plugins = {
      --           {
      --             name = "@vue/typescript-plugin",
      --             location = vue_language_path,
      --             languages = { 'vue', 'typescript', 'javascript' }
      --           },
      --         },
      --       },
      --       filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
      --     })
      --   end
      -- })
    end
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        "stylua",
        -- add more arguments for adding more null-ls sources
      })
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        "python",
        -- add more arguments for adding more debuggers
      })
    end,
  },
}
