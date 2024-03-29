local lspconfigs = require "user.lspconfigs"
local post_init = require "user.post_init"

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
    remotes = {}, -- easily add new remotes to track
  },
  colorscheme = "astrotheme",
  diagnostics = {
    virtual_text = true,
    underline = true,
  }, -- vim.diagnostics.config({...})

  heirline = {
    colors = { buffer_active_bg = "#141414" },
  },

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
  polish = post_init, -- run after the config has been initialized
}
