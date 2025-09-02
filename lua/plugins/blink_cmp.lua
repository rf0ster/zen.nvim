return {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "1.*",
    opts = {
        keymap = {
            preset = "default",
            ["<CR>"] = { "accept", "fallback" },
            ["<C><leader>"] = { "show" }
        },
        fuzzy = {
            implementation = "prefer_rust_with_warning"
        },
        completion = {
            menu = {
                border = "rounded"
            }
        }
    }
}
