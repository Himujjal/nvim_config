local get_current_buffer_file_path = function() return vim.api.nvim_buf_get_name(0) end

local escape_path = function(arg) return vim.fn.shellescape(arg, true) end

return {
  "mhartington/formatter.nvim",
  event = "User AstroFile",
  config = function()
    -- local func = require("user.plugins.formatter_config")
    require("formatter").setup {
      filetype = {
        lua = { require("formatter.filetypes.lua").stylua },
        json = {
          require("formatter.filetypes.json").prettier,
        },
        json5 = {
          require("formatter.filetypes.javascript").prettier,
        },
        html = {
          require("formatter.filetypes.html").prettier,
        },
        css = {
          require("formatter.filetypes.css").prettier,
        },
        javascript = {
          require("formatter.filetypes.javascript").prettier,
          format_on_save = false,
        },
        javascriptreact = {
          require("formatter.filetypes.javascriptreact").prettier,
          format_on_save = false,
        },
        typescript = {
          require("formatter.filetypes.typescript").prettier,
          format_on_save = false,
        },
        typescriptreact = {
          require("formatter.filetypes.typescriptreact").prettier,
          format_on_save = false,
        },
        svelte = {
          require("formatter.filetypes.svelte").prettier,
        },
        go = {
          require("formatter.filetypes.go").gofmt,
        },
        rust = {
          require("formatter.filetypes.rust").rustfmt,
        },
        zig = {
          require("formatter.filetypes.zig").zigfmt,
        },
        c = {
          function()
            return {
              exe = "clang-format",
              args = { "-assume-filename=", escape_path(get_current_buffer_file_path()) },
              stdin = true,
            }
          end,
        },
        cpp = {
          function() return { exe = "clang-format", args = { "-" }, stdin = true } end,
        },
      },
    }
    --
  end,
}
