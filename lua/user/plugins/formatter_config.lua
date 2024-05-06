local get_current_buffer_file_path = function() return vim.api.nvim_buf_get_name(0) end

local escape_path = function(arg) return vim.fn.shellescape(arg, true) end

local rome = function()
  return {
    exe = "rome",
    args = { "format", "--stdin-file-path=" .. get_current_buffer_file_path() },
    stdin = true,
  }
end

return {
  "mhartington/formatter.nvim",
  event = "User AstroFile",
  config = function()
    -- local func = require("user.plugins.formatter_config")
    require("formatter").setup {
      filetype = {
        lua = { require("formatter.filetypes.lua").stylua },
        json = {
          require("formatter.filetypes.json").biome,
        },
        json5 = {
          require("formatter.filetypes.javascript").biome,
        },
        html = {
          require("formatter.filetypes.html").prettier,
        },
        css = {
          require("formatter.filetypes.css").prettierd,
        },
        javascript = {
          require("formatter.filetypes.javascript").biome,
        },
        javascriptreact = {
          require("formatter.filetypes.javascriptreact").biome,
        },
        typescript = {
          require("formatter.filetypes.typescript").biome,
        },
        typescriptreact = {
          require("formatter.filetypes.typescriptreact").biome,
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
