local env = require "user.env"

local API_KEY = env.OPENAI_KEY
local MODEL = "CodeGPT4"
local API_HOST = "https://api.openai.com/v1/chat/completions"

local config = {
  openai_api_key = API_KEY,
  -- api endpoint (you can change this to azure endpoint)
  openai_api_endpoint = API_HOST,
  -- prefix for all commands
  cmd_prefix = "Gp",

  agents = {
    {
      name = "CodeGPT4",
      chat = false,
      command = true,
      -- string with model name or table with model name and parameters
      model = { model = "gpt-4-1106-preview", temperature = 0.8, top_p = 1 },
      -- system prompt (use this to specify the persona/role of the AI)
      system_prompt = "You are an AI working as a code editor.\n\n"
        .. "Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n"
        .. "START AND END YOUR ANSWER WITH:\n\n```",
    },
  },
}

return {
  "robitx/gp.nvim",
  event = "VeryLazy",
  config = function() require("gp").setup(config) end,
}
