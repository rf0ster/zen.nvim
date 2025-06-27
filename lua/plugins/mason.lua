return {
  "williamboman/mason.nvim",
  build = ":MasonUpdate",
  event = "BufReadPre",
  cmd = "Mason",
  version = "^1.0.0",
  dependencies = {
    { "williamboman/mason-lspconfig.nvim", version = "^1.0.0" },
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",

    -- Type definitions, references and implementation popus.
    "nvimdev/lspsaga.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons"
  },
  config = function()
    -- Mason ensures LSPs are installed
    require("mason").setup({
        ui = {
            border = "double",
        }
    })
    require("mason-lspconfig").setup({
      ensure_installed = { "gopls", "lua_ls", "omnisharp" },
      automatic_installation = true,
      automatic_enable = false,
    })

    -- Lspsaga enables all the nice pop ups for
    -- finding references and type defitions.
    require("lspsaga").setup({ lightbulb = { enable = false } })

    local on_attach = function()
      local noremap = { noremap = true, silent = true }
      vim.keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>", noremap)
      vim.keymap.set("n", "gr", "<cmd>Lspsaga finder<CR>", noremap)
      vim.keymap.set("n", "gt", "<cmd>Lspsaga goto_type_definition<CR>", noremap)
      vim.keymap.set("n", "gi", "<cmd>Lspsaga finder imp<CR>", noremap)
      vim.keymap.set("n", "ga", vim.lsp.buf.code_action, noremap)
    end

    local lspconfig = require("lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    require("mason-lspconfig").setup_handlers({

      -- Setup default language server
      function(server_name)
        lspconfig[server_name].setup({
          on_attach = on_attach,
          capabilities = capabilities
        })
      end,

      -- Setup Lua language server
      ["lua_ls"] = function()
        lspconfig.lua_ls.setup({
          on_attach = on_attach,
          capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } }, -- Remove "undefined global 'vim'" warning
              workspace = { checkThirdParty = false },
            }
          }
        })
      end,

      -- Setup golang language service
      ["gopls"] = function()
        lspconfig.gopls.setup({
          on_attach = on_attach,
          capabilities = capabilities,
          settings = {
            gopls = {
              analyses = {
                shadow = true,
              },
              staticcheck = true,
              gofumpt = true, -- Enforce stricter formatting
            }
          }
        })
        end,

        ["omnisharp"] = function()
          lspconfig.omnisharp.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                FormattingOptions = {
                    enableEditorConfigSupport = true,
                    organizeImports = true,
                },
                RoslynExtensionsOptions = {
                    enableImportCompletion = true,
                    enableRoslynAnalyzers = true,
                    enableAnalyzersSupport = true
                }
            }
          })
        end

    })

    local cmp = require("cmp")
    cmp.setup({
      mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),  -- Manually trigger completion
        ["<C-n>"] = cmp.mapping.select_next_item(),  -- Navigate down in menu
        ["<C-p>"] = cmp.mapping.select_prev_item(),  -- Navigate up in menu
        ["<CR>"] = cmp.mapping.confirm({ select = true }),  -- Confirm selection
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),  -- Scroll up in documentation
        ["<C-d>"] = cmp.mapping.scroll_docs(4),  -- Scroll down in documentation
        ["<C-e>"] = cmp.mapping.abort(),  -- Close the completion window and prevent it from reopening
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },  -- LSP Completion Source
      }),
    })
  end,
}
