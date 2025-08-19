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
    end,
}
