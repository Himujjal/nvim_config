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

local biome = function()
  local root_pattern = require("lspconfig.util").root_pattern
  local root_dir = root_pattern("biome.json", "biome.jsonc")
  local is_biome_to_be_used = function()
    local cwd = vim.fn.getcwd()
    return root_dir(cwd) ~= nil
  end
  return {
    cmd = { "biome", "lsp-proxy" },
    formatting = {
      format_on_save = is_biome_to_be_used(),
      timeout_ms = 3200
    },
    filetypes = { "javascript", "javascriptreact", "json", "jsonc", "typescript", "typescript.tsx", "typescriptreact", "astro", "svelte", "vue", "css" },
    root_dir = require("lspconfig.util").root_pattern("biome.json", "biome.jsonc"),
    single_file_support = false,
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

local prettier = function()
  return {
    root_dir = require("lspconfig.util").root_pattern(
      ".prettierrc",
      ".prettierrc.json",
      ".prettierrc.json5",
      ".prettierrc.yaml",
      ".prettierrc.yml",
      ".prettierrc.js",
      ".prettierrc.cjs",
      ".prettierrc.toml"
    ),
  }
end

local tsserver = function()
  return {
    root_dir = require("lspconfig.util").root_pattern "package.json",
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

local denols = function()
  return { root_dir = require("lspconfig.util").root_pattern "deno.json", "deno.jsonc", }
end

return {
  -- enable servers that you already have installed without mason
  servers = { "zls", "v_analyzer", "biome" },
  config = {
    clangd = { capabilities = { offsetEncoding = "utf-8" } },
    zls = zls,
    -- DENO
    denols = denols,
    v_analyzer = v_analyzer,
    tsserver = tsserver,
    tailwindcss = tailwindcss,
    svelte = svelte,
    biome = biome,
    -- prettier = prettier,
  },
}
