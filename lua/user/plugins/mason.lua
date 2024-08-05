return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = {
      ensure_installed = {
        "clangd",
        "lua_ls",
        "tsserver",
        "rust_analyzer",
        "tailwindcss",
        "gopls",
        "svelte"
      },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
      ensure_installed = { "codelldb" },
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = "BufRead",
    config = function()
      require("mason-tool-installer").setup {
        ensure_installed = {
          "biome",
          "eslint-lsp"
        },
      }
    end,
  },
}

-- ✓ biome
-- ✓ clangd
-- ✓ eslint-lsp
-- ✓ gopls
-- ✓ lua-language-server
-- ✓ rust-analyzer
-- ✓ svelte-language-server
-- ✓ tailwindcss-language-server
-- ✓ typescript-language-server
