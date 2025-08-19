return {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("cyberdream").setup({
            cache = true,
            transparent = true,
            borderless_pickers = false,
            italic_comments = true,
            extensions = {
                lazy = true,
                telescope = true
            }
        })

        vim.cmd("colorscheme cyberdream")
    end
}


