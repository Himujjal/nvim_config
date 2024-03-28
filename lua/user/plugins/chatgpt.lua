local env = require "user.env"
local OPENAI_API_HOST = "https://api.groq.com/openai"

return {
  "jackMort/ChatGPT.nvim",
  event = "VeryLazy",
  config = function()
    -- setfenv("OPENAI_API_KEY", env.GPT_KEY)
    vim.env.OPENAI_API_KEY = env.GPT_KEY
    vim.env.OPENAI_API_HOST = OPENAI_API_HOST
    require("chatgpt").setup {
      keymaps = {
        close = "q",
      },
      api_key_cmd = "echo $OPENAI_API_KEY",
      openai_params = {
        model = "mixtral-8x7b-32768",
        frequency_penalty = 0,
        presence_penalty = 0,
        max_tokens = 3000,
        temperature = 0,
        top_p = 1,
        n = 1,
      },
      openai_edit_params = {
        model = "mixtral-8x7b-32768",
        frequency_penalty = 0,
        presence_penalty = 0,
        temperature = 0,
        top_p = 1,
        n = 1,
      },
    }
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "folke/trouble.nvim",
    "nvim-telescope/telescope.nvim",
  },
}
