local cmd = vim.cmd
local neovide = require "user.neovide"
local nvimQt = require "user.nvim-qt"
local lspconfigs = require "user.lspconfigs"
local dapconfigs = require "user.dapconfigs"

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

  heirline = {
    colors = {
      -- buffer_active_fg = "#ffffff",
      -- buffer_active_path_fg = "#ffff00",
      buffer_active_bg = "#141414",
    },
  },

  -- see: /lua/user/dapconfigs.lua ---
  -- dap = dapconfigs(),

  -- see: /lua/user/lspconfigs.lua ---
  lsp = lspconfigs,

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

    dapconfigs()
  end,
}
