return {
    "junegunn/vim-easy-align",
    event = "User AstroFile",
    cmd = "EasyAlign",
    keys = {
        {
            "ga",
            mode = { "n", "x", "v" },
            "<Plug>(EasyAlign)",
            desc = "EasyAlign"
        }
    }
}
