-- 优化 rust 包管理工具，提供依赖版本等提示
return {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        require('crates').setup()
    end,
}
