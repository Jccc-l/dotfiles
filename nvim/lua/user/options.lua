-- 定义一个表来存储所有需要设置的选项
local options = {
	{ "number", true }, -- 显示行号
	{ "relativenumber", true }, -- 显示相对行号
	-- { "tabstop", 4 }, -- 制表符宽度为4个空格
	-- { "shiftwidth", 4 }, -- 自动缩进宽度为4个空格
	{ "smartindent", true }, -- 智能缩进
	{ "wrap", true }, -- 不自动换行
	{ "cursorline", true }, -- 高亮当前行
	{ "wildmode", "list:longest" }, -- 命令补全模式
	{ "hlsearch", true },
	{ "ignorecase", true },
	{ "smartcase", true },
	{ "list", true },
	{ "scrolloff", 4 },
	{ "sidescrolloff", 6 },
	{ "breakindent", false },
	-- { "breakindentopt", "shift:0" },
}

-- 迭代表并应用每个选项
for _, opt in ipairs(options) do
	vim.o[opt[1]] = opt[2]
end

vim.opt.listchars = {
	space = "·",
	tab = "→ ",
	eol = "¬",
	extends = ">",
	precedes = "<",
}
