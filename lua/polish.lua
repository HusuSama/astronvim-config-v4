if true then return end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes
vim.filetype.add {
  extension = {
    foo = "fooscript",
  },
  filename = {
    ["Foofile"] = "fooscript",
  },
  pattern = {
    ["~/%.config/foo/.*"] = "fooscript",
  },
}

-- 计算python的执行命令，如果没有打开过 toggleterm 将进行 PYTHONPATH 环境配置
function match_pycmd()
    local state = require("neo-tree.sources.manager").get_state("filesystem")
    local project_path = state.path
    local terminals = require("toggleterm.terminal").get_all(true)
    local pycmd = "python %"
    if (terminals == nil) or (#terminals == 0) then
        pycmd = string.format("set PYTHONPATH=%s && python %%", project_path)
    end
    local cmd = string.format("<cmd>TermExec direction=float cmd=\"%s\"<cr>", pycmd)
    return cmd
end

-- 计算当前设备可用的命令行工具
function match_terminal()
    local stdout = vim.fn.system("pwsh --version")
    local version = string.match(stdout, [[%d+%.%d+%.%d+]])
    if version == nil then
        term = "cmd"
    else
        term = "pwsh"
    end
    return term
end

-- 创建通过外部命令行运行的脚本
function match_py_outer_cmd()
    local term = match_terminal()
    local pycmd = ""
    if term == "pwsh" then
        pycmd = "<cmd>!start pwsh -NoExit -c \"py %\"<cr>"
    else
        pycmd = "<cmd>!start cmd /K \"py %\"<cr>"
    end
    return pycmd
end

-- 非 python 文件的运行命令配置
function match_others(cmd)
    script = string.format("<cmd>TermExec direction=float cmd=\"%s\"<cr>", cmd)
    return script
end

function match_others_outer(cmd)
    local term = match_terminal()
    local script
    if term == "pwsh" then
        script = string.format("<cmd>!start pwsh -NoExit -c \"%s\"<cr>", cmd)
    else
        script = string.format("<cmd>!start cmd /K \"%s\"", cmd)
    end
    return script
end

-- 打开外部 terminal 配置，可以自定义设置不同 terminal 名称
function open_outer_terminal(terminal_name)
    local stdout = vim.fn.system("pwsh --version")
    if terminal_name == nil then
        local version = string.match(stdout, [[%d+%.%d+%.%d+]])
        if version == nil then
            term = "cmd"
        else
            term = "pwsh"
        end
    else
        term = terminal_name
    end
    local is_win = vim.fn.has("win32")
    local script = ""
    if is_win then
        script = string.format("<cmd>!start %s<cr>", term)
    else
        script = "only Windows"
    end
    return script
end

-- 如果当前编辑器为 neovide，当进入普通模式时，将自动切换英文输入法
function set_ime(args)
    if vim.g.neovide then
        if args.event:match("Enter$") then
            vim.g.neovide_input_ime = true
        else
            vim.g.neovide_input_ime = false
        end
    end
end

-- 删除luasnip映射方法
function remove_tab()
    vim.api.nvim_buf_del_keymap(
        0,
        "i",
        "<Tab>"
    )
    vim.api.nvim_buf_del_keymap(
        0,
        "i",
        "<S-Tab>"
    )
end

function call_remove()
    pcall(remove_tab)
end

return {
    -- 针对不同文件配置不同的运行命令
    vim.api.nvim_create_autocmd("BufEnter", {
        desc = "QuickRunner",
        pattern = "*",
        group = vim.api.nvim_create_augroup("QuickRunner", { clear = true }),
        callback = function()
            local filetype = vim.filetype.match({ buf = 0 })
            if filetype == "python" then
                vim.api.nvim_buf_set_keymap(
                    0,
                    "n",
                    "<C-S-F10>",
                    match_pycmd(),
                    { silent = true, noremap = true }
                )
                vim.api.nvim_buf_set_keymap(
                    0,
                    "n",
                    "<C-S-A-F10>",
                    match_py_outer_cmd(),
                    { silent = true, noremap = true }
                )
            elseif filetype == "markdown" then
                vim.api.nvim_buf_set_keymap(
                    0,
                    "n",
                    "<C-S-F10>",
                    "<cmd>MarkdownPreviewToggle<cr>",
                    { silent = true, noremap = true }
                )
            elseif filetype == "go" then
                vim.api.nvim_buf_set_keymap(
                    0,
                    "n",
                    "<C-S-F10>",
                    -- "<cmd>go run .<cr>",
                    match_others("go run ."),
                    { silent = true, noremap = true }
                )
                vim.api.nvim_buf_set_keymap(
                    0,
                    "n",
                    "<C-S-A-F10>",
                    -- "<cmd>go run .<cr>",
                    match_others_outer("go run ."),
                    { silent = true, noremap = true }
                )
            elseif filetype == "rust" then
                vim.api.nvim_buf_set_keymap(
                    0,
                    "n",
                    "<C-S-F10>",
                    match_others("cargo run ."),
                    { silent = true, noremap = true }
                )
                vim.api.nvim_buf_set_keymap(
                    0,
                    "n",
                    "<C-S-A-F10>",
                    match_others_outer("cargo run ."),
                    { silent = true, noremap = true }
                )
            end
        end
    }),

    -- 使用 neovide 时，可以自动切换中英文输入
    vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("ime_input", { clear = true }),
        pattern = "*",
        callback = set_ime
    }),

    -- 对 terminal界面简化操作，ESC回到普通模式，直接可以切换窗口
    vim.api.nvim_create_autocmd({ "TermOpen" }, {
        group = vim.api.nvim_create_augroup("term_mapping", { clear = true }),
        pattern = "term://*",
        callback = function()
            local opts = { buffer = 0 }
            vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
            vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
        end
    }),

    -- 打开外部 terminal 方案，仅对 windows 设备有效，Shift + F7
    vim.api.nvim_create_autocmd({ "VimEnter" }, {
        group = vim.api.nvim_create_augroup("open_outer", { clear = true }),
        pattern = "*",
        callback = function()
            if vim.fn.has("win32") then
                vim.api.nvim_set_keymap(
                    "n",
                    "<S-F7>",
                    open_outer_terminal(nil),
                    { silent = true, noremap = true }
                )
                vim.api.nvim_set_keymap(
                    "n",
                    "<leader>E",
                    "<cmd>!explorer .<cr>",
                    { silent = true, noremap = true }
                )
            end
        end
    }),

    -- 自定义LuaSnip跳转快捷键
    -- InsertEnter set tab to jump next
    -- InsertLeave delete tab keymap
    vim.api.nvim_create_autocmd("InsertEnter", {
        group = vim.api.nvim_create_augroup("snip_mapping", { clear = true }),
        pattern = "*",
        callback = function()
            local snip = require("luasnip")
            if snip.in_snippet() then
                vim.api.nvim_buf_set_keymap(
                    0,
                    "i",
                    "<Tab>",
                    [[<cmd>lua require("luasnip").jump(1)<cr>]],
                    { silent = true, noremap = true }
                )
                vim.api.nvim_buf_set_keymap(
                    0,
                    "i",
                    "<S-Tab>",
                    -- snip.jump(-1),
                    [[<cmd>lua require("luasnip").jump(-1)<cr>]],
                    { silent = true, noremap = true }
                )
            end
        end
    }),
    vim.api.nvim_create_autocmd("InsertLeave", {
        group = vim.api.nvim_create_augroup("del_snip_mapping", { clear = true }),
        pattern = "*",
        callback = call_remove
    }),
    vim.api.nvim_create_autocmd(
        { 'BufNewFile', 'BufRead' }, 
        { group = vim.api.nvim_create_augroup("hocon", { clear = true }), pattern = '*/resources/*.conf', command = 'set ft=hocon' }
    )
}
