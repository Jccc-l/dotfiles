local function set_indent(tab_width, use_spaces)
	vim.opt_local.tabstop = tab_width -- 一个 <Tab> 显示空格数
	vim.opt_local.shiftwidth = tab_width -- 自动缩进时使用空格数
	vim.opt_local.softtabstop = tab_width -- 按下 <Tab> 时插入的空格数量
	vim.opt_local.expandtab = use_spaces -- 输入 <Tab> 时是否转换为空格
end

vim.api.nvim_create_autocmd("Filetype", {
	pattern = "lua",
	callback = function()
		set_indent(4, false)
	end,
})

vim.api.nvim_create_autocmd("Filetype", {
	pattern = { "c", "cpp" },
	callback = function()
		set_indent(2, true)
	end,
})

vim.api.nvim_create_autocmd("Filetype", {
	pattern = { "java" },
	callback = function()
		set_indent(4, true)
	end,
})
