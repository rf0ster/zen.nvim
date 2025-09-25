return {
    "nvimdev/lspsaga.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "nvim-treesitter/nvim-treesitter",
    },
    after = "nvim-lspconfig",
    config = function()
        require("lspsaga").setup({
            lightbulb = {
                enable = false,
            }
        })

        local noremap = { noremap = true, silent = true }
        vim.keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>", noremap)
        vim.keymap.set("n", "gr", "<cmd>Lspsaga finder<CR>", noremap)
        vim.keymap.set("n", "gt", "<cmd>Lspsaga goto_type_definition<CR>", noremap)
        vim.keymap.set("n", "gi", "<cmd>Lspsaga finder imp<CR>", noremap)
        vim.keymap.set("n", "ga", vim.lsp.buf.code_action, noremap)
        vim.keymap.set("n", "rn", "<cmd>Lspsaga rename<CR>", noremap)

        vim.keymap.set("n", "<leader>lh", function()
            local bufnr = vim.api.nvim_create_buf(false, true)
            -- Write some text to the buffer
            vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {
                " *** LSP Saga Keybindings ***",
                " gd -> Go to definition.",
                " gr -> Show references, definitions, implementations, and type definitions.",
                " gt -> Go to type definition.",
                " gi -> Show implementations.",
                " ga -> Show code actions.",
                " rn -> Rename symbol.",
            })

            vim.api.nvim_open_win(bufnr, true, {
                relative = "editor",
                width = 80,
                height = 7,
                row = 1,
                col = 1,
                style = "minimal",
                border = "rounded",
            })

        end, noremap)
    end,
}
