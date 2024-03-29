local neovide = require "user.neovide"
local nvimQt = require "user.nvim-qt"
local dapconfigs = require "user.dapconfigs"

-- Desc: This file is executed after the config has been initialized ---
return function()
  vim.api.nvim_set_option("fixendofline", false)
  -- Set up custom filetypes
  vim.filetype.add {
    extension = {
      zon = "zig",
      postcss = "scss",
    },
  }

  -- colorScheme aucommand to disable semantic highlighting from LSP - improves performance
  vim.api.nvim_create_autocmd("BufEnter", {
    pattern = { "*.tsx", "*.ts" },
    callback = function()
      for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
        vim.api.nvim_set_hl(0, group, {})
      end
    end,
  })

  -- neovide in [neovide.lua](./neovide.lua)
  if vim.g.neovide then neovide() end

  if vim.g.nvim_qt then nvimQt() end

  dapconfigs()
end
