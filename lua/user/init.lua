local cmd = vim.cmd
local neovide = require "user.neovide"
local nvimQt = require "user.nvim-qt"

-- HACK Work
return {
  -- Configure AstroNvim updates
  updater = {
    remote = "origin", -- remote to use
    channel = "stable", -- "stable" or "nightly"
    version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "nightly", -- branch name (NIGHTLY ONLY)
    commit = nil, -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false, -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_quit = false, -- automatically quit the current session after a successful update
    remotes = { -- easily add new remotes to track
      --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
      --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
      --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    },
  },
  -- Set colorscheme to use
  colorscheme = "astrotheme",
  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = true,
    underline = true,
  },
  lsp = {
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
      tsserver = {
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
        -- root_dir = function(...) return require("lspconfig.util").root_pattern ".git"(...) end,
      },
      tailwindcss = {
        -- root_dir = function(...) return require("lspconfig.util").root_pattern ".git"(...) end,
      },
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
  },

  -- Configure require("lazy").setup() options
  lazy = {
    defaults = { lazy = true },
    performance = {
      rtp = {
        -- customize default disabled vim plugins
        disabled_plugins = { "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin" },
      },
    },
  },
  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
    vim.api.nvim_set_option("fixendofline", false)
    -- Set up custom filetypes
    vim.filetype.add {
      extension = {
        zon = "zig",
        postcss = "scss",
      },
    }

    -- colorScheme aucommand to disable semantic highlighting from LSP - improves performance
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = { "*.tsx", "*.ts" },
      callback = function()
        for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
          vim.api.nvim_set_hl(0, group, {})
        end
      end,
    })

    -- neovide in [neovide.lua](./neovide.lua)
    if vim.g.neovide then neovide() end

    if vim.g.nvim_qt then nvimQt() end
  end,
}
