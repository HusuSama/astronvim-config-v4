-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing
--

function keywords(...)
  local keys = vim.opt.iskeyword:get()
  for _, v in ipairs { ... } do
    table.insert(keys, v)
  end
  return keys
end

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        -- relativenumber = true, -- sets vim.opt.relativenumber
        -- number = true, -- sets vim.opt.number
        -- spell = false, -- sets vim.opt.spell
        -- signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        -- wrap = false, -- sets vim.opt.wrap
        -- set to true or false etc.
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "yes", -- sets vim.opt.signcolumn to auto
        wrap = false, -- sets vim.opt.wrap
        tabstop = 4,
        shiftwidth = 4,
        clipboard = "unnamedplus",
        linespace = 10,
        ignorecase = true,
        autoindent = true,
        iskeyword = keywords "-",
        -- undofile = true,
        -- undodir = "./"
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
        mapleader = " ", -- sets vim.g.mapleader
        -- maplocalleader = " ",
        autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
        cmp_enabled = true, -- enable completion at start
        autopairs_enabled = true, -- enable autopairs at start
        diagnostics_mode = 3, -- set the visibility of diagnostics in the UI (0=off, 1=only show in status line, 2=virtual text off, 3=all on)
        icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
        ui_notifications_enabled = true, -- disable notifications when toggling UI elements
        resession_enabled = false, -- enable experimental resession.nvim session management (will be default in AstroNvim v4)
        -- neovide_cursor_animation_length = 0,
        neovide_cursor_trail_size = 0.4,
        neovide_hide_mouse_when_typing = true,
        -- 自定义 vim-move 插件的功能键
        move_key_modifier = "",
        move_key_modifier_visualmode = "S",
        -- 设置 mundo 打开位置
        mundo_right = 1,
        mundo_close_on_revert = 1,
        mundo_width = 80,
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      n = {
        -- second key is the lefthand side of the map
        -- mappings seen under group name "Buffer"
        ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
        ["<C-s>"] = { "<cmd>w<cr>", desc = "保存" },
        ["<C-a>"] = { "ggVG", desc = "全选" },
        ["<leader>bD"] = {
          function()
            require("astrocore.status").heirline.buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Pick to close",
        },
        ["<A-l>"] = {
          function() require("astrocore.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
          desc = "Next buffer",
        },
        ["<A-h>"] = {
          function() require("astrocore.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
          desc = "Previous buffer",
        },
        -- 方法间移动，并进行居中处理
        ["<A-j>"] = "<cmd>norm ]m zz<cr>",
        ["<A-k>"] = "<cmd>norm [m zz<cr>",
        -- todo-comments 相关设置
        ["<leader>fT"] = { "<cmd>TodoTelescope<cr>", desc = "搜索TODO" },
        ["<leader>Tl"] = { "<cmd>TodoLocList<cr>", desc = "TODO列表" },
        ["<leader>Tq"] = { "<cmd>TodoQuickFix<cr>", desc = "TODO快速修复" },
        ["]t"] = {
          function() require("todo-comments").jump_next() end,
          desc = "跳到下一个TODO",
        },
        ["[t"] = {
          function() require("todo-comments").jump_prev() end,
          desc = "跳到上一个TODO",
        },
        -- tables with the `name` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        ["<leader>b"] = { name = "Buffers" },
        -- quick save
        -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
        ["<S-Enter>"] = { "o<Esc>", desc = "在下方创建空行" },
        ["<C-\\>"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
        ["<C-F12>"] = { function() require("aerial").toggle() end, desc = "Symbols outline" },
        ["<leader>fg"] = {
          function() require("telescope").extensions.live_grep_args.live_grep_args() end,
          desc = "telescope live grep args",
        },
        ["<leader>ZM"] = { "<cmd>ZenMode<cr>", desc = "Zen Mode" },
        -- ["K"] = { "<cmd>Lspsaga hover_doc<cr>", desc="Lspsaga hover_doc"},
        -- Overseer 的相关快捷方式
        ["<F10>"] = { "<cmd>OverseerToggle right<cr>", desc = "Overseer Toggle" },

        -- 使用黑洞寄存器使删除不进行数据剪切
        -- ["d"] = { "\"_d", desc="删除而不剪切"},
        ["x"] = { '"_x', desc = "删除单个字符不剪切" },
        ["dd"] = { '"_dd', desc = "删除一行不剪切" },
        ["d"] = { '"_d', desc = "删除不剪切" },
        ["D"] = { '"_D', desc = "删除不剪切" },
        ["X"] = { '"_X', desc = "删除不剪切" },

        -- LspRestart，将所有 <leader>R 开头的都作为重启某项服务的前缀
        ["<Leader>Rl"] = { "<cmd>LspRestart<cr>", desc = "重启LSP服务" },
        -- markmap 监听
        ["<leader>MW"] = {
          function()
            if vim.filetype.match { buf = 0 } ~= "markdown" then return end
            local current_file = vim.fn.expand "%"
            local command = "markmap -w " .. current_file
            local task = require("overseer.task").new {
              cmd = command,
              name = "MarkmapRunner",
              components = {
                { "on_complete_notify", statuses = { "success" } },
              },
            }
            task:start()
          end,
          desc = "markmap watch",
        },
      },
      t = {
        -- setting a mapping to false will disable it
        -- ["<esc>"] = false,
      },
      i = {
        ["<C-h>"] = { "<Left>" },
        ["<C-l>"] = { "<Right>" },
        ["<C-v>"] = { "<C-r>+" },
        ["<C-z>"] = { "<cmd>undo<cr>" },
        ["<C-s>"] = { "<cmd>w<cr>", desc = "write" },
        -- ["<C-Enter>"] = { function() require("luasnip").jump(1) end, desc = "luasnip向下跳转" },
        -- ["<C-S-Enter>"] = { function() require("luasnip").jump(-1) end, desc = "luasnip向上跳转" }
        ["<C-k>"] = { "<cmd>norm zz<cr>", desc = "norm zz" },
      },
      v = {
        ["<C-c>"] = { "y" },
        ["d"] = { '"_d', desc = "删除而不剪切" },
        -- ["x"] = { "\"_x", desc="删除不剪切"},
      },
    },
  },
}
