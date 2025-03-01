-- Vim settings
vim.g.loaded_netrw = 1         -- disable netrw
vim.g.loaded_netrwPlugin = 1   -- disable netrw
vim.g.mapleader = " "          -- map leader for mapping <Leader>
vim.g.maplocalleader = "\\"    -- map local leader, just a second mapping shortcut? <LocalLeader>
vim.opt.number = true          -- displays line numbers
vim.opt.relativenumber = true  -- use relative numbbers from the cursor
vim.opt.tabstop = 4            -- how many spaces tabs are displayed as
vim.opt.softtabstop = 4        -- how many spaces tabs actually use
vim.opt.shiftwidth = 4         -- how many spaces the sfit command uses '>>' '<<'
vim.opt.expandtab = true       -- expand tabs to spaces
vim.opt.scrolloff = 8          -- how many lines remain above and/or below the cursor while scrolling

-- Installs the lazy nvim plugin manager on the machine.
-- Checks to see if the plugin already exists on the machine,
-- and if not it clones it into the correct directory.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end

-- Adds the lazy nvim plugin to the vim runtime path.
-- The runtime path contains a list of directories to 
-- search when looking for plugins. This guarantees
-- that lazy nvim is first plugin dir on that path,
-- and any code past this point can access that plugin
-- using 'require("lazy")'.
vim.opt.rtp:prepend(lazypath)

-- Setup lazy nvim
-- [Would not work if the previous line was missing]
require("lazy").setup({
  spec = {
    {
      -- Tells lazy nvim to install plugins found
      -- in the lua/plugins folder. The 'lua' prefix
      -- is assumed by lazy.
      import = "plugins"
    },
  },
  dev = {
    path = vim.fn.expand("~/dev/rf0ster"),
    fallback = false
  },
  -- Automatically check for updates when
  -- lazy nvim starts.
  checker = { enabled = true },

  -- Customize the look and feel of the
  -- lazy nvim window.
  ui = {
    size = { width = 0.9, height = 0.8 },
    border = "double",
    backdrop = 100
  }
})

-- Create a set of custom remaps to call the plugin APIs.
-- All of the plugin APIs can be called directly from 
-- Vim Command Line mode.
local noremap = { noremap = true, silent = true }

-- Vim keymaps
vim.keymap.set("n", "<leader>bp", "<cmd>bprevious<CR>", noremap) -- Go back one buffer
vim.keymap.set("n", "<leader>bn", "<cmd>bnext<CR>", noremap) -- Go forward one buffer

-- Lazy
vim.keymap.set("n", "<leader>ll", ":Lazy<CR>", noremap)

-- Mason
vim.keymap.set("n", "<leader>mm", ":Mason<CR>", noremap)

-- NvimTree
vim.keymap.set("n", "<leader>ee", ":NvimTreeToggle<CR>", noremap)
vim.keymap.set("n", "<leader>eo", ":NvimTreeOpen<CR>", noremap)
vim.keymap.set("n", "<leader>ec", ":NvimTreeClose<CR>", noremap)
vim.keymap.set("n", "<leader>ef", ":NvimTreeFindFile<CR>", noremap)
vim.keymap.set("n", "<leader>ew", "<C-w>w", noremap)

-- Telescope
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", noremap)
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", noremap)
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", noremap)

-- Dotnet
vim.keymap.set('n', '<leader>db', ':lua require"dotnet.cli".build()<CR>', noremap)
vim.keymap.set('n', '<leader>dc', ':lua require"dotnet.cli".clean()<CR>', noremap)
vim.keymap.set('n', '<leader>dr', ':lua require"dotnet.cli".restore()<CR>', noremap)
vim.keymap.set('n', '<leader>dh', ':lua require"dotnet.cli".open_history()<CR>', noremap)
vim.keymap.set('n', '<leader>dl', ':lua require"dotnet.cli".run_last_cmd()<CR>', noremap)

vim.keymap.set('n', '<leader>ds', ':Dotnet solution<CR>', noremap)
vim.keymap.set('n', '<leader>dp', ':Dotnet projects<CR>', noremap)
vim.keymap.set('n', '<leader>dt', ':Dotnet tests<CR>', noremap)

-- Recall
vim.keymap.set("n", "<leader>r", ":Recall<CR>", noremap)


require("threading")
