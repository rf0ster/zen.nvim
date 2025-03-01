return {
    "rf0ster/dotnet.nvim",
    dev = true,
    cmd = "Dotnet",
    config = function()
        require("dotnet").setup({})
    end
}
