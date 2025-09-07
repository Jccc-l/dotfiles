return {
	"mfussenegger/nvim-dap",
	config = function()
		local dap = require("dap")
		-- 获取当前 Python 解释器路径（支持 Conda 和 venv）
		local function get_python_path()
			-- 1. 检查 Conda 环境（Miniconda/Anaconda）
			local conda_env = os.getenv("CONDA_DEFAULT_ENV")
			local conda_prefix = os.getenv("CONDA_PREFIX")

			if conda_env and conda_env ~= "" then
				-- 在 Conda 环境中，返回该环境的 python 路径
				return conda_prefix .. "/bin/python"
			end

			-- 2. 检查 venv/virtualenv
			local venv = os.getenv("VIRTUAL_ENV")
			if venv then
				return venv .. "/bin/python"
			end

			-- 3. 检查项目目录下的 .venv 或 venv
			if vim.fn.executable(".venv/bin/python") == 1 then
				return ".venv/bin/python"
			end
			if vim.fn.executable("venv/bin/python") == 1 then
				return "venv/bin/python"
			end

			-- 4. 默认回退到系统 python
			return "python"
		end

		-- === DAP Adapter ===
		dap.adapters.cppdbg = {
			id = "cppdbg",
			type = "executable",
			command = "/home/jccc/.local/share/nvim/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
		}

		dap.adapters.python = function(cb, config)
			local python_path = get_python_path()

			if config.request == "attach" then
				local port = (config.connect or config).port
				local host = (config.connect or config).host or "127.0.0.1"
				cb({
					type = "server",
					port = assert(port, "`connect.port` is required for attach"),
					host = host,
					options = {
						source_filetype = "python",
					},
				})
			else
				cb({
					type = "executable",
					command = python_path,
					args = { "-m", "debugpy.adapter" },
					options = {
						source_filetype = "python",
					},
				})
			end
		end

		dap.configurations.c = {
			{
				name = "Launch file",
				type = "cppdbg",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopAtEntry = true,
				setupCommands = {
					{
						text = "-enable-pretty-printing",
						description = "enable pretty printing",
						ignoreFailures = false,
					},
				},
			},
			{
				name = "Attach to gdbserver :1234",
				type = "cppdbg",
				request = "launch",
				MIMode = "gdb",
				miDebuggerServerAddress = "localhost:1234",
				miDebuggerPath = "/usr/bin/gdb",
				cwd = "${workspaceFolder}",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				setupCommands = {
					{
						text = "-enable-pretty-printing",
						description = "enable pretty printing",
						ignoreFailures = false,
					},
				},
			},
		}

		-- === DAP Configuration ===
		dap.configurations.cpp = dap.configurations.c
		dap.configurations.rust = dap.configurations.c
		dap.configurations.python = {
			{
				type = "python",
				request = "launch",
				name = "Launch File (Conda-aware)",

				program = "${file}",

				-- 使用我们定义的函数获取正确的 Python 路径
				pythonPath = get_python_path,

				-- 推荐设置
				console = "integratedTerminal", -- 在终端中运行，能看到 print 输出
				justMyCode = false, -- 可选：调试进入第三方库
			},
		}
		local dap_breakpoint_color = {
			breakpoint = {
				ctermbg = 0,
				fg = "#993939",
				bg = "#31353f",
			},
			logpoing = {
				ctermbg = 0,
				fg = "#61afef",
				bg = "#31353f",
			},
			stopped = {
				ctermbg = 0,
				fg = "#98c379",
				bg = "#31353f",
			},
		}

		vim.api.nvim_set_hl(0, "DapBreakpoint", dap_breakpoint_color.breakpoint)
		vim.api.nvim_set_hl(0, "DapLogPoint", dap_breakpoint_color.logpoing)
		vim.api.nvim_set_hl(0, "DapStopped", dap_breakpoint_color.stopped)

		local dap_breakpoint = {
			error = {
				text = "",
				texthl = "DapBreakpoint",
				linehl = "DapBreakpoint",
				numhl = "DapBreakpoint",
			},
			condition = {
				text = "ﳁ",
				texthl = "DapBreakpoint",
				linehl = "DapBreakpoint",
				numhl = "DapBreakpoint",
			},
			rejected = {
				text = "",
				texthl = "DapBreakpint",
				linehl = "DapBreakpoint",
				numhl = "DapBreakpoint",
			},
			logpoint = {
				text = "",
				texthl = "DapLogPoint",
				linehl = "DapLogPoint",
				numhl = "DapLogPoint",
			},
			stopped = {
				text = "",
				texthl = "DapStopped",
				linehl = "DapStopped",
				numhl = "DapStopped",
			},
		}

		vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
		vim.fn.sign_define("DapBreakpointCondition", dap_breakpoint.condition)
		vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)
		vim.fn.sign_define("DapLogPoint", dap_breakpoint.logpoint)
		vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
	end,
}
