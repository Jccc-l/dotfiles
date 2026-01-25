-- ~/.config/nvim/lua/smart_close.lua

local M = {}

-- 定义“可忽略”的文件类型列表（即允许在退出时忽略的窗口）
M.ignored_filetypes = {
	"help",
	"NvimTree",
	"neo-tree",
	"fugitive",
	"gitcommit",
	"git",
	"qf", -- quickfix
	"terminal",
	"Outline",
	"aerial",
	"dapui_.*", -- 支持正则匹配（稍后处理）
	"dapui_console",
	"dapui_watches",
	"dapui_stacks",
	"dapui_breakpoints",
	"dapui_scopes",
	"dap-repl",
	"toggleterm",
	"Trouble",
	"spectre_panel",
}

-- 辅助函数：判断 filetype 是否匹配 ignored 列表（支持字符串或模式）
local function is_ignored_filetype(ft)
	for _, pattern in ipairs(M.ignored_filetypes) do
		if vim.fn.match(ft, pattern) ~= -1 then
			return true
		end
	end
	return false
end

-- 主函数：智能关闭
function M.smart_close()
	local current_win = vim.api.nvim_get_current_win()
	local wins = vim.api.nvim_list_wins()

	-- 如果只有一个窗口，直接尝试退出
	if #wins == 1 then
		vim.cmd("confirm qa")
		return
	end

	-- 检查除当前窗口外，其他窗口是否都是“可忽略”的 filetype
	local all_others_ignored = true
	local non_ignored_count = 0

	for _, win in ipairs(wins) do
		if win ~= current_win then
			local buf = vim.api.nvim_win_get_buf(win)
			local ft = vim.bo[buf].filetype
			if not is_ignored_filetype(ft) then
				all_others_ignored = false
				non_ignored_count = non_ignored_count + 1
			end
		end
	end

	-- 如果其他窗口都是可忽略的 → 尝试退出整个 Neovim
	if all_others_ignored then
		-- 使用 confirm qa：如果有未保存文件会弹出确认，不会强制退出
		vim.cmd("confirm qa")
	else
		-- 否则只关闭当前窗口
		-- 使用 confirm close 避免因未保存而卡住（可选）
		pcall(vim.cmd, "confirm close")
	end
end

return M
