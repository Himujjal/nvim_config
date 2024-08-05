--- User configured plugins
return {
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

  {
    "supermaven-inc/supermaven-nvim",
    event = "BufRead",
    config = function()
      require("supermaven-nvim").setup {
        keymaps = {
          accept_suggestion = "<C-l>",
          accept_word = "<C-k>",
          clear_suggestion = "<C-c>",
        },
        ignore_filetypes = { cpp = true },
        color = {
          suggestion_color = "#ffffff",
          cterm = 244,
        },
        disable_inline_completion = false, -- disables inline completion for use with cmp
        disable_keymaps = false,           -- disables built in keymaps for more manual control
        log_level = "off",
      }
    end,
  },
}
