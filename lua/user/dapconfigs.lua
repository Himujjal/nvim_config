return function()
  local dap = require "dap"

  dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    enrich_config = function(config, on_config) end,
    executable = {
      command = "codelldb",
      args = { "--port", "${port}" },
    },
  }

  dap.configurations.rust = {
    {
      type = "codelldb",
      name = "Debug",
      request = "launch",
      program = function()
        local output = vim.fn.systemlist "cargo build -q --message-format=json"
        for _, l in ipairs(output) do
          local json = vim.json.decode(l)
          if json == nil then error "error parsing json" end
          if json.success == false then return error "error building package" end
          if json.executable ~= nil then
            vim.notify("DAP Running " .. json.executable)
            return json.executable
          end
        end
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      -- terminal = "integrated",
      sourceLanguages = { "rust" },
      stopOnEntry = false,
      showDisassemblyl = "never",
      args = {},
    },
  }

  return {
    adapters = {
      codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = "codelldb",
          args = { "--port", "${port}" },
          detached = vim.fn.has "win32" == 1,
        },
      },
    },
    configurations = {
      zig = {
        {
          type = "codelldb",
          name = "Debug",
          request = "launch",
          -- program = function() return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file") end,
          program = function()
            vim.fn.jobstart("zig build-exe", { cwd = vim.fn.getcwd() })
            local output = vim.fn.getcwd() .. "/zig-out/bin/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
            return output
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
          runInTerminal = false,
          showDisassembly = "never",
        },
      },
      rust = dap.configurations.rust,
    },
  }
end
