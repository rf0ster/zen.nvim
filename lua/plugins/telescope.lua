return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  dependencies = { "nvim-lua/plenary.nvim" },  -- Required dependency
  config = function()
    require("telescope").setup({
      defaults = {
        layout_config = {
          height = 0.8,
          width = 0.9,
          prompt_position = "top",
        },
        sorting_strategy = "ascending",
        border = true,
      },
    })
  end
}
