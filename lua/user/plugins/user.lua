--- User configured plugins
return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = "BufRead",
    config = function()
      require("mason-tool-installer").setup {
        ensure_installed = {},
      }
    end,
  },

  {
    "rescript-lang/vim-rescript",
    event = "BufRead",
  },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function() require("todo-comments").setup {} end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = { default_source = "filesystem" }, -- you can choose a specific source `last` here which indicates the last used source
  },
  {
    "gorbit99/codewindow.nvim",
    config = function()
      local codewindow = require "codewindow"
      codewindow.setup()
    end,
  },
  {
    "nvim-telescope/telescope-symbols.nvim",
    opts = {
      sources = {
        "emoji",
        "kamoji",
        "gitmoji",
      },
    },
  },
  {
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    build = "deno task --quiet build:fast",
    config = function()
      require("peek").setup()
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
  },
  { "ellisonleao/glow.nvim", config = true, cmd = "Glow" },
}
