local get_current_buffer_file_path = function()
	return vim.api.nvim_buf_get_name(0)
end

local escape_path = function(arg)
	return vim.fn.shellescape(arg, true)
end

return {
	"mhartington/formatter.nvim",
	event = "User AstroFile",
	config = function()
		-- local func = require("user.plugins.formatter_config")
		require("formatter").setup({
			filetype = {
				lua = { require("formatter.filetypes.lua").stylua },
				json = {
					require("formatter.filetypes.javascript").prettierd,
				},
				-- json5 = {
				-- 	function()
				-- 		return { exe = "formatjson5", args = { "-" }, stdin = true }
				-- 	end,
				-- },
				javascript = {
					-- require("formatter.filetypes.javascript").prettiereslint,
					require("formatter.filetypes.javascript").prettierd,
				},
				javascriptreact = {
					-- require("formatter.filetypes.javascriptreact").prettiereslint,
					require("formatter.filetypes.javascriptreact").prettierd,
				},
				typescript = {
					-- require("formatter.filetypes.typescript").prettiereslint,
					require("formatter.filetypes.typescript").prettierd,
				},
				typescriptreact = {
					-- require("formatter.filetypes.typescriptreact").prettiereslint,
					require("formatter.filetypes.typescriptreact").prettierd,
				},
				svelte = {
					require("formatter.filetypes.svelte").prettierd,
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
					function()
						return { exe = "clang-format", args = { "-" }, stdin = true }
					end,
				},
			},
		})
		--
	end,
}
