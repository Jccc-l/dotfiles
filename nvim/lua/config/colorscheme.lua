-- ~/.config/nvim/init.lua

-- 加载你的颜色管理模块
local colors = require("colors")

-- 设置默认主题
colors.set("snazzy")

-- 可选：创建命令方便切换
vim.api.nvim_create_user_command("ColorScheme", function(opts)
	colors.set(opts.args)
end, {
	nargs = 1,
	complete = function()
		return { "dracula", "snazzy", "solarized", "solarized_light" } -- 补全建议
	end,
})
