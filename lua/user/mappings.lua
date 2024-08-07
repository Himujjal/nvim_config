local codewindow = require "codewindow"
local heirline = require "astronvim.utils.status"
local buffer = require "astronvim.utils.buffer"

return {
  n = {
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        heirline.heirline.buffer_picker(function(bufnr) require("astronvim.utils.buffer").close(bufnr) end)
      end,
      desc = "Pick to close",
    },
    ["<leader>E"] = { ":Telescope emoji<cr>", desc = "Emoji Picker in Telescope" },
    ["<leader>b"] = { name = "Buffers" },
    ["zz"] = { ":w<cr>", desc = "Save File" }, -- change description but the same command
    ["<leader>Ft"] = { ":FormatWrite<cr>", desc = "Format file" },
    ["<leader>md"] = { ":Glow<cr>", desc = "View Markdown Preview" },
    ["<leader>mp"] = {
      function()
        local peek = require "peek"
        if peek.is_open() then
          peek.close()
        else
          peek.open()
        end
      end,
      desc = "Markdown Peek toggle (new window)",
    },
    ["<c-c>"] = { ":%y+<cr><cr>", desc = "Copy file content", silent = true }, -- copies the file contents and then returns back to the position it was in
    ["<leader>mo"] = { function() codewindow.open_minimap() end, desc = "Open minimap" },
    ["<leader>mc"] = { function() codewindow.close_minimap() end, desc = "Close the minimap" },
    ["<leader>mf"] = { function() codewindow.toggle_focus() end, desc = " focus/Nfocus the minimap" },
    ["<leader>mm"] = { function() codewindow.toggle_minimap() end, desc = "Toggle the minimap" },

    ["<leader>ge"] = { ":ChatGPT<cr>", desc = "Open GPT prompt" },

    ["<C-g>t"] = { "<cmd>GpChatToggle popup<cr>", desc = "Toggle ChatGPT" },

    ["}"] = { function() buffer.nav(1) end, desc = "Next buffer" },
    ["{"] = { function() buffer.nav(-1) end, desc = "Prev buffer" },
  },
  t = {},
  v = {
    -- search in visual mode
    ["/"] = { [[y/\V<C-R>=escape(@",'/\')<CR><CR>]], silent = true, desc = "Search in visual mode" },

    ["<leader>ge"] = {
      [[:<BS><BS><BS><BS><BS>ChatGPTEditWithInstructions<cr>]],
      desc = "ChatGPT Instruction for the code",
    },

    ["<C-g>t"] = { ":GpChatToggle popup<cr>", desc = "Toggle Chat (Visual)" },
  },
}
