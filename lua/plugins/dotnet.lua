return {
    "rf0ster/dotnet.nvim",
    dev = false,
    cmd = "Dotnet",
    config = function()
        require("dotnet").setup({})
    end
}
