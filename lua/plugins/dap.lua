return {
	"mfussenegger/nvim-dap",
	event = "VeryLazy",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"jay-babu/mason-nvim-dap.nvim",
		"theHamsta/nvim-dap-virtual-text",
	},
	config = function()
		local mason_dap = require("mason-nvim-dap")
		local dap = require("dap")
		local ui = require("dapui")
		local dap_virtual_text = require("nvim-dap-virtual-text")

		-- Dap Virtual Text
		dap_virtual_text.setup()

		mason_dap.setup({
			ensure_installed = { "codelldb" },
			automatic_installation = true,
			handlers = {
				function(config)
					require("mason-nvim-dap").default_setup(config)
				end,
			},
		})

		--
		-- Dap adapter
		--
		dap.adapters.codelldb = {
			type = "executable",
			command = "codelldb",
		}

		--
		-- Configurations
		--
		dap.configurations.cpp = {
			{
				name = "Launch file",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
			},
		}
		dap.configurations.c = dap.configurations.cpp

		-- dap.configurations = {
		-- 	c = {
		-- 		{
		-- 			name = "Launch file",
		-- 			type = "codelldb",
		-- 			request = "launch",
		-- 			program = function()
		-- 				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		-- 			end,
		-- 			cwd = "${workspaceFolder}",
		-- 			stopAtEntry = true,
		-- 			MIMode = "lldb",
		-- 		},
		-- 		{
		-- 			name = "Attach to lldbserver :1234",
		-- 			type = "codelldb",
		-- 			request = "launch",
		-- 			MIMode = "lldb",
		-- 			miDebuggerServerAddress = "localhost:1234",
		-- 			miDebuggerPath = "/usr/bin/lldb",
		-- 			cwd = "${workspaceFolder}",
		-- 			program = function()
		-- 				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		-- 			end,
		-- 		},
		-- 	},
		-- 	cpp = {
		-- 		{
		-- 			name = "Launch file",
		-- 			type = "codelldb",
		-- 			request = "launch",
		-- 			program = function()
		-- 				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		-- 			end,
		-- 			cwd = "${workspaceFolder}",
		-- 			stopAtEntry = true,
		-- 			MIMode = "lldb",
		-- 		},
		-- 		{
		-- 			name = "Attach to lldbserver :1234",
		-- 			type = "codelldb",
		-- 			request = "launch",
		-- 			MIMode = "lldb",
		-- 			miDebuggerServerAddress = "localhost:1234",
		-- 			miDebuggerPath = "/usr/bin/lldb",
		-- 			cwd = "${workspaceFolder}",
		-- 			program = function()
		-- 				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		-- 			end,
		-- 		},
		-- 	},
		-- }

		-- Dap UI
		ui.setup({
			expand_lines = true,
			icons = { expanded = "", collapsed = "", circular = "" },
			mappings = {
				-- Use a table to apply multiple mappings
				expand = { "<CR>", "<2-LeftMouse>" },
				open = "o",
				remove = "d",
				edit = "e",
				repl = "r",
				toggle = "t",
			},
			layouts = {
				{
					elements = {
						{ id = "scopes", size = 0.33 },
						{ id = "breakpoints", size = 0.17 },
						{ id = "stacks", size = 0.25 },
						{ id = "watches", size = 0.25 },
					},
					size = 0.33,
					position = "right",
				},
				{
					elements = {
						{ id = "repl", size = 0.45 },
						{ id = "console", size = 0.55 },
					},
					size = 0.27,
					position = "bottom",
				},
			},
			floating = {
				max_height = 0.9,
				max_width = 0.5, -- Floats will be treated as percentage of your screen.
				border = vim.g.border_chars, -- Border style. Can be 'single', 'double' or 'rounded'
				mappings = {
					close = { "q", "<Esc>" },
				},
			},
		})

		vim.fn.sign_define("DapBreakpoint", { text = "B" })

		dap.listeners.before.attach.dapui_config = function()
			ui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			ui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			ui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			ui.close()
		end
	end,
}
