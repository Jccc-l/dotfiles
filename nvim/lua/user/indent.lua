-- 文件类型缩进配置
local filetype_indent = {
	c = 2,
	cpp = 2,
	java = 2,
	python = 4,
	markdown = 8,
	lua = 8,
}

-- 创建自动命令，当打开特定文件类型时设置缩进
for filetype, indent_size in pairs(filetype_indent) do
	vim.api.nvim_create_autocmd("FileType", {
		pattern = filetype,
		callback = function()
			-- 设置缓冲区局部选项
			if indent_size == 8 then
				vim.bo.shiftwidth = 4
				vim.bo.tabstop = 4
				vim.bo.expandtab = false
			else
				vim.bo.shiftwidth = indent_size
				vim.bo.tabstop = indent_size
				vim.bo.expandtab = true
			end
		end,
	})
end

-- 对于未指定的文件类型，使用 Tab 缩进
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*", -- 匹配所有文件类型
	callback = function()
		local buf_filetype = vim.bo.filetype
		local is_special = false

		-- 检查当前文件类型是否已被特别处理
		for filetype, _ in pairs(filetype_indent) do
			if buf_filetype == filetype then
				is_special = true
				break
			end
		end

		-- 如果当前文件类型没有被特别处理，则应用默认的Tab缩进规则
		if not is_special then
			vim.bo.shiftwidth = 4
			vim.bo.tabstop = 4
			vim.bo.expandtab = true
		end
	end,
})

-- 为未指定的文件类型设置默认缩进配置
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*", -- 匹配所有文件类型
	callback = function()
		local ft = vim.bo.filetype
		-- 检查当前文件类型是否已经在前面定义了配置
		if not filetype_indent[ft] then
			-- 如果是未定义的文件类型，则应用默认设置
			vim.bo.shiftwidth = 4 -- 默认缩进大小
			vim.bo.tabstop = 4 -- 默认Tab宽度
			vim.bo.expandtab = false -- 使用空格代替Tab
		end
	end,
})
