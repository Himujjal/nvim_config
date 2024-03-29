return {
  "jose-elias-alvarez/null-ls.nvim",
  opts = function(_, config)
    local null_ls = require "null-ls"

    -- Check supported formatters and linters
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    config.sources = {
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.prettier.with { filetypes = { "svelte" } },
      null_ls.builtins.formatting.gofmt,
      null_ls.builtins.formatting.rustfmt,
      null_ls.builtins.formatting.clang_format,
    }
    return config -- return final config table
  end,
}
