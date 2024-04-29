local neovide = require "user.neovide"
local nvimQt = require "user.nvim-qt"
local dapconfigs = require "user.dapconfigs"

-- Format on save
local enable_format_on_save = function(pattern)
  local _pattern = pattern or { "*.go", "*.rs", "*.lua", "*.tsx", "*.ts" }
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = _pattern,
    callback = function() vim.lsp.buf.format { async = false } end,
  })
end

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

  vim.filetype.add {
    extension = {
      v = "vlang",
    },
  }

  -- comment/uncomment based on your preference
  -- enable_format_on_save()

  -- neovide in [neovide.lua](./neovide.lua)
  if vim.g.neovide then neovide() end

  if vim.g.nvim_qt then nvimQt() end

  dapconfigs()
end
