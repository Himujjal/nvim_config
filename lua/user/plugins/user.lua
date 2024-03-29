--- User configured plugins
return {
  {
    "ellisonleao/glow.nvim",
    event = "BufRead",
    config = function()
      --- @diagnostic disable-next-line: missing-fields
      require("glow").setup {
        width = 150,
        height = 80,
        -- width_ratio = 1.0, -- maximum width of the Glow window compared to the nvim window size (overrides `width`)
        -- height_ratio = 0.7,
      }
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = "BufRead",
    config = function()
      require("mason-tool-installer").setup {
        ensure_installed = { "glow" },
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
}
