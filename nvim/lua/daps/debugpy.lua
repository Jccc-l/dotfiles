local dap = require("dap")

-- 自动检测 Python 解释器路径（支持 Conda、venv、.venv）
local function get_python_path()
	-- 1. 检查 VIRTUAL_ENV（conda activate 会设置这个）
	local virtual_env = os.getenv("VIRTUAL_ENV")
	if virtual_ctx then
		return virtual_env .. "/bin/python"
	end

	-- 2. 检查 conda envs（如果通过 conda activate 激活，PATH 中第一个 python 通常是当前 env 的）
	-- 或者检查 CONDA_PREFIX（更可靠）
	local conda_prefix = os.getenv("CONDA_PREFIX")
	if conda_prefix then
		return conda_prefix .. "/bin/python"
	end

	-- 3. 检查本地 venv/.venv
	local cwd = vim.fn.getcwd()
	local candidates = {
		cwd .. "/venv/bin/python",
		cwd .. "/.venv/bin/python",
	}
	for _, path in ipairs(candidates) do
		if vim.fn.executable(path) == 1 then
			return path
		end
	end

	-- 4. fallback
	return "python3"
end

-- 配置 adapter：使用当前环境的 python -m debugpy.adapter
dap.adapters.python = function(callback, config)
	if config.request == "attach" then
		local port = (config.connect or config).port
		local host = (config.connect or config).host or "127.0.0.1"
		callback({
			type = "server",
			port = assert(port, "`connect.port` is required for attach"),
			host = host,
			options = { source_filetype = "python" },
		})
	else
		local python_path = get_python_path()
		callback({
			type = "executable",
			command = python_path,
			args = { "-m", "debugpy.adapter" },
			options = { source_filetype = "python" },
		})
	end
end

-- 配置 launch/attach
dap.configurations.python = {
	{
		type = "python",
		request = "launch",
		name = "Launch current file",
		program = "${file}",
		console = "integratedTerminal",
		justMyCode = true,
		pythonPath = get_python_path, -- 复用同一个函数
	},
	{
		type = "python",
		request = "attach",
		name = "Attach to remote (e.g., Flask, Django)",
		connect = { host = "127.0.0.1", port = 5678 },
		pathMappings = {
			{ localRoot = vim.fn.getcwd(), remoteRoot = "." },
		},
	},
}
