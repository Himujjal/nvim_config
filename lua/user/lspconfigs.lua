--------  lspconfig settings  --------

return {
  -- customize lsp formatting options
  formatting = {
    -- control auto formatting on save
    format_on_save = {
      -- enabled = false, -- enable or disable format on save globally
      allow_filetypes = { -- enable format on save for specified filetypes only
        "go",
        "rs",
        "lua",
      },
      ignore_filetypes = { -- disable format on save for specified filetypes
        "ts",
        "tsx",
        "zig",
      },
    },
    disabled = { -- disable formatting capabilities for the listed language servers
      -- "sumneko_lua",
    },
    timeout_ms = 3000, -- default format timeout
    -- filter = function(client) -- fully override the default formatting function
    --   return true
    -- end
  },

  -- enable servers that you already have installed without mason
  servers = {
    -- "pyright"
    "zls",
  },
  config = {
    -- gleam = {
    --   cmd = { "gleam", "lsp" },
    --   filetypes = { "gleam" },
    --   root_dir = require("lspconfig").util.root_pattern "gleam.toml",
    -- },
    clangd = {
      capabilities = { offsetEncoding = "utf-8" },
    },
    ["grammarly-languageserver"] = {
      filetypes = { "markdown", "text" },
      init_options = {
        clientId = "client_3NRFeTC4VkXdgqDQieFiJn",
      },
    },
    zls = function()
      -- -- This is a hack to disable parse errors: See: [ZLS Split Window](https://github.com/zigtools/zls/issues/856)
      vim.g.zig_fmt_parse_errors = 0
      return {
        cmd = { "zls" },
        filetypes = { "zig", "zir", "zon" },
        root_dir = function() return vim.fn.getcwd() end,
        settings = {},
      }
    end,
    tsserver = function()
      return {
        single_file_support = false,
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "literal",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = false,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
        },
        -- root_dir = require("lspconfig.util").root_pattern ".git",
      }
    end,
    tailwindcss = function()
      return {
        root_dir = require("lspconfig.util").root_pattern(
          "tailwind.config.js",
          "tailwind.config.ts",
          "tailwind.config.cjs"
        ),
      }
    end,
    svelte = function()
      return {
        on_attach = function(client)
          vim.api.nvim_create_autocmd("BufWritePost", {
            pattern = { "*.js", "*.ts" },
            callback = function(ctx) client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file }) end,
          })
        end,
      }
    end,
  },
}
