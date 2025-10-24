return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "lua",
        "go",
        "c_sharp",
        "typescript",
        "javascript",
        "html",
        "css",
        "json",
        "bash",
        "yaml",
        "markdown",
        "markdown_inline",
        "vue"
      },
      highlight = {
        enable = true
      },
      indent = {
        enable = true
      },
    })
  end,
}

