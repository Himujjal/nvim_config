--------  lspconfig settings  --------

local zls = function()
  -- -- This is a hack to disable parse errors: See: [ZLS Split Window](https://github.com/zigtools/zls/issues/856)
  vim.g.zig_fmt_parse_errors = 0
  return {
    cmd = { "zls" },
    filetypes = { "zig", "zir", "zon" },
    root_dir = require("lspconfig.util").root_pattern "zig,zon,zir",
  }
end

local v_analyzer = function()
  return {
    cmd = { "v-analyzer" },
    filetypes = { "v", "vlang", "vsh", "vv" },
    root_dir = require("lspconfig.util").root_pattern("v.mod", ".git"),
  }
end

local tailwindcss = function()
  return {
    root_dir = require("lspconfig.util").root_pattern(
      "tailwind.config.js",
      "tailwind.config.ts",
      "tailwind.config.cjs"
    ),
  }
end

local tsserver = function()
  return {
    single_file_support = false,
    semanticTokensProvider = nil,
    settings = {
      typescript = {
        inlayHints = {
          includeInlayParameterNameHints = "literal",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = false,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
      javascript = {
        inlayHints = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
    },
  }
end

local svelte = function()
  return {
    on_attach = function(client)
      vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = { "*.js", "*.ts" },
        callback = function(ctx) client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file }) end,
      })
    end,
  }
end

return {
  -- enable servers that you already have installed without mason
  servers = { "zls", "v_analyzer" },
  formatting = {
    format_on_save = true,
  },
  config = {
    clangd = { capabilities = { offsetEncoding = "utf-8" } },
    zls = zls,
    v_analyzer = v_analyzer,
    tsserver = tsserver,
    tailwindcss = tailwindcss,
    svelte = svelte,
  },
}
