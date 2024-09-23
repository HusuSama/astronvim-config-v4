return {
  "nvimdev/lspsaga.nvim",
  cmd = { "Lspsaga" },
  event = "LspAttach",
  config = function()
    require("lspsaga").setup {
      symbol_in_winbar = {
        enable = true,
        separator = " › ",
        hide_keyword = false,
        show_file = true,
        folder_level = 1,
        color_mode = true,
        delay = 300,
      },
      lightbulbs = {
        enable = true,
        sign = true,
        virtual_text = true,
        debounce = 10,
        sign_priority = 40,
      },
      outline = {
        -- win_position = "right",
        -- win_width = 40,
        -- auto_preview = true,
        -- detail = true,
        -- auto_close = true,
        -- close_after_jump = false,
        layout = "float",
        max_height = 0.5,
        left_width = 0.3,
        keys = {
          jump = "<Enter>",
          toggle_or_jump = "o",
          quit = "q",
        },
      },
      callhierarchy = {
        keys = {
          edit = "<Enter>",
          vsplit = "|",
          split = "\\",
          tabe = "t",
          quit = "q",
          -- shuttle = '[w',
          shuttle = "<C-l>",
          toggle_or_req = "u",
          close = "<C-c>k",
        },
      },
    }
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    {
      "]e",
      mode = { "n" },
      "<cmd>Lspsaga diagnostic_jump_next<cr>",
      desc = "lspsaga goto next error",
    },
    {
      "[e",
      mode = { "n" },
      "<cmd>Lspsaga diagnostic_jump_prev<cr>",
      desc = "lspsaga goto prev error",
    },
    -- {
    --     "<F12>",
    --     mode = { "n" },
    --     "<cmd>Lspsaga outline<cr>",
    --     desc = "lspsaga outline"
    -- },
    {
      "<leader>I",
      mode = { "n" },
      "<cmd>Lspsaga incoming_calls<cr>",
      desc = "lspsaga incoming_calls",
    },
    {
      "<leader>O",
      mode = { "n" },
      "<cmd>Lspsaga outgoing_calls<cr>",
      desc = "lspsaga outgoing_calls",
    },
    {
      "K",
      mode = { "n" },
      "<cmd>Lspsaga hover_doc<cr>",
      desc = "lspsaga hover_doc",
    },
  },
}
