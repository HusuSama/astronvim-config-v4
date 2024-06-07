return {
    "simnalamburt/vim-mundo",
    cmd = { "MundoToggle" },
    event = "VeryLazy",
    keys = {
        {
            "<F5>",
            mode = { "n" },
            "<cmd>MundoToggle<cr>",
            desc = "MundoToggle"
        },
    }
}
