local options = {
	{ "number", true }, -- 显示行号
	{ "relativenumber", true }, -- 显示相对行号
	{ "tabstop", 4 }, -- 制表符宽度为4个空格
	{ "shiftwidth", 4 }, -- 自动缩进宽度为4个空格

	{ "softtabstop", 4 }, -- 输入tab或Backspace时，插入或删除的空格个数
	{ "expandtab", false }, -- 使用空格代替制表符
	{ "smartindent", true }, -- 智能缩进
	{ "wrap", false }, -- 不自动换行
	{ "cursorline", true }, -- 高亮当前行
	{ "wildmode", "list:longest" }, -- 命令补全模式
	{ "hlsearch", true }, -- 高亮搜索
	{ "background", "dark" }, -- 背景主题
	{ "list", true }, -- 启用显示特殊字符
	{ "scrolloff", 4 },
	{ "sidescrolloff", 6 },
	{ "ignorecase", true },
	{ "smartcase", true },
	{ "breakindent", false }, -- 单行文本截断是否断开单词
	{
		"listchars",
		{
			space = "·", -- 空格显示为点
			tab = "→ ", -- 制表符显示为箭头加空格
			eol = "↵", -- 行尾显示为 ↵
			extends = ">", -- 超出屏幕的字符显示为 >
			precedes = "<", -- 前导字符显示为 <
		},
	},
}

-- 迭代表并应用每个选项
for _, opt in ipairs(options) do
	if type(opt[2]) == "table" then
		local parts = {}
		for k, v in pairs(opt[2]) do
			table.insert(parts, k .. ":" .. v)
		end
		vim.opt[opt[1]] = table.concat(parts, ",")
	else
		vim.opt[opt[1]] = opt[2]
	end
end

vim.o.guicursor =
	[[n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175]]

-- 文件类型缩进配置
local filetype_indent = {
	c = 2,
	cpp = 2,
	java = 2,
	python = 4,
	markdown = 8,
	lua = 8,
}
