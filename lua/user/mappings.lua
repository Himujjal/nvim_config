-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
local cmd = vim.cmd

local function lspQuickFix()
  local opts = { noremap = true, silent = true }
  vim.lsp.buf.code_action {
    filter = function(a) return a.isPreferred end,
    apply = true,
  }
end

return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    -- quick save
    ["zz"] = { ":w<cr>", desc = "Save File" }, -- change description but the same command
    ["<leader>Ft"] = { ":Format<cr>", desc = "Format file" },
    ["<leader>md"] = { ":Glow<cr>", desc = "View Markdown Preview" },
    ["<c-c>"] = { ":%y+<cr><cr>", desc = "Copy file content", silent = true }, -- copies the file contents and then returns back to the position it was in

  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
  v = {
    -- search in visual mode
    ["/"] = { [[y/\V<C-R>=escape(@",'/\')<CR><CR>]], silent = true },
    ["<leader>e"] = {
      [[:<BS><BS><BS><BS><BS>ChatGPTEditWithInstructions<cr>]],
      desc = "ChatGPT Instruction for teh code",
    },
  },
}
