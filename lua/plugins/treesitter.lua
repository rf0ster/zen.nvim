return {
  "nvim-treesitter/nvim-treesitter",
  event = "VeryLazy",
  run = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "lua", "go", "c_sharp" },
      highlight = {
        enable = true
      },
      indent = {
        enable = true
      },
    })
  end,
}
