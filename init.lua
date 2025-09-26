vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.scrolloff = 8
vim.o.winborder = "rounded"

-- Sets tls rules for copilot on windows
if vim.fn.has("win32") == 1 then
    vim.env.NODE_TLS_REJECT_UNAUTHORIZED = "0"
end

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
  -- Dev folder that can be referenced
  -- by plugins to load plugin from code
  -- rather than from a git repo.
  dev = {
    path = vim.fn.expand("~/dev/rf0ster"),
    fallback = false,
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

---------------
---  LSPs  ----
---------------
vim.lsp.config['luals'] = {
    cmd = { 'lua-language-server' },
    filetypes = { "lua" },
    settings = {
        Lua = {
            diagnostics = { globals = { "vim" } },
            runtime = { version = "LuaJIT" }
        }
    }
}
vim.lsp.config['gopls'] = {
    cmd = { 'gopls' },
    filetypes = { "go", "gomod" },
    settings = {
        gopls = {
            gofumpt = true,
            analyses = {
                unusedparams = true,
                shadow = true,
            },
            staticcheck = true,
        }
    }
}

vim.g.python3_host_prog = vim.fn.expand("~/.venvs/neovim/bin/python")
vim.lsp.config['pyright'] = {
    cmd = { 'pyright-langserver', '--stdio' },
    filetypes = { "python" },
    settings = {
        python = {
            venvPath = ".",
            venv = ".venv",
            analysis = {
                typeCheckingMode = "basic",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
            }
        }
    }
}

vim.lsp.enable('pyright')
vim.lsp.enable('luals')
vim.lsp.enable('gopls')

-- Delete neovim default keymaps for LSP in favor
-- of custom keymaps set in lspsaga.lua
vim.keymap.del("n", "grr")
vim.keymap.del("n", "grn")
vim.keymap.del("n", "gra")
vim.keymap.del("n", "gri")
--vim.keymap.del("n", "grt")

---------------
--- Keymaps ---
---------------
local noremap = { noremap = true, silent = true }
local noremapbuffer = { noremap = true, silent = true, buffer = true }

--- Generic ---
vim.keymap.set("n", "<leader>w", "<C-w>w", noremap)

--- Diagnostics ---
vim.diagnostic.config({
    signs = true
})
vim.keymap.set("n", "<leader>vd", function()
    local current = vim.diagnostic.config().virtual_lines
    if current then
        vim.diagnostic.config({ virtual_lines = false, signs = true })
    else
        vim.diagnostic.config({ virtual_lines = { only_current_line = true }, signs = true })
    end
end, { noremap = true, silent = true })


--- Lazy ---
vim.keymap.set("n", "<leader>ll", ":Lazy<CR>", noremap)

--- Nvim Tree ---
vim.keymap.set("n", "<leader>ee", ":NvimTreeToggle<CR>", noremap)
vim.keymap.set("n", "<leader>eo", ":NvimTreeOpen<CR>", noremap)
vim.keymap.set("n", "<leader>ec", ":NvimTreeClose<CR>", noremap)
vim.keymap.set("n", "<leader>ef", ":NvimTreeFindFile<CR>", noremap)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "NvimTree",
  callback = function()
        vim.keymap.set("n", "l", ":NvimTreeResize +10<CR>", noremapbuffer)
        vim.keymap.set("n", "h", ":NvimTreeResize -10<CR>", noremapbuffer)
  end,
})

-- Telescope
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", noremap)
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", noremap)
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", noremap)

-- GitSigns
vim.keymap.set("n", "<leader>sp", ":Gitsigns preview_hunk_inline<CR>", noremap)
vim.keymap.set("n", "<leader>sb", ":Gitsigns blame_line<CR>", noremap)
vim.keymap.set("n", "<leader>st", ":Gitsigns toggle_word_diff<CR>", noremap)

--- Recall ---
vim.keymap.set("n", "<leader>r", ":Recall<CR>", noremap)

--- Dotnet ---
vim.keymap.set("n", "<leader>ds", ":Dotnet solution<CR>", noremap)
vim.keymap.set("n", "<leader>dp", ":Dotnet projects<CR>", noremap)
vim.keymap.set("n", "<leader>dh", ":Dotnet history<CR>", noremap)
vim.keymap.set("n", "<leader>dl", ":Dotnet last_cmd<CR>", noremap)
vim.keymap.set("n", "<leader>dt", ":Dotnet tests<CR>", noremap)
