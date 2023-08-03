return {
    dap = {
        adapters = {
            type = "executable",
            command = "codelldb",
            args = {"--port", "13000"},
        },
        configurations = {
            zig = {
                {
                    type = "codelldb",
                    name = "Debug",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                    args = {},
                    runInTerminal = false,
                },
            },
        },
    },
}
