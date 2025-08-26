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
        appearance = {
            nerd_font_variation = "mono"
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
