-- TODO Working
return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
  {
    "ellisonleao/glow.nvim",
    event = "BufRead",
    config = function()
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
        -- ensure_installed = { "glow" },
      }
    end,
  },

  {
    "rescript-lang/vim-rescript",
    event = "BufRead",
  },
  {
    "nvim-treesitter/playground",
    event = "BufRead",
    config = function()
      require("nvim-treesitter.configs").setup {
        playground = {
          enable = true,
          disable = {},
          updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
          persist_queries = false, -- Whether the query persists across vim sessions
          keybindings = {
            toggle_query_editor = "o",
            toggle_hl_groups = "i",
            toggle_injected_languages = "t",
            toggle_anonymous_nodes = "a",
            toggle_language_display = "I",
            focus_language = "f",
            unfocus_language = "F",
            update = "R",
            goto_node = "<cr>",
            show_help = "?",
          },
        },
      }
    end,
  },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function() require("todo-comments").setup {} end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      sources = {
        "filesystem",
        "buffers",
        "git_status",
        "document_symbols",
      },
      default_source = "filesystem", -- you can choose a specific source `last` here which indicates the last used source
    },
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
        "emoji", "kamoji", "gitmoji"
      },
    }
  },
}
