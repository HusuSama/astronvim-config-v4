return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      local utils = require("astrocore")
      local lspkind = require("lspkind")
      opts.sources = cmp.config.sources {
        {
          name = "nvim_lsp",
          priority = 1000,
          entry_filter = function(entry, ctx)
            return require("cmp.types").lsp.CompletionItemKind[entry:get_kind()] ~= "Text"
          end
        },
        { name = "luasnip", priority = 750 },
        { name = "path",    priority = 250 },
        { name = "codeium" }
      }
      return utils.extend_tbl(opts, {
        formatting = {
          -- fields = {"abbr", "kind", "menu"},
          format = lspkind.cmp_format({
            -- mode = "symbol",
            mode = "symbol_text",
            -- mode = "text_symbol",
            minwidth = 60,
            maxwidth = 80,
            ellipsis_char = "..."
          })
        },
        mapping = {
          ["<Up>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
          ["<Down>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
          ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
          ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
          ["<C-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
          ["<C-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
          ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
          ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
          ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
          ["<C-y>"] = cmp.config.disable,
          -- ["<C-z>"] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close() },
          ["<C-e>"] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close() },
          ["<CR>"] = cmp.mapping.confirm { select = false },
          ["<Tab>"] = cmp.mapping.confirm { select = true },
        },
        sorting = {
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            function(entry1, entry2)
              local _, entry1_under = entry1.completion_item.label:find "^_+"
              local _, entry2_under = entry2.completion_item.label:find "^_+"
              entry1_under = entry1_under or 0
              entry2_under = entry2_under or 0
              if entry1_under > entry2_under then
                return false
              elseif entry1_under < entry2_under then
                return true
              end
            end,
            -- 提升关键字的优先级
            function(entry1, entry2)
              local kind1 = entry1.completion_item.kind
              local kind2 = entry2.completion_item.kind
              kind1 = kind1 or 0
              kind2 = kind2 or 0
              if kind1 ~= kind2 then
                if require("cmp.types").lsp.CompletionItemKind[kind1] == "Keyword" then
                  -- if kind1 == 14 then
                  return true
                elseif require("cmp.types").lsp.CompletionItemKind[kind1] == "Snippet" then
                  return false
                else
                  return false
                end
              end
            end,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
      })
    end
  }
}
