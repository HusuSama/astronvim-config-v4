return {
  "L3MON4D3/LuaSnip",
  config = function(plugin, opts)
    require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
    require("luasnip.loaders.from_lua").lazy_load {
      paths = { vim.fn.stdpath "config" .. "/lua/snippets" },
    }
  end,
  keys = {
    {
      "<C-Enter>",
      mode = { "i" },
      "<Plug>luasnip-expand-or-jump",
      desc = "luasnip expand or jump",
    },
    -- 针对 select 模式，输入模式在 polish 中动态设置
    {
      "<Tab>",
      mode = { "s" },
      [[<cmd>lua require("luasnip").jump(1)<cr>]],
      desc = "luasnip jump next",
    },
    {
      "<S-Tab>",
      mode = { "s" },
      [[<cmd>lua require("luasnip").jump(-1)<cr>]],
      desc = "luasnip jump prev",
    },
  },
}
