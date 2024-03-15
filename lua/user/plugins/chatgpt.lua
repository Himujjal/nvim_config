local env = require "user.env"

return {
  "jackMort/ChatGPT.nvim",
  event = "VeryLazy",
  config = function()
    -- setfenv("OPENAI_API_KEY", env.GPT_KEY)
    vim.env.OPENAI_API_KEY = env.GPT_KEY
    require("chatgpt").setup {
      keymaps = {
        close = "q",
      },
      api_key_cmd = "echo $OPENAI_API_KEY",
    }
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "folke/trouble.nvim",
    "nvim-telescope/telescope.nvim",
  },
}
