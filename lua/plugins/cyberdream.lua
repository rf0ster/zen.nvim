return {
  "scottmckendry/cyberdream.nvim",
  lazy = false,
  config = function()
    require("cyberdream").setup({
      cache = true,
      transparent = true,
      borderless_pickers = false,
      extensions = {
        lazy = true,
        telescope = true
      }
    })

   vim.cmd("colorscheme cyberdream")
  end
}
