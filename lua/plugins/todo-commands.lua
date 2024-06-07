return {
    "folke/todo-comments.nvim",
    opts = function(_, opts)
        return require("astrocore").extend_tbl(opts, {
            keywords = {
                FIX = {
                    icon = "🪲",
                    color = "#fd5a3e",
                    alt = { "FIXME", "BUG", "FIXIT", "ISSUE", "fixme" },
                },
                TODO = {
                    icon = "👀",
                    color = "#97cc64",
                    alt = { "todo" },
                },
                NOTE = {
                    icon = "🖊️",
                    color = "#4682b4",
                    alt = { "INFO" },
                },
                WARM = {
                    icon = "⚠️",
                    color = "#ffd050",
                    alt = { "WARNING", "XXX" },
                },
                TEST = {
                    icon = "⏲️",
                    color = "#d35ebe",
                    alt = { "TESTING", "PASSED", "FAILED" },
                },
            },
            highlight = {
                comments_only = true,
            },
        })
    end
}
