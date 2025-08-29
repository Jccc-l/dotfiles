-- C/C++: 2 spaces
vim.api.nvim_create_autocmd({"BufRead","BufNewFile"}, {
	pattern = "*.c",
	callback = function()
		print("🔧 FileType 'c' triggered!")
		vim.opt_local.shiftwidth = 2
		vim.opt_local.tabstop = 2
		vim.opt_local.expandtab = true
		vim.opt_local.softtabstop = 2
	end,
})

vim.api.nvim_create_autocmd({"BufRead","BufNewFile"}, {
	pattern = "*.cpp",
	callback = function()
		print("🔧 FileType 'cpp' triggered!")
		vim.opt_local.shiftwidth = 2
		vim.opt_local.tabstop = 2
		vim.opt_local.expandtab = true
		vim.opt_local.softtabstop = 2
	end,
})

-- Python: 4 spaces
vim.api.nvim_create_autocmd({"BufRead","BufNewFile"}, {
	pattern = "*.python",
	callback = function()
		print("🔧 FileType 'python' triggered!")
		vim.opt_local.shiftwidth = 4
		vim.opt_local.tabstop = 4
		vim.opt_local.expandtab = true
		vim.opt_local.softtabstop = 4
	end,
})

-- Lua: 使用制表符，显示为 4 列宽
vim.api.nvim_create_autocmd({"BufRead","BufNewFile"}, {
	pattern = "*.lua",
	callback = function(args)
		-- 执行你的设置
		print("🔧 FileType 'lua' triggered!")
		vim.opt_local.shiftwidth = 4
		vim.opt_local.tabstop = 4
		vim.opt_local.expandtab = false
		vim.opt_local.softtabstop = 4
	end,
})
